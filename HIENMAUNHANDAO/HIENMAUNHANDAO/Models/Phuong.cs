using System;
using System.Collections.Generic;

namespace HIENMAUNHANDAO.Models;

public partial class Phuong
{
    public string IdPhuong { get; set; } = null!;

    public string TenPhuong { get; set; } = null!;

    public string IdQuan { get; set; } = null!;

    public virtual ICollection<CoSoTinhNguyen> CoSoTinhNguyens { get; set; } = new List<CoSoTinhNguyen>();

    public virtual Quan IdQuanNavigation { get; set; } = null!;

    public virtual ICollection<NguoiDung> NguoiDungs { get; set; } = new List<NguoiDung>();
}
