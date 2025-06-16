using HIENMAUNHANDAO.Models;

namespace HIENMAUNHANDAO.ViewModel
{
    public class DanhSachDKTCChiTietViewModel
    {
        public ThongBaoDangKiToChuc thongBao { set; get; }
        public List<DangKiToChucHienMau> DanhSachDangKy { set; get; }

        public int Count { set; get; }
        public Paging paging { set; get; }
    }
}
