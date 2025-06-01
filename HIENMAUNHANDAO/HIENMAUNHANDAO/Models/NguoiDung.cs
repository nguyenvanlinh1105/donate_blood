using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;

namespace HIENMAUNHANDAO.Models;

public partial class NguoiDung
{
    public string IdNguoiDung { get; set; } = null!;

    public string? IdNhomMau { get; set; }

    public string IdPhuong { get; set; } = null!;

    public string IdVaiTro { get; set; } = null!;

    public string HoTen { get; set; } = null!;

    public string GioiTinh { get; set; } = null!;

    public DateOnly NgaySinh { get; set; }

    public string DiaChi { get; set; } = null!;

    public string? Cccd { get; set; }

    public string? Sdt { get; set; }

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string TinhTrangTk { get; set; } = null!;

    public string? AnhDaiDien { get; set; }

    public DateTime NgayTao { get; set; }

    public DateTime? NgaySua { get; set; }

    public virtual ICollection<DangKiHienMau> DangKiHienMauIdBacSiNavigations { get; set; } = new List<DangKiHienMau>();

    public virtual ICollection<DangKiHienMau> DangKiHienMauIdNguoiHienMauNavigations { get; set; } = new List<DangKiHienMau>();

    public virtual ICollection<DangKiHienMau> DangKiHienMauIdNhanVienDuyetNavigations { get; set; } = new List<DangKiHienMau>();

    public virtual ICollection<GiayChungNhan> GiayChungNhans { get; set; } = new List<GiayChungNhan>();

    public virtual NhomMau? IdNhomMauNavigation { get; set; }

    public virtual Phuong IdPhuongNavigation { get; set; } = null!;

    public virtual VaiTro IdVaiTroNavigation { get; set; } = null!;

    public virtual ICollection<ThongBaoDangKiToChuc> ThongBaoDangKiToChucs { get; set; } = new List<ThongBaoDangKiToChuc>();
}
