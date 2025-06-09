using System;
using System.Collections.Generic;

namespace HIENMAUNHANDAO.Models;

public partial class ThongBaoDangKiToChuc
{
    public string IdThongBaoDk { get; set; } = null!;

    public string IdNguoiDung { get; set; } = null!;

    public string TieuDe { get; set; } = null!;

    public string NoiDung { get; set; } = null!;
    public string YeuCau { set; get; } = null!;
    public int SoLuongHien { get; set; }

    public DateTime HanDangKi { set; get; }

    public DateTime TgBatDauDk { get; set; }

    public DateTime TgKetThucDk { get; set; }

    public DateTime NgayTao { get; set; }

    public DateTime? NgaySua { get; set; }

    public virtual ICollection<DangKiToChucHienMau> DangKiToChucHienMaus { get; set; } = new List<DangKiToChucHienMau>();

    public virtual NguoiDung IdNguoiDungNavigation { get; set; } = null!;
}
