using System;
using System.Collections.Generic;

namespace HIENMAUNHANDAO.Models;

public partial class GiayChungNhan
{
    public string IdGiayChungNhan { get; set; } = null!;

    public string IdSuKienHienMau { get; set; } = null!;

    public string IdNguoiDung { get; set; } = null!;

    public DateTime NgayCap { get; set; }

    public virtual NguoiDung IdNguoiDungNavigation { get; set; } = null!;

    public virtual DangKiToChucHienMau IdSuKienHienMauNavigation { get; set; } = null!;
}
