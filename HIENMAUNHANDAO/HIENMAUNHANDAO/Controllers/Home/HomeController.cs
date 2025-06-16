using HIENMAUNHANDAO.Models;
using HIENMAUNHANDAO.ViewModel;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Reflection.Metadata;

namespace HIENMAUNHANDAO.Controllers.Home
{
    public class HomeController : Controller
    {
        private readonly  WebDbContext context;

// Thông báo đẩy
        [TempData]
        public string statusMessageError { get; set; }

        [TempData]
        public string statusMessageSuccess { set; get; }

        public HomeController(WebDbContext _context)
        {
            context = _context;
        }

        public async Task<IActionResult> Index()
        {
            Paging paging = new Paging();
            int PageSize = paging.pageSize;
            int activePage = 1;

            var idNguoiHienMau = HttpContext.Session.GetString("UserId");
            var listSKDK = new List<string>();

            if (idNguoiHienMau != null)
            {
                listSKDK = await context.DangKiHienMaus
                    .Where(d => d.IdNguoiHienMau == idNguoiHienMau)
                    .Select(d => d.IdSuKien).ToListAsync();
            }

            // Lấy tổng số bản ghi (đếm)
            var query = context.CoSoTinhNguyens
                .Where(cstn => cstn.DangKiToChucHienMaus.Any(dktc => dktc.TinhTrangDk == "Đã duyệt"
                                                                && dktc.TrangThaiSuKien == "Đã duyệt"
                                                                && dktc.HanDk >= DateTime.Now));

            var totalRecords = await query.CountAsync();
            int totalPage = (int)Math.Ceiling((double)totalRecords / PageSize);

            // Lấy dữ liệu theo ViewModel
            var result = await query
                 .SelectMany(cstn => cstn.DangKiToChucHienMaus
                     .Where(dktc => dktc.TinhTrangDk == "Đã duyệt"
                                 && dktc.TrangThaiSuKien == "Đã duyệt"
                                 && dktc.TgKetThucSk >= DateTime.Now)
                     .Select(dktc => new SuKienHienMauViewModel
                     {
                         idSuKien = dktc.IdSuKien,
                         AnhDaiDien = cstn.AnhDaiDien,
                         TieuDe = dktc.IdThongBaoDkNavigation.TieuDe,
                         NoiDung = dktc.IdThongBaoDkNavigation.NoiDung,
                         HanDangKi = dktc.IdThongBaoDkNavigation.HanDangKi,
                         SoLuongDK = dktc.SoLuongDk,
                         soLuongDDK = dktc.SoLuongDdk,
                         TgBatDauSk = dktc.TgBatDauSk, // ✅ đúng chiều: bắt đầu là TgBatDau
                         TgKetThucSk = dktc.TgKetThucSk,
                         TenCoSoTinhNguyen = cstn.TenCoSoTinhNguyen
                     }))
                 .OrderByDescending(sk => sk.TgBatDauSk) // ✅ SẮP XẾP ĐÚNG VỊ TRÍ
                 .Skip((activePage - 1) * PageSize)
                 .Take(PageSize)
                 .ToListAsync();


            HomeViewModel homeViewModel = new HomeViewModel();
            HomeSearchViewModel homeSearchViewModel = new HomeSearchViewModel();
            homeViewModel.modelHome = homeSearchViewModel;
            homeViewModel.suKienHienMau = result;
            paging.PageActive = activePage;
            paging.TotalPage = totalPage;
            homeViewModel.paging = paging;
            ViewBag.Count = null;
            homeViewModel.listSKDKbyIdNguoiDung = listSKDK;
            return View(homeViewModel);
        }


