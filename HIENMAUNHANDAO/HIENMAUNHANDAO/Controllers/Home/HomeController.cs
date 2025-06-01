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

        public HomeController(WebDbContext _context)
        {
            context = _context;
        }

        public IActionResult Index()
        {
            return View();
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
                ModelState.AddModelError("", "Email hoặc mật khẩu không đúng.");
                return View(model);
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
                    return RedirectToAction("Index", "Home");
                case "QuanLyCoSo":
                    return RedirectToAction("Index", "QuanLyCoSo");
                default:
                    return RedirectToAction("Index", "Home");
            }
        }


        [HttpPost]
        public async Task<IActionResult> Logout()
        {
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

        public IActionResult DangKiHienMau()
        {
            return View();
        }
    }
}
