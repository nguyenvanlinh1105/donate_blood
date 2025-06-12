using Microsoft.AspNetCore.Mvc;

namespace HIENMAUNHANDAO.Controllers.BacSi
{
    public class BacSiController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult XemDanhSachSuKien() { 
            return View();
        }

        public IActionResult Account()
        {
            return View();
        }

        public IActionResult XemDanhSachNguoiHienMau() {
            return View();
        }

        public IActionResult XemChiTietDonDangKi()
        {
            return View();
        }
        public IActionResult CapNhatDonHienMau()
        {
            return View();
        }

        public IActionResult XemDanhSachKhongDat()
        {
            return View();
        }

        public IActionResult XemDanhSachNguoiDaHien()
        {
            return View();
        }
    }
}