        [HttpPost]
        public async Task<IActionResult> Index(HomeSearchViewModel model)
        {
            Paging paging = new Paging();
            int PageSize = paging.pageSize;
            int activePage = 1;

            var idNguoiHienMau = HttpContext.Session.GetString("UserId");
            var listSKDK = new List<string>();

            if (idNguoiHienMau != null)
            {
                listSKDK = await context.DangKiHienMaus
                    .Where(d => d.IdNguoiHienMau == idNguoiHienMau)
                    .Select(d => d.IdSuKien)
                    .ToListAsync();
            }
            IQueryable<SuKienHienMauViewModel> suKienQuery;
            // Chuẩn hóa ngày tìm kiếm
            if (model.fromDate != null && model.toDate != null && model.toDate >= model.fromDate)
            {
                // Lấy danh sách sự kiện phù hợp
                 suKienQuery = context.CoSoTinhNguyens
                .SelectMany(cstn => cstn.DangKiToChucHienMaus
                    .Where(dktc =>
                        dktc.TinhTrangDk == "Đã duyệt" &&
                        dktc.TrangThaiSuKien == "Đã duyệt" &&
                        dktc.HanDk >= DateTime.Now &&
                        dktc.TgBatDauSk >= model.fromDate &&
                        dktc.TgKetThucSk <= model.toDate
                    )
                    .Select(dktc => new SuKienHienMauViewModel
                    {
                        idSuKien = dktc.IdSuKien,
                        AnhDaiDien = cstn.AnhDaiDien,
                        TieuDe = dktc.IdThongBaoDkNavigation.TieuDe,
                        NoiDung = dktc.IdThongBaoDkNavigation.NoiDung,
                        HanDangKi = dktc.IdThongBaoDkNavigation.HanDangKi,
                        SoLuongDK = dktc.SoLuongDk,
                        soLuongDDK = dktc.SoLuongDdk,
                        TgBatDauSk = dktc.TgBatDauSk,
                        TgKetThucSk = dktc.TgKetThucSk,
                        TenCoSoTinhNguyen = cstn.TenCoSoTinhNguyen
                    })
                );
            }
            else
            {
                 suKienQuery = context.CoSoTinhNguyens
               .SelectMany(cstn => cstn.DangKiToChucHienMaus
                   .Where(dktc =>
                       dktc.TinhTrangDk == "Đã duyệt" &&
                       dktc.TrangThaiSuKien == "Đã duyệt" &&
                       dktc.HanDk >= DateTime.Now
                   )
                   .Select(dktc => new SuKienHienMauViewModel
                   {
                       idSuKien = dktc.IdSuKien,
                       AnhDaiDien = cstn.AnhDaiDien,
                       TieuDe = dktc.IdThongBaoDkNavigation.TieuDe,
                       NoiDung = dktc.IdThongBaoDkNavigation.NoiDung,
                       HanDangKi = dktc.IdThongBaoDkNavigation.HanDangKi,
                       SoLuongDK = dktc.SoLuongDk,
                       soLuongDDK = dktc.SoLuongDdk,
                       TgBatDauSk = dktc.TgBatDauSk,
                       TgKetThucSk = dktc.TgKetThucSk,
                       TenCoSoTinhNguyen = cstn.TenCoSoTinhNguyen
                   })
               );
            }

                // Tổng số bản ghi
                var totalRecords = await suKienQuery.CountAsync();
            int totalPage = (int)Math.Ceiling((double)totalRecords / PageSize);

            // Trang đang xem
            if (model.pageActive != null && model.pageActive > 0 && model.pageActive <= totalPage)
            {
                activePage = model.pageActive;
            }

            // Lấy kết quả theo trang
            var result = await suKienQuery
                .OrderByDescending(sk => sk.TgBatDauSk)
                .Skip((activePage - 1) * PageSize)
                .Take(PageSize)
                .ToListAsync();

            // Trả về ViewModel
            HomeViewModel homeViewModel = new HomeViewModel
            {
                suKienHienMau = result,
                paging = new Paging
                {
                    pageSize = PageSize,
                    PageActive = activePage,
                    TotalPage = totalPage
                },
                listSKDKbyIdNguoiDung = listSKDK,
                modelHome = model
             
            };
            ViewBag.Count = totalRecords;
            return View(homeViewModel);
        }



        [HttpGet]
        public async Task<IActionResult> Login()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(LoginViewModel model)
        {
            if (model == null)
                return View();

            if(model.accountType== "userAccount")
            {
                var user = await context.NguoiDungs
                    .FirstOrDefaultAsync(u => u.Email == model.Email);

                if (user == null || user.Password != model.Password)
                {
                    statusMessageError = "Email hoặc mật khẩu không đúng.";
                    return RedirectToAction("Login", "Home");
                }

                if (user.TinhTrangTk != "Hoạt động")
                {
                    statusMessageError = "Tài khoản của bạn bị khóa, vui lòng liên hệ với admin!";
                    return RedirectToAction("Login", "Home");
                }


                var userVaiTro = await context.VaiTros.FirstOrDefaultAsync(vt => vt.IdVaiTro == user.IdVaiTro);

                // Đăng nhập thành công - lưu thông tin vào session
                HttpContext.Session.SetString("UserId", user.IdNguoiDung.ToString());
                HttpContext.Session.SetString("Role", userVaiTro.TenVaiTro);
                HttpContext.Session.SetString("TenUser", user.HoTen);

                // Chuyển hướng theo vai trò
                switch (userVaiTro.TenVaiTro)
                {
                    case "Admin":
                        return RedirectToAction("QuanLiTaiKhoan", "Admin");
                    case "BacSi":
                        return RedirectToAction("XemDanhSachSuKien", "BacSi");
                    case "NhanVien":
                        return RedirectToAction("XemDanhSachSuKien", "NVYT");
                    case "NguoiHienMau":
                        statusMessageSuccess = $"Đăng nhập thành công! Xin chào {user.HoTen}";
                        return RedirectToAction("Index", "Home");
                    case "GDNHMau":
                        return RedirectToAction("ThongKe", "GDNHMau");
                    default:
                        return RedirectToAction("Index", "Home");
                }
            }else if(model.accountType == "orgAccount")
            {
                var user = await context.CoSoTinhNguyens
                   .FirstOrDefaultAsync(u => u.Email == model.Email);

                if (user == null || user.Password != model.Password)
                {
                    statusMessageError = "Email hoặc mật khẩu không đúng.";
                    return RedirectToAction("Login", "Home");
                }

                if (user.TinhTrang != "Hoạt động")
                {
                    statusMessageError = "Tài khoản của bạn bị khóa, vui lòng liên hệ với admin!";
                    return RedirectToAction("Login", "Home");
                }

                HttpContext.Session.SetString("UserId", user.IdCoSoTinhNguyen.ToString());
                HttpContext.Session.SetString("Role", "CoSoTN");
                HttpContext.Session.SetString("TenUser", user.NguoiPhuTrach);

                return RedirectToAction("XemDanhSachThongBao", "CoSoTN");
            }
            return RedirectToAction("Index", "Home");
        }


