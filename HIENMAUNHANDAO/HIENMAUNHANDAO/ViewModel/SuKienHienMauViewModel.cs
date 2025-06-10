namespace HIENMAUNHANDAO.ViewModel
{
    public class SuKienHienMauViewModel
    {
        public string idSuKien {  get; set; }
        public string AnhDaiDien { set; get; }
        public string TieuDe { set;get; }
        public string NoiDung { set;get; }
        public DateTime HanDangKi { set;get; }
        public int SoLuongDK { set; get; }  

        public int soLuongDDK { set;get; }

        public DateTime? TgKetThucSk { get; set; }
        public DateTime? TgBatDauSk { get; set; }
        public string TenCoSoTinhNguyen { get; set; }

    }
}
