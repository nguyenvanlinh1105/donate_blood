using HIENMAUNHANDAO.Models;
using HIENMAUNHANDAO.ViewModel;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace HIENMAUNHANDAO.Controllers.User
{
    public class UserController : Controller
    {
        public readonly WebDbContext context;
        [TempData]
        public string statusMessageError { get; set; }

        [TempData]
        public string statusMessageSuccess { get; set; }

        public UserController(WebDbContext context)
        {
            this.context = context;
        }

        public async Task<IActionResult> LichSuHienMau()
        {
            var idNguoiHienMau = HttpContext.Session.GetString("UserId");
            if (idNguoiHienMau == null)
            {
                statusMessageError = "Vui lòng đăng nhập!";
                return RedirectToAction("Login", "Home");
            }

           
            var resutlDDK_SapDienRa = await context.DangKiToChucHienMaus
                .Include(d => d.DangKiHienMaus)
                    .ThenInclude(ng => ng.IdNguoiHienMauNavigation)
                        .ThenInclude(c => c.IdPhuongNavigation)
                            .ThenInclude(p => p.IdQuanNavigation)
                                .ThenInclude(q => q.IdThanhPhoNavigation)
                .Include(d => d.IdCoSoTinhNguyenNavigation)
                .Include(d => d.DangKiHienMaus)
                    .ThenInclude(dk => dk.IdDanhMucDvmauNavigation)
               .Where(d =>
                    d.DangKiHienMaus.Any(dk =>
                        (dk.TrangThaiDonDk == "Chờ duyệt" || dk.TrangThaiDonDk == "Đã duyệt") &&
                        dk.IdNguoiHienMauNavigation.IdNguoiDung == idNguoiHienMau) &&
                    d.TgKetThucSk >= DateTime.Now)
                    .Select(d => new LichSuHienMauViewModel
                    {
                        TenCoSoTinhNguyen = d.IdCoSoTinhNguyenNavigation.TenCoSoTinhNguyen,
                        TrangThaiDDK = d.DangKiHienMaus.FirstOrDefault(dk => dk.IdNguoiHienMauNavigation.IdNguoiDung == idNguoiHienMau).TrangThaiDonDk,
                        DiaChi = d.IdCoSoTinhNguyenNavigation != null && d.IdCoSoTinhNguyenNavigation.IdPhuongNavigation != null
                        ? $"{d.IdCoSoTinhNguyenNavigation.DiaChi}, {d.IdCoSoTinhNguyenNavigation.IdPhuongNavigation.TenPhuong}, {d.IdCoSoTinhNguyenNavigation.IdPhuongNavigation.IdQuanNavigation.TenQuan}, {d.IdCoSoTinhNguyenNavigation.IdPhuongNavigation.IdQuanNavigation.IdThanhPhoNavigation.TenThanhPho}"
                        : "Unknown",
                        ThGianBatDau = d.TgBatDauSk,
                        ThGianKetThuc = d.TgKetThucSk,
                        NgayDangKi = d.NgayDangKi,
                        tinhTrangSucKhoe = d.DangKiHienMaus.FirstOrDefault(dk => dk.IdNguoiHienMauNavigation.IdNguoiDung == idNguoiHienMau).TtsksauHien,
                    })
                .ToListAsync();

            var resutlDDK_DaDienRa = await context.DangKiToChucHienMaus
                .Include(d => d.DangKiHienMaus)
                    .ThenInclude(ng => ng.IdNguoiHienMauNavigation)
                .Include(d => d.DangKiHienMaus)
                    .ThenInclude(dk => dk.IdDanhMucDvmauNavigation)
                .Include(d => d.IdCoSoTinhNguyenNavigation)
                .Where(d =>
                    d.DangKiHienMaus.Any(dk =>
                        (dk.TrangThaiDonDk == "Hoàn thành" || dk.TrangThaiDonDk == "Đã hủy") &&
                        dk.IdNguoiHienMauNavigation.IdNguoiDung == idNguoiHienMau) &&
                    d.TgKetThucSk <= DateTime.Now)

                .Select(d => new LichSuHienMauViewModel
                {
                    TenCoSoTinhNguyen = d.IdCoSoTinhNguyenNavigation.TenCoSoTinhNguyen,
                    TrangThaiDDK = d.DangKiHienMaus.FirstOrDefault(dk => dk.IdNguoiHienMauNavigation.IdNguoiDung == idNguoiHienMau).TrangThaiDonDk ?? "Unknown",
                    DiaChi = (d.IdCoSoTinhNguyenNavigation != null && d.IdCoSoTinhNguyenNavigation.IdPhuongNavigation != null &&
                      d.IdCoSoTinhNguyenNavigation.IdPhuongNavigation.IdQuanNavigation != null &&
                      d.IdCoSoTinhNguyenNavigation.IdPhuongNavigation.IdQuanNavigation.IdThanhPhoNavigation != null)
                      ? $"{d.IdCoSoTinhNguyenNavigation.DiaChi}, {d.IdCoSoTinhNguyenNavigation.IdPhuongNavigation.TenPhuong}, {d.IdCoSoTinhNguyenNavigation.IdPhuongNavigation.IdQuanNavigation.TenQuan}, {d.IdCoSoTinhNguyenNavigation.IdPhuongNavigation.IdQuanNavigation.IdThanhPhoNavigation.TenThanhPho}"
                      : "Unknown",
                    ThGianBatDau = d.TgBatDauSk,
                    ThGianKetThuc = d.TgKetThucSk,
                    NgayDangKi = d.NgayDangKi,
                    tinhTrangSucKhoe = d.DangKiHienMaus.FirstOrDefault(dk => dk.IdNguoiHienMauNavigation.IdNguoiDung == idNguoiHienMau).TtsksauHien ?? "Unknown",
                    SoLuongMauHien = d.DangKiHienMaus.FirstOrDefault(dk => dk.IdNguoiHienMauNavigation.IdNguoiDung == idNguoiHienMau).IdDanhMucDvmauNavigation.SoLuongMau
                })
                .ToListAsync();

            var viewLichSuHienMau = new LichSuHienMau_NguoiDungViewModel
            {
                resutlDDK_DaDienRa = resutlDDK_DaDienRa,
                resutlDDK_SapDienRa = resutlDDK_SapDienRa
            };

            return View(viewLichSuHienMau);
            
           
        }

        [HttpPost]
        public async Task<IActionResult> DangKiHienMau(DangKiHienMauViewModel model)
        {
            if (model == null)
            {
                return View("Index","Home");
            }
            string lastIdDangKiHienMau = context.DangKiHienMaus
                .OrderByDescending(d=>d.IdDangKiHienMau)
                .Select(d=>d.IdDangKiHienMau)
                .FirstOrDefault();

            int newIDDK = 1;

            if (!string.IsNullOrEmpty(lastIdDangKiHienMau)) {
                newIDDK = int.Parse(lastIdDangKiHienMau.Substring(4)) + 1;
            }

            var idNguoiHienMau = HttpContext.Session.GetString("UserId");
            if (idNguoiHienMau == null)
            {
                statusMessageError = "Vui lòng đăng nhập!";
                return RedirectToAction("Login", "Home");
            }

           
            var newDonDK = new DangKiHienMau
            {
                IdDangKiHienMau = $"DKHM{newIDDK:D6}",
                IdNguoiHienMau = idNguoiHienMau,
                IdSuKien = model.IdSuKien,
                DaTungHienMau = model.DaTungHienMau,
                MacBenhHienTai = model.MacBenhHienTai,
                TienSuBenh = model.TienSuBenh,
                ThongTin12ThangQua = model.ThongTin12ThangQua,
                ThongTin6ThangQua = model.ThongTin6ThangQua,
                ThongTin1ThangQua = model.ThongTin1ThangQua,
                ThongTin14NgayQua = model.ThongTin14NgayQua,
                ThongTin7NgayQua = model.ThongTin7NgayQua,
                ThongTinPhuNu12ThangQua = model.ThongTinPhuNu12ThangQua,
                GhiChu = model.GhiChu,

                NgayDangKi = DateTime.Now,
                TrangThaiNguoiHienMau = "Chờ duyệt",
                TrangThaiDonDk = "Chờ duyệt",
                TrangThaiHienMau = "Chưa hiến",
                TtskkhamSangLoc ="Chờ khám",
            };

            try
            {
                await context.DangKiHienMaus.AddAsync(newDonDK);
                await context.SaveChangesAsync();
               
            }catch (Exception ex) {
                Console.WriteLine(ex.Message);
                statusMessageError = "Đăng kí hiến máu thất bại vui lòng thử lại!";
                return RedirectToAction("Index", "Home");
            }

            statusMessageSuccess = "Đăng kí hiến máu thành công!";
            return RedirectToAction("LichSuHienMau", "User");
        }
    }
}