        [HttpGet]
        public async Task<IActionResult> Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Home");
        }

        public IActionResult AccessDenied()
        {
            return View();
        }

        public IActionResult Signin()
        {
            return View();
        }


        public async Task<IActionResult> DangKiHienMau(string idSuKien)
        {
            var idNguoiHienMau = HttpContext.Session.GetString("UserId");
            var TenVaiTro = HttpContext.Session.GetString("Role");
            if (idNguoiHienMau == null)
            {
                statusMessageError = "Vui lòng đăng nhập!";
                return RedirectToAction("Login", "Home");
            }

            if(TenVaiTro != "NguoiHienMau")
            {
                statusMessageError = "Vui lòng đăng nhập với quyền của người hiến máu!";
                return RedirectToAction("Login", "Home");
            }
            var lichDangKi = await context.DangKiHienMaus
              .Where(x => x.IdNguoiHienMau == idNguoiHienMau)
              .OrderByDescending(x => x.NgayDangKi) 
              .ToListAsync();

            var ngayHienTai = DateTime.UtcNow;
            var daDangKyTrong3Thang = lichDangKi
               .Any(x =>
                   x.NgayDangKi >= ngayHienTai.AddMonths(-3) &&
                   (x.TrangThaiDonDk == "Đã duyệt" || x.TrangThaiDonDk == "Hoàn thành")
               );

            if (daDangKyTrong3Thang)
            {
                statusMessageError = "Bạn đã đăng ký hiến máu trong vòng 3 tháng gần đây. Vui lòng chờ đủ thời gian trước khi đăng ký lại.";
                return RedirectToAction("LichSuHienMau", "User");
            }

            var result = await context.DangKiToChucHienMaus
                .Include(d => d.IdCoSoTinhNguyenNavigation) 
                    .ThenInclude(c => c.IdPhuongNavigation) 
                        .ThenInclude(p => p.IdQuanNavigation) 
                            .ThenInclude(q => q.IdThanhPhoNavigation) 
                .Where(d => d.IdSuKien == idSuKien && d.TinhTrangDk == "Đã duyệt" && d.TrangThaiSuKien == "Đã duyệt" && d.TgKetThucSk >= DateTime.UtcNow)
                .Select(d => new InfoToChucSuKienViewModel
                {
                    IdSuKien = d.IdSuKien,
                    TgBatDauSk = d.TgBatDauSk,
                    TgKetThucSk = d.TgKetThucSk,
                    SoLuongDk = d.SoLuongDk, 
                    SoLuongDdk = d.SoLuongDdk, 
                    TieuDe = d.IdThongBaoDkNavigation.TieuDe,
                    NoiDung = d.IdThongBaoDkNavigation.NoiDung,
                    TenCoSoTinhNguyen = d.IdCoSoTinhNguyenNavigation.TenCoSoTinhNguyen,
                    DiaChiCSTN = $"{d.IdCoSoTinhNguyenNavigation.DiaChi}, {d.IdCoSoTinhNguyenNavigation.IdPhuongNavigation.TenPhuong}, {d.IdCoSoTinhNguyenNavigation.IdPhuongNavigation.IdQuanNavigation.TenQuan}, {d.IdCoSoTinhNguyenNavigation.IdPhuongNavigation.IdQuanNavigation.IdThanhPhoNavigation.TenThanhPho}",
                    AnhDaiDienCSTN = d.IdCoSoTinhNguyenNavigation.AnhDaiDien
                })
                .FirstOrDefaultAsync();

            if (result == null)
            {
                return NotFound();
            }

            return View(result);
        }



        public IActionResult HoiDap()
        {
            return View();
        }

        public IActionResult LienHe()
        {
            return View();
        }
    }
}
