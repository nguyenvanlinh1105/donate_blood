using System;
using System.Collections.Generic;

namespace HIENMAUNHANDAO.Models;

public partial class DangKiToChucHienMau
{
    public string IdSuKien { get; set; } = null!;

    public string IdThongBaoDk { get; set; } = null!;

    public string IdCoSoTinhNguyen { get; set; } = null!;

    public DateTime? NgayDangKi { get; set; }

    public string TinhTrangDk { get; set; } = null!;

    public int SoLuongDk { get; set; }

    public int SoLuongDdk { get; set; }

    public string TrangThaiSuKien { get; set; } = null!;

    public DateTime HanDk { get; set; }

    public DateTime? TgBatDauSk { get; set; }

    public DateTime? TgKetThucSk { get; set; }

    public DateTime NgayTao { get; set; }

    public DateTime NgaySua { get; set; }

    public virtual ICollection<DangKiHienMau> DangKiHienMaus { get; set; } = new List<DangKiHienMau>();

    public virtual ICollection<GiayChungNhan> GiayChungNhans { get; set; } = new List<GiayChungNhan>();

    public virtual CoSoTinhNguyen IdCoSoTinhNguyenNavigation { get; set; } = null!;

    public virtual ThongBaoDangKiToChuc IdThongBaoDkNavigation { get; set; } = null!;
}
