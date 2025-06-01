using System;
using System.Collections.Generic;

namespace HIENMAUNHANDAO.Models;

public partial class CoSoTinhNguyen
{
    public string IdCoSoTinhNguyen { get; set; } = null!;

    public string IdPhuong { get; set; } = null!;

    public string TenCoSoTinhNguyen { get; set; } = null!;

    public string Sdt { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string NguoiPhuTrach { get; set; } = null!;

    public string DiaChi { get; set; } = null!;

    public string MinhChung { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string TinhTrang { get; set; } = null!;

    public string? AnhDaiDien { get; set; }

    public DateTime NgayTao { get; set; }

    public DateTime? NgaySua { get; set; }

    public virtual ICollection<DangKiToChucHienMau> DangKiToChucHienMaus { get; set; } = new List<DangKiToChucHienMau>();

    public virtual Phuong IdPhuongNavigation { get; set; } = null!;
}
