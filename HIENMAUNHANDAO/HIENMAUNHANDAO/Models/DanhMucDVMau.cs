using System;
using System.Collections.Generic;

namespace HIENMAUNHANDAO.Models;

public partial class DanhMucDvmau
{
    public string IdDanhMucDvmau { get; set; } = null!;

    public int SoLuongMau { get; set; }

    public string GhiChu { get; set; } = null!;

    public virtual ICollection<DangKiHienMau> DangKiHienMaus { get; set; } = new List<DangKiHienMau>();
}
