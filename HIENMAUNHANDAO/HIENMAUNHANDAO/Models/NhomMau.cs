using System;
using System.Collections.Generic;

namespace HIENMAUNHANDAO.Models;

public partial class NhomMau
{
    public string IdNhomMau { get; set; } = null!;

    public string TenNhomMau { get; set; } = null!;

    public int DoPhoBien { get; set; }

    public string? GhiChu { get; set; }

    public DateTime NgayTao { get; set; }

    public DateTime? NgaySua { get; set; }

    public virtual ICollection<NguoiDung> NguoiDungs { get; set; } = new List<NguoiDung>();
}
