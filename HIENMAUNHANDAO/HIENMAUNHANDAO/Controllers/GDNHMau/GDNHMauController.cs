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
        public async Task<IActionResult> XemDanhSachDKTC(string IdThongBao, int? pageActive)
        {
            // Lấy ra thông báo theo ID
            var thongBao = await context.ThongBaoDangKiToChucs
                .FirstOrDefaultAsync(tb => tb.IdThongBaoDk == IdThongBao);

            if (thongBao == null)
            {
                return NotFound();
            }

     
            var danhSachCoSo = await context.DangKiToChucHienMaus
                .Where(dk => dk.IdThongBaoDk == IdThongBao)
                .Include(dk => dk.IdCoSoTinhNguyenNavigation) 
                .ToListAsync();
            Console.WriteLine("Danh sách" + danhSachCoSo.Count);


            Paging paging = new Paging();
            int pageSize = paging.pageSize;
            int pageIndex = 1;

            if (pageActive.HasValue && pageActive.Value > 0)
            {
                pageIndex = pageActive.Value;
            }
            else
            {
                pageIndex = 1;
            }

            int totalRecord = danhSachCoSo.Count;
            int totalPage = (int)Math.Ceiling((double)totalRecord / pageSize);
            paging.TotalPage = totalPage;
            paging.PageActive = pageIndex;

            danhSachCoSo = danhSachCoSo.Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList();

            // Truyền dữ liệu ra ViewModel
            var vm = new DanhSachDKTCChiTietViewModel
            {
                thongBao = thongBao,
                DanhSachDangKy = danhSachCoSo,
                paging = paging
            };

            return View(vm);
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
