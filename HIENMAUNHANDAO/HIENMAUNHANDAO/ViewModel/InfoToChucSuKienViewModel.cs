namespace HIENMAUNHANDAO.ViewModel
{
    public class InfoToChucSuKienViewModel
    {
        public string IdSuKien { get; set; } = null!;

        public DateTime? TgBatDauSk { get; set; }

        public DateTime? TgKetThucSk { get; set; }

        public int SoLuongDk { get; set; }

        public int SoLuongDdk { get; set; }

        public string TieuDe { get; set; } = null!;

        public string NoiDung { get; set; } = null!;

        public string TenCoSoTinhNguyen { get; set; } = null!;

        public string DiaChiCSTN { get; set; } = null!;

        public string AnhDaiDienCSTN {  get; set; } = null!;
    }
}
