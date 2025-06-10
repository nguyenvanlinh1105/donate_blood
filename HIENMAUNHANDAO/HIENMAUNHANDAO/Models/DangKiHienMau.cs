using System;
using System.Collections.Generic;

namespace HIENMAUNHANDAO.Models;

public partial class DangKiHienMau
{
    public string IdDangKiHienMau { get; set; } = null!;

    public string IdNguoiHienMau { get; set; } = null!;

    public string? IdBacSi { get; set; }

    public string? IdNhanVienDuyet { get; set; }

    public string IdSuKien { get; set; } = null!;

    public string? IdDanhMucDvmau { get; set; }

    public string TrangThaiHienMau { get; set; } = null!;

    public string TrangThaiDonDk { get; set; } = null!;// Chờ duyệt, đã duyệt, hoàn thành , đã hủy.

    public double? ChieuCao { get; set; }

    public double? CanNang { get; set; }

    public double? NhietDo { get; set; }

    public int? NhipTim { get; set; }

    public int? HuyetAp { get; set; }

    public string DaTungHienMau { get; set; } = null!;

    public string TienSuBenh { get; set; } = null!;

    public string MacBenhHienTai { get; set; } = null!;

    public string ThongTin12ThangQua { get; set; } = null!;

    public string ThongTin6ThangQua { get; set; } = null!;

    public string ThongTin1ThangQua { get; set; } = null!;

    public string ThongTin14NgayQua { get; set; } = null!;

    public string ThongTin7NgayQua { get; set; } = null!;

    public string? ThongTinPhuNu12ThangQua { get; set; }

    public string TtskkhamSangLoc { get; set; } = null;

    public string? TtsksauHien { get; set; }

    public string? GhiChu { get; set; }

    public DateTime NgayDangKi { get; set; }

    public string? NoiDungPhanHoi { get; set; }

    public DateTime? NgayPhanHoi { get; set; }

    public string? TrangThaiNguoiHienMau { get; set; }

    public virtual NguoiDung? IdBacSiNavigation { get; set; }

    public virtual DanhMucDvmau? IdDanhMucDvmauNavigation { get; set; }

    public virtual NguoiDung IdNguoiHienMauNavigation { get; set; } = null!;

    public virtual NguoiDung? IdNhanVienDuyetNavigation { get; set; }

    public virtual DangKiToChucHienMau IdSuKienNavigation { get; set; } = null!;
}
