using System;
using System.Collections.Generic;

namespace HIENMAUNHANDAO.Models;

public partial class VaiTro
{
    public string IdVaiTro { get; set; } = null!;

    public string TenVaiTro { get; set; } = null!;

    public string MoTa { get; set; } = null!;

    public virtual ICollection<NguoiDung> NguoiDungs { get; set; } = new List<NguoiDung>();
}
