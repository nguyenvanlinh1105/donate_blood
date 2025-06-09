using HIENMAUNHANDAO.Models;
using HIENMAUNHANDAO.ViewModel;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

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
            var listSKDK= new List<string>();

            if (idNguoiHienMau != null)
            {
                listSKDK = await context.DangKiHienMaus
                    .Where(d=>d.IdNguoiHienMau==idNguoiHienMau)
                    .Select(d => d.IdSuKien).ToListAsync();
                    
            }

            var totalRecords = await context.CoSoTinhNguyens
                .Include(d => d.DangKiToChucHienMaus)
                    .ThenInclude(t => t.IdThongBaoDkNavigation)
                .Where(d => d.DangKiToChucHienMaus.Any(dktc => dktc.TinhTrangDk == "Đã duyệt" && dktc.TrangThaiSuKien == "Đã duyệt" && dktc.TgKetThucSk >= DateTime.Now))
                .CountAsync();
            int totalPage = (int)Math.Ceiling((double)totalRecords / PageSize);

            var result = await context.CoSoTinhNguyens
                .Include(d => d.DangKiToChucHienMaus)
                    .ThenInclude(t=>t.IdThongBaoDkNavigation)
                .Where(d=>d.DangKiToChucHienMaus.Any(dktc=>dktc.TinhTrangDk=="Đã duyệt"&&dktc.TrangThaiSuKien== "Đã duyệt" && dktc.TgKetThucSk >= DateTime.Now))
                .Skip((activePage - 1)*PageSize)
                .Take(PageSize)
                .ToListAsync();
            HomeViewModel homeViewModel = new HomeViewModel();

            homeViewModel.suKienHienMau = result;
            paging.PageActive = activePage;
            paging.TotalPage = totalPage;
            homeViewModel.paging = paging;
            homeViewModel.listSKDKbyIdNguoiDung = listSKDK;
            return View(homeViewModel);
        }
        [HttpPost]
        public async Task<IActionResult> Index(HomeSearchViewModel model)
        {
            Paging paging = new Paging();
            int PageSize = paging.pageSize;
            int activePage = 1;
            var result=new List<CoSoTinhNguyen>();
            int totalPage = 1;

            var idNguoiHienMau = HttpContext.Session.GetString("UserId");
            var listSKDK = new List<string>();

            if (idNguoiHienMau != null)
            {
                listSKDK = await context.DangKiHienMaus
                    .Where(d => d.IdNguoiHienMau == idNguoiHienMau)
                    .Select(d => d.IdSuKien).ToListAsync();

            }

            if (model.fromDate!=null && model.toDate!=null && model.toDate >= model.fromDate)
            {
                var totalRecords = await context.CoSoTinhNguyens
                .Include(d => d.DangKiToChucHienMaus)
                    .ThenInclude(t => t.IdThongBaoDkNavigation)
                .Where(d => d.DangKiToChucHienMaus.Any(dktc => dktc.TinhTrangDk == "Đã duyệt" && dktc.TrangThaiSuKien == "Đã duyệt" && dktc.TgKetThucSk >= DateTime.Now && dktc.TgBatDauSk >= model.fromDate && dktc.TgKetThucSk <= model.toDate))
                .CountAsync();
                totalPage = (int)Math.Ceiling((double)totalRecords / PageSize);

                if (model.pageActive != null && model.pageActive >= 0 && model.pageActive <= totalPage)
                {
                    activePage = model.pageActive;
                }

                 result = await context.CoSoTinhNguyens
                    .Include(d => d.DangKiToChucHienMaus)
                        .ThenInclude(t => t.IdThongBaoDkNavigation)
                    .Where(d => d.DangKiToChucHienMaus.Any(dktc => dktc.TinhTrangDk == "Đã duyệt" && dktc.TrangThaiSuKien == "Đã duyệt" && dktc.TgKetThucSk >= DateTime.Now && dktc.TgBatDauSk >= model.fromDate && dktc.TgKetThucSk <= model.toDate))
                    .Skip((activePage - 1) * PageSize)
                    .Take(PageSize)
                    .ToListAsync();
            }
            else
            {
                var totalRecords = await context.CoSoTinhNguyens
                .Include(d => d.DangKiToChucHienMaus)
                    .ThenInclude(t => t.IdThongBaoDkNavigation)
                .Where(d => d.DangKiToChucHienMaus.Any(dktc => dktc.TinhTrangDk == "Đã duyệt" && dktc.TrangThaiSuKien == "Đã duyệt" && dktc.TgKetThucSk>=DateTime.Now))
                .CountAsync();
                totalPage = (int)Math.Ceiling((double)totalRecords / PageSize);

                if (model.pageActive != null && model.pageActive >= 0 && model.pageActive <= totalPage)
                {
                    activePage = model.pageActive;
                }

                result = await context.CoSoTinhNguyens
                   .Include(d => d.DangKiToChucHienMaus)
                       .ThenInclude(t => t.IdThongBaoDkNavigation)
                   .Where(d => d.DangKiToChucHienMaus.Any(dktc => dktc.TinhTrangDk == "Đã duyệt" && dktc.TrangThaiSuKien == "Đã duyệt" && dktc.TgKetThucSk >= DateTime.Now))
                   .Skip((activePage - 1) * PageSize)
                   .Take(PageSize)
                   .ToListAsync();
            }


            HomeViewModel homeViewModel = new HomeViewModel();

            homeViewModel.suKienHienMau = result;
            paging.PageActive = activePage;
            paging.TotalPage = totalPage;
            homeViewModel.paging = paging;
            homeViewModel.listSKDKbyIdNguoiDung = listSKDK;
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

            var user = await context.NguoiDungs
                .FirstOrDefaultAsync(u => u.Email == model.Email);

            if (user == null || user.Password != model.Password)
            {
                statusMessageError= "Email hoặc mật khẩu không đúng.";
                return RedirectToAction("Login", "Home");
            }

            if(user.TinhTrangTk!="Hoạt động")
            {
                statusMessageError = "Tài khoản của bạn bị khóa, vui lòng liên hệ với admin!";
                return RedirectToAction("Login", "Home");
            }


            var userVaiTro = await context.VaiTros.FirstOrDefaultAsync(vt => vt.IdVaiTro == user.IdVaiTro);

            // Đăng nhập thành công - lưu thông tin vào session
            HttpContext.Session.SetString("UserId", user.IdNguoiDung.ToString());
            HttpContext.Session.SetString("Role",  userVaiTro.TenVaiTro);
            HttpContext.Session.SetString("TenUser", user.HoTen);

            // Chuyển hướng theo vai trò
            switch (userVaiTro.TenVaiTro)
            {
                case "Admin":
                    return RedirectToAction("Index", "Admin");
                case "BacSi":
                    return RedirectToAction("Index", "BacSi");
                case "NhanVien":
                    return RedirectToAction("Index", "NhanVien");
                case "NguoiHienMau":
                    statusMessageSuccess = $"Đăng nhập thành công! Xin chào {user.HoTen}";
                    return RedirectToAction("Index", "Home");
                case "GDNHMau":
                    return RedirectToAction("ThongKe", "GDNHMau");
                default:
                    return RedirectToAction("Index", "Home");
            }
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
            if (idNguoiHienMau == null)
            {
                statusMessageError = "Vui lòng đăng nhập!";
                return RedirectToAction("Login", "Home");
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
    }
}
