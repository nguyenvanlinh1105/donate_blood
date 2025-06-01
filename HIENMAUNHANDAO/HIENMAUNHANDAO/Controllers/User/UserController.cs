using HIENMAUNHANDAO.Models;
using HIENMAUNHANDAO.ViewModel;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HIENMAUNHANDAO.Controllers.User
{
    public class UserController : Controller
    {
        public readonly WebDbContext context;
        public UserController(WebDbContext context)
        {
            this.context = context;
        }

        public IActionResult LichSuHienMau()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> DangKiHienMau(DangKiHienMauViewModel model)
        {

            var newDonDK = new DangKiHienMau
            {
                IdDangKiHienMau = "DKHM000002", // Thực tế bạn nên sinh tự động thay vì hard-code
                IdNguoiHienMau = "ND00000004",  // Tương tự, nên lấy từ user đăng nhập
                IdSuKien = "SK00000001",        // Cũng nên lấy theo logic nghiệp vụ

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
                TrangThaiNguoiHienMau = "Đủ điều kiện hiến máu",
                TrangThaiDonDk = "Chờ duyệt",
                TrangThaiHienMau = "Chưa hiến"
            };

            await context.DangKiHienMaus.AddAsync(newDonDK);
            await context.SaveChangesAsync(); // Bắt buộc cần dòng này để lưu vào database

            return RedirectToAction("Index", "Home"); // Điều hướng hợp lý hơn là trả về View(model)


        }


    }
}
