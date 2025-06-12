using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace HIENMAUNHANDAO.Models;

public partial class WebDbContext : DbContext
{
    public WebDbContext()
    {
    }

    public WebDbContext(DbContextOptions<WebDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<CoSoTinhNguyen> CoSoTinhNguyens { get; set; }

    public virtual DbSet<DangKiHienMau> DangKiHienMaus { get; set; }

    public virtual DbSet<DangKiToChucHienMau> DangKiToChucHienMaus { get; set; }

    public virtual DbSet<DanhMucDvmau> DanhMucDvmaus { get; set; }

    public virtual DbSet<GiayChungNhan> GiayChungNhans { get; set; }

    public virtual DbSet<NguoiDung> NguoiDungs { get; set; }

    public virtual DbSet<NhomMau> NhomMaus { get; set; }

    public virtual DbSet<Phuong> Phuongs { get; set; }

    public virtual DbSet<Quan> Quans { get; set; }

    public virtual DbSet<ThanhPho> ThanhPhos { get; set; }

    public virtual DbSet<ThongBaoDangKiToChuc> ThongBaoDangKiToChucs { get; set; }

    public virtual DbSet<VaiTro> VaiTros { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=LAPTOP-RFH2LVGG\\SQLSERVER1;Database=HIENMAUNHANDAO;User Id=sa;Password=sa;TrustServerCertificate=True;Encrypt=False");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<CoSoTinhNguyen>(entity =>
        {
            entity.HasKey(e => e.IdCoSoTinhNguyen).HasName("PK__CoSoTinh__4D1414B611D7E03B");

            entity.ToTable("CoSoTinhNguyen");

            entity.Property(e => e.IdCoSoTinhNguyen)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.AnhDaiDien)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.DiaChi).HasMaxLength(255);
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.IdPhuong)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.MinhChung)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NgaySua).HasColumnType("datetime");
            entity.Property(e => e.NgayTao).HasColumnType("datetime");
            entity.Property(e => e.NguoiPhuTrach).HasMaxLength(100);
            entity.Property(e => e.Password)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Sdt)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("SDT");
            entity.Property(e => e.TenCoSoTinhNguyen).HasMaxLength(255);
            entity.Property(e => e.TinhTrang).HasMaxLength(20);

            entity.HasOne(d => d.IdPhuongNavigation).WithMany(p => p.CoSoTinhNguyens)
                .HasForeignKey(d => d.IdPhuong)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CoSoTinhNguyen_Phuong");
        });

        modelBuilder.Entity<DangKiHienMau>(entity =>
        {
            entity.HasKey(e => e.IdDangKiHienMau).HasName("PK__DangKiHi__08D4070D6717254C");

            entity.ToTable("DangKiHienMau");

            entity.Property(e => e.IdDangKiHienMau)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.DaTungHienMau).HasMaxLength(10);
            entity.Property(e => e.GhiChu).HasMaxLength(255);
            entity.Property(e => e.IdBacSi)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.IdDanhMucDvmau)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("IdDanhMucDVMau");
            entity.Property(e => e.IdNguoiHienMau)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.IdNhanVienDuyet)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.IdSuKien)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.MacBenhHienTai).HasMaxLength(255);
            entity.Property(e => e.NgayDangKi).HasColumnType("datetime");
            entity.Property(e => e.NgayPhanHoi).HasColumnType("datetime");
            entity.Property(e => e.NgaySua).HasColumnType("datetime");
            entity.Property(e => e.ThongTin12ThangQua).HasMaxLength(255);
            entity.Property(e => e.ThongTin14NgayQua).HasMaxLength(255);
            entity.Property(e => e.ThongTin1ThangQua).HasMaxLength(255);
            entity.Property(e => e.ThongTin6ThangQua).HasMaxLength(255);
            entity.Property(e => e.ThongTin7NgayQua).HasMaxLength(255);
            entity.Property(e => e.ThongTinPhuNu12ThangQua).HasMaxLength(255);
            entity.Property(e => e.TienSuBenh).HasMaxLength(255);
            entity.Property(e => e.TrangThaiDonDk)
                .HasMaxLength(50)
                .HasColumnName("TrangThaiDonDK");
            entity.Property(e => e.TrangThaiHienMau).HasMaxLength(50);
            entity.Property(e => e.TrangThaiNguoiHienMau).HasMaxLength(50);
            entity.Property(e => e.TtskkhamSangLoc)
                .HasMaxLength(20)
                .HasColumnName("TTSKKhamSangLoc");
            entity.Property(e => e.TtsksauHien)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("TTSKSauHien");

            entity.HasOne(d => d.IdBacSiNavigation).WithMany(p => p.DangKiHienMauIdBacSiNavigations)
                .HasForeignKey(d => d.IdBacSi)
                .HasConstraintName("FK_DangKiHienMau_BacSi");

            entity.HasOne(d => d.IdDanhMucDvmauNavigation).WithMany(p => p.DangKiHienMaus)
                .HasForeignKey(d => d.IdDanhMucDvmau)
                .HasConstraintName("FK_DangKiHienMau_DanhMucDVMau");

            entity.HasOne(d => d.IdNguoiHienMauNavigation).WithMany(p => p.DangKiHienMauIdNguoiHienMauNavigations)
                .HasForeignKey(d => d.IdNguoiHienMau)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DangKiHienMau_NguoiHienMau");

            entity.HasOne(d => d.IdNhanVienDuyetNavigation).WithMany(p => p.DangKiHienMauIdNhanVienDuyetNavigations)
                .HasForeignKey(d => d.IdNhanVienDuyet)
                .HasConstraintName("FK_DangKiHienMau_NhanVienDuyet");

            entity.HasOne(d => d.IdSuKienNavigation).WithMany(p => p.DangKiHienMaus)
                .HasForeignKey(d => d.IdSuKien)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DangKiHienMau_SuKien");
        });

        modelBuilder.Entity<DangKiToChucHienMau>(entity =>
        {
            entity.HasKey(e => e.IdSuKien).HasName("PK__DangKiTo__30778DB8ADEEE813");

            entity.ToTable("DangKiToChucHienMau");

            entity.Property(e => e.IdSuKien)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.HanDk)
                .HasColumnType("datetime")
                .HasColumnName("HanDK");
            entity.Property(e => e.IdCoSoTinhNguyen)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.IdThongBaoDk)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("IdThongBaoDK");
            entity.Property(e => e.NgayDangKi).HasColumnType("datetime");
            entity.Property(e => e.NgaySua).HasColumnType("datetime");
            entity.Property(e => e.NgayTao).HasColumnType("datetime");
            entity.Property(e => e.SoLuongDdk).HasColumnName("SoLuongDDK");
            entity.Property(e => e.SoLuongDk).HasColumnName("SoLuongDK");
            entity.Property(e => e.TgBatDauSk)
                .HasColumnType("datetime")
                .HasColumnName("TgBatDauSK");
            entity.Property(e => e.TgKetThucSk)
                .HasColumnType("datetime")
                .HasColumnName("TgKetThucSK");
            entity.Property(e => e.TinhTrangDk)
                .HasMaxLength(20)
                .HasColumnName("TinhTrangDK");
            entity.Property(e => e.TrangThaiSuKien).HasMaxLength(20);

            entity.HasOne(d => d.IdCoSoTinhNguyenNavigation).WithMany(p => p.DangKiToChucHienMaus)
                .HasForeignKey(d => d.IdCoSoTinhNguyen)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DangKiToChucHienMau_CoSo");

            entity.HasOne(d => d.IdThongBaoDkNavigation).WithMany(p => p.DangKiToChucHienMaus)
                .HasForeignKey(d => d.IdThongBaoDk)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DangKiToChucHienMau_ThongBao");
        });

        modelBuilder.Entity<DanhMucDvmau>(entity =>
        {
            entity.HasKey(e => e.IdDanhMucDvmau).HasName("PK__DanhMucD__DF87DB206DA9922B");

            entity.ToTable("DanhMucDVMau");

            entity.Property(e => e.IdDanhMucDvmau)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("IdDanhMucDVMau");
            entity.Property(e => e.GhiChu).HasMaxLength(255);
        });

        modelBuilder.Entity<GiayChungNhan>(entity =>
        {
            entity.HasKey(e => e.IdGiayChungNhan).HasName("PK__GiayChun__9DD7270FA271D084");

            entity.ToTable("GiayChungNhan");

            entity.Property(e => e.IdGiayChungNhan)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.IdNguoiDung)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.IdSuKienHienMau)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.NgayCap).HasColumnType("datetime");

            entity.HasOne(d => d.IdNguoiDungNavigation).WithMany(p => p.GiayChungNhans)
                .HasForeignKey(d => d.IdNguoiDung)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_GiayChungNhan_NguoiDung");

            entity.HasOne(d => d.IdSuKienHienMauNavigation).WithMany(p => p.GiayChungNhans)
                .HasForeignKey(d => d.IdSuKienHienMau)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_GiayChungNhan_SuKien");
        });

        modelBuilder.Entity<NguoiDung>(entity =>
        {
            entity.HasKey(e => e.IdNguoiDung).HasName("PK__NguoiDun__FEE82D40AFC7C837");

            entity.ToTable("NguoiDung");

            entity.HasIndex(e => e.Email, "UQ__NguoiDun__A9D1053476B6E5BE").IsUnique();

            entity.Property(e => e.IdNguoiDung)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.AnhDaiDien)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Cccd)
                .HasMaxLength(12)
                .IsUnicode(false)
                .HasColumnName("CCCD");
            entity.Property(e => e.DiaChi).HasMaxLength(255);
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.GioiTinh).HasMaxLength(10);
            entity.Property(e => e.HoTen).HasMaxLength(100);
            entity.Property(e => e.IdNhomMau)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.IdPhuong)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.IdVaiTro)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.NgaySua).HasColumnType("datetime");
            entity.Property(e => e.NgayTao).HasColumnType("datetime");
            entity.Property(e => e.Password)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Sdt)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("SDT");
            entity.Property(e => e.TinhTrangTk)
                .HasMaxLength(20)
                .HasColumnName("TinhTrangTK");

            entity.HasOne(d => d.IdNhomMauNavigation).WithMany(p => p.NguoiDungs)
                .HasForeignKey(d => d.IdNhomMau)
                .HasConstraintName("FK_NguoiDung_NhomMau");

            entity.HasOne(d => d.IdPhuongNavigation).WithMany(p => p.NguoiDungs)
                .HasForeignKey(d => d.IdPhuong)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_NguoiDung_Phuong");

            entity.HasOne(d => d.IdVaiTroNavigation).WithMany(p => p.NguoiDungs)
                .HasForeignKey(d => d.IdVaiTro)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_NguoiDung_VaiTro");
        });

        modelBuilder.Entity<NhomMau>(entity =>
        {
            entity.HasKey(e => e.IdNhomMau).HasName("PK__NhomMau__572769322636B599");

            entity.ToTable("NhomMau");

            entity.Property(e => e.IdNhomMau)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.GhiChu).HasMaxLength(255);
            entity.Property(e => e.NgaySua).HasColumnType("datetime");
            entity.Property(e => e.NgayTao).HasColumnType("datetime");
            entity.Property(e => e.TenNhomMau).HasMaxLength(10);
        });

        modelBuilder.Entity<Phuong>(entity =>
        {
            entity.HasKey(e => e.IdPhuong).HasName("PK__Phuong__8861D422B6B6F2C7");

            entity.ToTable("Phuong");

            entity.Property(e => e.IdPhuong)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.IdQuan)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.TenPhuong).HasMaxLength(100);

            entity.HasOne(d => d.IdQuanNavigation).WithMany(p => p.Phuongs)
                .HasForeignKey(d => d.IdQuan)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Phuong_Quan");
        });

        modelBuilder.Entity<Quan>(entity =>
        {
            entity.HasKey(e => e.IdQuan).HasName("PK__Quan__9005E78959060CC8");

            entity.ToTable("Quan");

            entity.Property(e => e.IdQuan)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.IdThanhPho)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.TenQuan).HasMaxLength(100);

            entity.HasOne(d => d.IdThanhPhoNavigation).WithMany(p => p.Quans)
                .HasForeignKey(d => d.IdThanhPho)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Quan_ThanhPho");
        });

        modelBuilder.Entity<ThanhPho>(entity =>
        {
            entity.HasKey(e => e.IdThanhPho).HasName("PK__ThanhPho__743D6961CCA5DC4E");

            entity.ToTable("ThanhPho");

            entity.Property(e => e.IdThanhPho)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.TenThanhPho).HasMaxLength(100);
        });

        modelBuilder.Entity<ThongBaoDangKiToChuc>(entity =>
        {
            entity.HasKey(e => e.IdThongBaoDk).HasName("PK__ThongBao__3657C57CE94D0898");

            entity.ToTable("ThongBaoDangKiToChuc");

            entity.Property(e => e.IdThongBaoDk)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("IdThongBaoDK");
            entity.Property(e => e.HanDangKi).HasColumnType("datetime");
            entity.Property(e => e.IdNguoiDung)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.NgaySua).HasColumnType("datetime");
            entity.Property(e => e.NgayTao).HasColumnType("datetime");
            entity.Property(e => e.TgBatDauDk)
                .HasColumnType("datetime")
                .HasColumnName("TgBatDauDK");
            entity.Property(e => e.TgKetThucDk)
                .HasColumnType("datetime")
                .HasColumnName("TgKetThucDK");
            entity.Property(e => e.TieuDe).HasMaxLength(255);

            entity.HasOne(d => d.IdNguoiDungNavigation).WithMany(p => p.ThongBaoDangKiToChucs)
                .HasForeignKey(d => d.IdNguoiDung)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ThongBaoDangKiToChuc_NguoiDung");
        });

        modelBuilder.Entity<VaiTro>(entity =>
        {
            entity.HasKey(e => e.IdVaiTro).HasName("PK__VaiTro__491B115C6A67A0C7");

            entity.ToTable("VaiTro");

            entity.Property(e => e.IdVaiTro)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.MoTa).HasMaxLength(255);
            entity.Property(e => e.TenVaiTro).HasMaxLength(50);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
