using HIENMAUNHANDAO.Models;
using HIENMAUNHANDAO.ViewModel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace HIENMAUNHANDAO.Controllers.GDNHMau
{
    public class GDNHMauController : Controller
    {
        public readonly WebDbContext context;
        public GDNHMauController(WebDbContext context)
        {
            this.context = context;
        }
        public IActionResult XemDanhSachDKTC()
        {
            return View();
        }

        public IActionResult XemChiTietDKTC()
        {
            return View();
        }

        public IActionResult ThongKe()
        {
            return View();
        }


        public async Task< IActionResult> DuyetDangKiTCHM()
        {
            var result = context.ThongBaoDangKiToChucs
                .Include(t => t.DangKiToChucHienMaus)
                    .ThenInclude(cs => cs.IdCoSoTinhNguyenNavigation);

            DuyetDangKiHienMauViewModel duyetView = new DuyetDangKiHienMauViewModel();

            Paging paging = new Paging();
            var pageIndex = paging.PageActive;
            var pageSize = paging.pageSize;
            var totalRecord = await result.CountAsync();
            var totalPage = (int)Math.Ceiling((double)totalRecord / pageSize);
            paging.TotalPage = totalPage;
            paging.PageActive = 1;
            var dsTB = new List<ThongBaoDangKiToChuc>();
            dsTB = await result
                .Where(t=>t.HanDangKi<=DateTime.Now)
                .Skip((pageIndex - 1) * pageSize)
                    .Take(pageSize)
                    .ToListAsync();
            duyetView.thongBaoDangKiToChucs =dsTB;
            duyetView.paging = paging;
            
            return View(duyetView);
        }
        [HttpPost]
        public async Task<IActionResult> DuyetDangKiTCHM(int pageActive)
        {
            var result = context.ThongBaoDangKiToChucs
                .Include(t => t.DangKiToChucHienMaus)
                    .ThenInclude(cs => cs.IdCoSoTinhNguyenNavigation);

            DuyetDangKiHienMauViewModel duyetView = new DuyetDangKiHienMauViewModel();

            Paging paging = new Paging();
            var pageIndex = pageActive > 0 ? pageActive : 1;
            var pageSize = paging.pageSize;
            var totalRecord = await result.CountAsync();
            var totalPage = (int)Math.Ceiling((double)totalRecord / pageSize);
            paging.TotalPage = totalPage;
            paging.PageActive = pageIndex;
            var dsTB = new List<ThongBaoDangKiToChuc>();
            dsTB = await result
                .Where(t => t.HanDangKi <= DateTime.Now)
                .Skip((pageIndex - 1) * pageSize)
                    .Take(pageSize)
                    .ToListAsync();
            duyetView.thongBaoDangKiToChucs = dsTB;
            duyetView.paging = paging;

            return View(duyetView);
        }
    }
}
