using Microsoft.AspNetCore.Mvc;

namespace HIENMAUNHANDAO.Controllers.Admin
{
    public class AdminController : Controller
    {
        public IActionResult Account()
        {
            return View();
        }

        public IActionResult QuanLiTaiKhoan()
        {
            return View();
        }
    }
}
