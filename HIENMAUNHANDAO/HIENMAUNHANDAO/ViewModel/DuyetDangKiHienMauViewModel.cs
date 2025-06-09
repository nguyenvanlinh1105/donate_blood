using Azure;
using HIENMAUNHANDAO.Models;

namespace HIENMAUNHANDAO.ViewModel
{
    public class DuyetDangKiHienMauViewModel
    {
        public List<ThongBaoDangKiToChuc> thongBaoDangKiToChucs { get; set; }
        public Paging paging { get; set; }
    }
}
