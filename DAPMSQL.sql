-- Create Database
CREATE DATABASE HIENMAUNHANDAO;
GO

USE HIENMAUNHANDAO;
GO

-- Create ThanhPho Table
CREATE TABLE ThanhPho (
    IdThanhPho varchar(10) PRIMARY KEY,
    TenThanhPho nvarchar(100) NOT NULL,
);
GO

-- Create Quan Table
CREATE TABLE Quan (
    IdQuan varchar(10) PRIMARY KEY,
    TenQuan nvarchar(100) NOT NULL,
    IdThanhPho varchar(10) NOT NULL,
    CONSTRAINT FK_Quan_ThanhPho FOREIGN KEY (IdThanhPho) 
        REFERENCES ThanhPho(IdThanhPho) ON DELETE NO ACTION
);
GO

-- Create Phuong Table
CREATE TABLE Phuong (
    IdPhuong varchar(10) PRIMARY KEY,
    TenPhuong nvarchar(100) NOT NULL,
    IdQuan varchar(10) NOT NULL,
    CONSTRAINT FK_Phuong_Quan FOREIGN KEY (IdQuan) 
        REFERENCES Quan(IdQuan) ON DELETE NO ACTION
);
GO

-- Create NhomMau Table
CREATE TABLE NhomMau (
    IdNhomMau varchar(10) PRIMARY KEY,
    TenNhomMau nvarchar(10) NOT NULL,
    DoPhoBien int NOT NULL,
    GhiChu nvarchar(255) NULL,
    NgayTao datetime NOT NULL,
    NgaySua datetime NULL,
);
GO

-- Create VaiTro Table
CREATE TABLE VaiTro (
    IdVaiTro varchar(10) PRIMARY KEY,
    TenVaiTro nvarchar(50) NOT NULL,
    MoTa nvarchar(255) NOT NULL,
);
GO

-- Create NguoiDung Table
CREATE TABLE NguoiDung (
    IdNguoiDung varchar(10) PRIMARY KEY,
    IdNhomMau varchar(10)  NULL,
    IdPhuong varchar(10) NOT NULL,
    IdVaiTro varchar(10) NOT NULL,
    HoTen nvarchar(100) NOT NULL,
    GioiTinh nvarchar(10) NOT NULL,
    NgaySinh date NOT NULL,
    DiaChi nvarchar(255) NOT NULL,
    CCCD varchar(12)  NULL,
    SDT varchar(10)  NULL,
    Email varchar(100) NOT NULL UNIQUE,
    Password varchar(255) NOT NULL,
    TinhTrangTK nvarchar(20) NOT NULL,
    AnhDaiDien varchar(255) NULL,
    NgayTao datetime NOT NULL,
    NgaySua datetime  NULL,
    CONSTRAINT FK_NguoiDung_NhomMau FOREIGN KEY (IdNhomMau) 
        REFERENCES NhomMau(IdNhomMau) ON DELETE NO ACTION,
    CONSTRAINT FK_NguoiDung_Phuong FOREIGN KEY (IdPhuong) 
        REFERENCES Phuong(IdPhuong) ON DELETE NO ACTION,
    CONSTRAINT FK_NguoiDung_VaiTro FOREIGN KEY (IdVaiTro) 
        REFERENCES VaiTro(IdVaiTro) ON DELETE NO ACTION,
);
GO

-- Create CoSoTinhNguyen Table
CREATE TABLE CoSoTinhNguyen (
    IdCoSoTinhNguyen varchar(10) PRIMARY KEY,
    IdPhuong varchar(10) NOT NULL,
    TenCoSoTinhNguyen nvarchar(255) NOT NULL,
    SDT varchar(10) NOT NULL,
    Email varchar(100) NOT NULL,
    NguoiPhuTrach nvarchar(100) NOT NULL,
    DiaChi nvarchar(255) NOT NULL,
    MinhChung varchar(255) NOT NULL,
    Password varchar(255) NOT NULL,
    TinhTrang nvarchar(20) NOT NULL,
    AnhDaiDien varchar(255) NULL,
    NgayTao datetime NOT NULL,
    NgaySua datetime  NULL,
    CONSTRAINT FK_CoSoTinhNguyen_Phuong FOREIGN KEY (IdPhuong) 
        REFERENCES Phuong(IdPhuong) ON DELETE NO ACTION
);
GO

-- Create ThongBaoDangKiToChuc Table
CREATE TABLE ThongBaoDangKiToChuc (
    IdThongBaoDK varchar(10) PRIMARY KEY,
    IdNguoiDung varchar(10) NOT NULL,
    TieuDe nvarchar(255) NOT NULL,
    NoiDung nvarchar(max) NOT NULL,
	YeuCau nvarchar(max) NOT NULL,
    SoLuongHien int NOT NULL,
	HanDangKi datetime NOT NULL,
    TgBatDauDK datetime NOT NULL,
    TgKetThucDK datetime NOT NULL,
    NgayTao datetime NOT NULL,
    NgaySua datetime NULL,
    CONSTRAINT FK_ThongBaoDangKiToChuc_NguoiDung FOREIGN KEY (IdNguoiDung) 
        REFERENCES NguoiDung(IdNguoiDung) ON DELETE NO ACTION
);
GO

-- Create DangKiToChucHienMau Table
CREATE TABLE DangKiToChucHienMau (
    IdSuKien varchar(10) PRIMARY KEY,
    IdThongBaoDK varchar(10) NOT NULL,
    IdCoSoTinhNguyen varchar(10) NOT NULL,
    NgayDangKi datetime NOT NULL,
    TinhTrangDK nvarchar(20) NOT NULL,
    SoLuongDK int NOT NULL,
    SoLuongDDK int NOT NULL,
    TrangThaiSuKien nvarchar(20) NOT NULL,
    HanDK datetime NOT NULL,
    TgBatDauSK datetime NULL,
    TgKetThucSK datetime NULL,
    NgayTao datetime NOT NULL,
    NgaySua datetime NOT NULL,
    CONSTRAINT FK_DangKiToChucHienMau_ThongBao FOREIGN KEY (IdThongBaoDK) 
        REFERENCES ThongBaoDangKiToChuc(IdThongBaoDK) ON DELETE NO ACTION,
    CONSTRAINT FK_DangKiToChucHienMau_CoSo FOREIGN KEY (IdCoSoTinhNguyen) 
        REFERENCES CoSoTinhNguyen(IdCoSoTinhNguyen) ON DELETE NO ACTION
);
GO

-- Create DanhMucDVMau Table
CREATE TABLE DanhMucDVMau (
    IdDanhMucDVMau varchar(10) PRIMARY KEY,
    SoLuongMau int NOT NULL,
    GhiChu nvarchar(255) NOT NULL,
);
GO

-- Create DangKiHienMau Table
CREATE TABLE DangKiHienMau (
    IdDangKiHienMau varchar(10) PRIMARY KEY,
    IdNguoiHienMau varchar(10) NOT NULL,
    IdBacSi varchar(10)  NULL,
    IdNhanVienDuyet varchar(10)  NULL,
    IdSuKien varchar(10) NOT NULL,
    IdDanhMucDVMau varchar(10) NULL,
    TrangThaiHienMau nvarchar(50) NOT NULL,
    TrangThaiDonDK nvarchar(50) NOT NULL,
    ChieuCao float NULL,
    CanNang float  NULL,
    NhietDo float  NULL,
    NhipTim int  NULL,
    HuyetAp int NULL,
    DaTungHienMau nvarchar(10) NOT NULL,
    TienSuBenh nvarchar(255) NOT NULL,
    MacBenhHienTai nvarchar(255) NOT NULL,
    ThongTin12ThangQua nvarchar(255) NOT NULL,
    ThongTin6ThangQua nvarchar(255) NOT NULL,
    ThongTin1ThangQua nvarchar(255) NOT NULL,
    ThongTin14NgayQua nvarchar(255) NOT NULL,
    ThongTin7NgayQua nvarchar(255) NOT NULL,
    ThongTinPhuNu12ThangQua nvarchar(255) NULL,
    TTSKKhamSangLoc nvarchar(20) NULL,
    TTSKSauHien varchar(255) NULL,
    GhiChu nvarchar(255) NULL,
    NgayDangKi datetime NOT NULL,
    NoiDungPhanHoi nvarchar(max) NULL,
    NgayPhanHoi datetime NULL,
    TrangThaiNguoiHienMau nvarchar(50) NULL,
	NgaySua datetime NULL,
    CONSTRAINT FK_DangKiHienMau_NguoiHienMau FOREIGN KEY (IdNguoiHienMau) 
        REFERENCES NguoiDung(IdNguoiDung) ON DELETE NO ACTION,
    CONSTRAINT FK_DangKiHienMau_BacSi FOREIGN KEY (IdBacSi) 
        REFERENCES NguoiDung(IdNguoiDung) ON DELETE NO ACTION,
    CONSTRAINT FK_DangKiHienMau_NhanVienDuyet FOREIGN KEY (IdNhanVienDuyet) 
        REFERENCES NguoiDung(IdNguoiDung) ON DELETE NO ACTION,
    CONSTRAINT FK_DangKiHienMau_SuKien FOREIGN KEY (IdSuKien) 
        REFERENCES DangKiToChucHienMau(IdSuKien) ON DELETE NO ACTION,
    CONSTRAINT FK_DangKiHienMau_DanhMucDVMau FOREIGN KEY (IdDanhMucDVMau) 
        REFERENCES DanhMucDVMau(IdDanhMucDVMau) ON DELETE NO ACTION
);
GO

-- Create GiayChungNhan Table
CREATE TABLE GiayChungNhan (
    IdGiayChungNhan varchar(10) PRIMARY KEY,
    IdSuKienHienMau varchar(10) NOT NULL,
    IdNguoiDung varchar(10) NOT NULL,
    NgayCap datetime NOT NULL,
    CONSTRAINT FK_GiayChungNhan_SuKien FOREIGN KEY (IdSuKienHienMau) 
        REFERENCES DangKiToChucHienMau(IdSuKien) ON DELETE NO ACTION,
    CONSTRAINT FK_GiayChungNhan_NguoiDung FOREIGN KEY (IdNguoiDung) 
        REFERENCES NguoiDung(IdNguoiDung) ON DELETE NO ACTION
);
GO

-- Insert into ThanhPho
INSERT INTO ThanhPho (IdThanhPho, TenThanhPho)
VALUES
('TP00000001', N'Đà Nẵng'),
('TP00000002', N'Hà Nội'),
('TP00000003', N'TP Hồ Chí Minh'),
('TP00000004', N'Hải Phòng'),
('TP00000005', N'Cần Thơ'),
('TP00000006', N'Huế'),
('TP00000007', N'Nha Trang'),
('TP00000008', N'Vũng Tàu'),
('TP00000009', N'Quy Nhơn'),
('TP00000010', N'Vinh'),
('TP00000011', N'Đà Lạt'),
('TP00000012', N'Buôn Ma Thuột'),
('TP00000013', N'Pleiku'),
('TP00000014', N'Mỹ Tho'),
('TP00000015', N'Long Xuyên'),
('TP00000016', N'Rạch Giá'),
('TP00000017', N'Cà Mau'),
('TP00000018', N'Bắc Ninh'),
('TP00000019', N'Hạ Long'),
('TP00000020', N'Thanh Hóa');
GO

-- Insert into Quan
INSERT INTO Quan (IdQuan, TenQuan, IdThanhPho)
VALUES
('Q000000001', N'Hải Châu', 'TP00000001'),
('Q000000002', N'Thanh Khê', 'TP00000001'),
('Q000000003', N'Cẩm Lệ', 'TP00000001'),
('Q000000004', N'Liên Chiểu', 'TP00000001'),
('Q000000005', N'Hoàn Kiếm', 'TP00000002'),
('Q000000006', N'Ba Đình', 'TP00000002'),
('Q000000007', N'Quận 1', 'TP00000003'),
('Q000000008', N'Quận 3', 'TP00000003'),
('Q000000009', N'Hồng Bàng', 'TP00000004'),
('Q000000010', N'Ngô Quyền', 'TP00000004'),
('Q000000011', N'Ninh Kiều', 'TP00000005'),
('Q000000012', N'Cái Răng', 'TP00000005'),
('Q000000013', N'Phú Nhuận', 'TP00000003'),
('Q000000014', N'Thủ Đức', 'TP00000003'),
('Q000000015', N'Thừa Thiên', 'TP00000006'),
('Q000000016', N'Cam Ranh', 'TP00000007'),
('Q000000017', N'Bà Rịa', 'TP00000008'),
('Q000000018', N'Tân Bình', 'TP00000003'),
('Q000000019', N'Hai Bà Trưng', 'TP00000002'),
('Q000000020', N'Cầu Giấy', 'TP00000002');
GO
-- Insert into Phuong
INSERT INTO Phuong (IdPhuong, TenPhuong, IdQuan)
VALUES
('P000000001', N'Thanh Bình', 'Q000000001'),
('P000000002', N'Thuận Phước', 'Q000000001'),
('P000000003', N'Hòa Cường Bắc', 'Q000000003'),
('P000000004', N'Hòa Hiệp Nam', 'Q000000004'),
('P000000005', N'Hàng Bột', 'Q000000006'),
('P000000006', N'Phúc Xá', 'Q000000005'),
('P000000007', N'Tân Định', 'Q000000007'),
('P000000008', N'Bến Thành', 'Q000000008'),
('P000000009', N'Máy Tơ', 'Q000000009'),
('P000000010', N'Đông Khê', 'Q000000010'),
('P000000011', N'An Cư', 'Q000000011'),
('P000000012', N'Hưng Phú', 'Q000000012'),
('P000000013', N'Phú Thạnh', 'Q000000013'),
('P000000014', N'Linh Trung', 'Q000000014'),
('P000000015', N'Hương Thủy', 'Q000000015'),
('P000000016', N'Cam Phúc Nam', 'Q000000016'),
('P000000017', N'Phường 1', 'Q000000017'),
('P000000018', N'Phường 15', 'Q000000018'),
('P000000019', N'Cửa Ông', 'Q000000019'),
('P000000020', N'Ngọc Xuyên', 'Q000000020');
GO

-- Insert into NhomMau
INSERT INTO NhomMau (IdNhomMau, TenNhomMau, DoPhoBien, GhiChu, NgayTao, NgaySua)
VALUES
('NM00000001', N'A+', 30, N'Nhóm máu A dương', GETDATE(), NULL),
('NM00000002', N'A-', 5, N'Nhóm máu A âm', GETDATE(), NULL),
('NM00000003', N'B+', 25, N'Nhóm máu B dương', GETDATE(), NULL),
('NM00000004', N'B-', 3, N'Nhóm máu B âm', GETDATE(), NULL),
('NM00000005', N'AB+', 10, N'Nhóm máu AB dương', GETDATE(), NULL),
('NM00000006', N'AB-', 1, N'Nhóm máu AB âm', GETDATE(), NULL),
('NM00000007', N'O+', 35, N'Nhóm máu O dương', GETDATE(), NULL),
('NM00000008', N'O-', 7, N'Nhóm máu O âm', GETDATE(), NULL);
GO

-- Insert into VaiTro
INSERT INTO VaiTro (IdVaiTro, TenVaiTro, MoTa)
VALUES
('VT00000001', N'Admin', N'Quản trị viên hệ thống'),
('VT00000002', N'BacSi', N'Bác sĩ phụ trách'),
('VT00000003', N'NhanVien', N'Nhân viên duyệt đơn'),
('VT00000004', N'NguoiHienMau', N'Người hiến máu'),
('VT00000005', N'GDNHMau', N'Giám đốc ngân hàng máu');
GO

-- Insert into NguoiDung
INSERT INTO NguoiDung (IdNguoiDung, IdNhomMau, IdPhuong, IdVaiTro, HoTen, GioiTinh, NgaySinh, DiaChi, CCCD, SDT, Email, Password, TinhTrangTK, AnhDaiDien, NgayTao, NgaySua)
VALUES
('AD00000001', 'NM00000001', 'P000000001', 'VT00000001', N'Nguyễn Văn An', N'Nam', '1990-01-01', N'123 Lê Duẩn, Đà Nẵng', '123456789001', '0905123456', 'an.nguyen@gmail.com', 'hashedpass1', N'Hoạt động', '1.jpg', GETDATE(), NULL),
('BS00000002', 'NM00000002', 'P000000002', 'VT00000002', N'Trần Thị Bình', N'Nữ', '1992-02-02', N'456 Trần Phú, Đà Nẵng', '123456789002', '0906123456', 'binh.tran@gmail.com', 'hashedpass2', N'Hoạt động', '2.jpg', GETDATE(), NULL),
('NV00000003', 'NM00000003', 'P000000003', 'VT00000003', N'Lê Văn Cường', N'Nam', '1995-03-03', N'789 Nguyễn Huệ, Đà Nẵng', '123456789003', '0907123456', 'cuong.le@gmail.com', 'hashedpass3', N'Không hoạt động', '3.jpg', GETDATE(), NULL),
('ND00000004', 'NM00000004', 'P000000004', 'VT00000004', N'Nguyễn Văn Linh', N'Nam', '1993-04-04', N'321 Hải Phòng, Đà Nẵng', '123456789004', '0908123456', 'vanlinh@gmail.com', '110504', N'Hoạt động', '1.jpg', GETDATE(), NULL),
('GD00000005', 'NM00000005', 'P000000005', 'VT00000005', N'Trần Văn Nam', N'Nam', '1991-05-05', N'654 Điện Biên Phủ, Hà Nội', '123456789005', '0909123456', 'namtran@gmail.com', '230804', N'Hoạt động', '4.jpg', GETDATE(), NULL),
('ND00000006', 'NM00000006', 'P000000006', 'VT00000004', N'Hoàng Thị Phượng', N'Nữ', '1994-06-06', N'987 Hoàn Kiếm, Hà Nội', '123456789006', '0910123456', 'phuong.hoang@gmail.com', 'hashedpass6', N'Không hoạt động', '2.jpg', GETDATE(), NULL),
('BS00000007', 'NM00000007', 'P000000007', 'VT00000002', N'Vũ Văn Hùng', N'Nam', '1989-07-07', N'147 Quận 1, TP HCM', '123456789007', '0911123456', 'hung.vu@gmail.com', 'hashedpass7', N'Hoạt động', '1.jpg', GETDATE(), NULL),
('NV00000008', 'NM00000008', 'P000000008', 'VT00000003', N'Ngô Thị Lan', N'Nữ', '1996-08-08', N'258 Quận 3, TP HCM', '123456789008', '0912123456', 'lan.ngo@gmail.com', 'hashedpass8', N'Hoạt động', '4.jpg', GETDATE(), NULL),
('ND00000009', 'NM00000001', 'P000000009', 'VT00000004', N'Bùi Văn Nam', N'Nam', '1990-09-09', N'369 Hồng Bàng, Hải Phòng', '123456789009', '0913123456', 'nam.bui@gmail.com', 'hashedpass9', N'Không hoạt động', '2.jpg', GETDATE(), NULL),
('ND00000010', 'NM00000002', 'P000000010', 'VT00000004', N'Đỗ Thị Oanh', N'Nữ', '1992-10-10', N'741 Ngô Quyền, Hải Phòng', '123456789010', '0914123456', 'oanh.do@gmail.com', 'hashedpass10', N'Hoạt động', '3.jpg', GETDATE(), NULL),
('BS00000011', 'NM00000003', 'P000000011', 'VT00000002', N'Phan Văn Phát', N'Nam', '1993-11-11', N'852 Ninh Kiều, Cần Thơ', '123456789011', '0915123456', 'phat.phan@gmail.com', 'hashedpass11', N'Hoạt động', '3.jpg', GETDATE(), NULL),
('BS00000012', 'NM00000004', 'P000000012', 'VT00000002', N'Lý Thị Quỳnh', N'Nữ', '1995-12-12', N'963 Cái Răng, Cần Thơ', '123456789012', '0916123456', 'quynh.ly@gmail.com', 'hashedpass12', N'Không hoạt động', '1.jpg', GETDATE(), NULL),
('NV00000013', 'NM00000005', 'P000000013', 'VT00000003', N'Trương Văn Sang', N'Nam', '1991-01-13', N'159 Phú Nhuận, TP HCM', '123456789013', '0917123456', 'sang.truong@gmail.com', 'hashedpass13', N'Hoạt động', '4.jpg', GETDATE(), NULL),
('ND00000014', 'NM00000006', 'P000000014', 'VT00000004', N'Hà Thị Thanh', N'Nữ', '1994-02-14', N'753 Thủ Đức, TP HCM', '123456789014', '0918123456', 'thanh.ha@gmail.com', 'hashedpass14', N'Hoạt động', '1.jpg', GETDATE(), NULL),
('ND00000015', 'NM00000007', 'P000000015', 'VT00000004', N'Nguyễn Văn Tiến', N'Nam', '1990-03-15', N'456 Hương Thủy, Huế', '123456789015', '0919123456', 'tien.nguyen@gmail.com', 'hashedpass15', N'Không hoạt động', '2.jpg', GETDATE(), NULL),
('ND00000016', 'NM00000008', 'P000000016', 'VT00000004', N'Trần Thị Út', N'Nữ', '1992-04-16', N'789 Cam Ranh, Nha Trang', '123456789016', '0920123456', 'ut.tran@gmail.com', 'hashedpass16', N'Hoạt động', '3.jpg', GETDATE(), NULL),
('ND00000017', 'NM00000001', 'P000000017', 'VT00000004', N'Lê Văn Vương', N'Nam', '1993-05-17', N'123 Bà Rịa, Vũng Tàu', '123456789017', '0921123456', 'vuong.le@gmail.com', 'hashedpass17', N'Hoạt động', '4.jpg', GETDATE(), NULL),
('ND00000018', 'NM00000002', 'P000000018', 'VT00000004', N'Phạm Thị Xuân', N'Nữ', '1995-06-18', N'456 Tân Bình, TP HCM', '123456789018', '0922123456', 'xuan.pham@gmail.com', 'hashedpass18', N'Không hoạt động', '2.jpg', GETDATE(), NULL),
('GD00000019', 'NM00000003', 'P000000019', 'VT00000005', N'Đặng Văn Ý', N'Nam', '1991-07-19', N'789 Cửa Ông, Hạ Long', '123456789019', '0923123456', 'y.dang@gmail.com', 'hashedpass19', N'Hoạt động', '4.jpg', GETDATE(), NULL),
('GD00000020', 'NM00000004', 'P000000020', 'VT00000005', N'Hoàng Thị Z', N'Nữ', '1994-08-20', N'159 Ngọc Xuyên, Cầu Giấy', '123456789020', '0924123456', 'z.hoang@gmail.com', 'hashedpass20', N'Hoạt động', '3.jpg', GETDATE(), NULL);
GO

-- Insert into CoSoTinhNguyen với đổi tên cơ sở thành các trường đại học và trung tâm y tế tại Đà Nẵng
INSERT INTO CoSoTinhNguyen (IdCoSoTinhNguyen, IdPhuong, TenCoSoTinhNguyen, SDT, Email, NguoiPhuTrach, DiaChi, MinhChung, Password, TinhTrang, AnhDaiDien, NgayTao, NgaySua)
VALUES
('CSTN000001', 'P000000001', N'Đại học Đà Nẵng', '0901234561', 'cs1@gmail.com', N'Nguyễn Văn Thái', N'Số 123, kiệt 5', 'minhchung.png', 'hashedpass1', N'Hoạt động', 'avatar1.jpg', GETDATE(), NULL),
('CSTN000002', 'P000000002', N'Đại học Bách Khoa Đà Nẵng', '0901234562', 'cs2@gmail.com', N'Trần Thị Bình', N'Số 456, kiệt 3', 'minhchung.png', 'hashedpass2', N'Không hoạt động', 'avatar2.jpg', GETDATE(), NULL),
('CSTN000003', 'P000000003', N'Đại học Kinh tế Đà Nẵng', '0901234563', 'cs3@gmail.com', N'Lê Văn Công', N'Số 789, kiệt 7', 'minhchung.png', 'hashedpass3', N'Hoạt động', 'avatar3.jpg', GETDATE(), NULL),
('CSTN000004', 'P000000004', N'Đại học Sư phạm Kỹ thuật Đà Nẵng', '0901234564', 'cs4@gmail.com', N'Phạm Thị Duyên', N'Số 321, kiệt 2', 'minhchung.png', 'hashedpass4', N'Không hoạt động', 'avatar4.jpg', GETDATE(), NULL),
('CSTN000005', 'P000000003', N'Đại học Sư phạm Đà Nẵng', '0901234565', 'cs5@gmail.com', N'Đặng Văn Mỹ', N'Số 654, kiệt 9', 'minhchung.png', 'hashedpass5', N'Hoạt động', 'avatar5.jpg', GETDATE(), NULL),
('CSTN000006', 'P000000004', N'Trường Cao đẳng Y tế Đà Nẵng', '0901234566', 'cs6@gmail.com', N'Hoàng Thị Anh', N'Số 987, kiệt 1', 'minhchung.png', 'hashedpass6', N'Hoạt động', 'avatar6.jpg', GETDATE(), NULL),
('CSTN000007', 'P000000001', N'Trung tâm Y tế quận Hải Châu', '0901234567', 'cs7@gmail.com', N'Vũ Văn Gian', N'Số 147, kiệt 4', 'minhchung.png', 'hashedpass7', N'Không hoạt động', 'avatar7.jpg', GETDATE(), NULL),
('CSTN000008', 'P000000002', N'Bệnh viện Đà Nẵng', '0901234568', 'cs8@gmail.com', N'Ngô Thị Hương', N'Số 258, kiệt 6', 'minhchung.png', 'hashedpass8', N'Hoạt động', 'avatar8.jpg', GETDATE(), NULL),
('CSTN000009', 'P000000003', N'Bệnh viện Phụ sản - Nhi Đà Nẵng', '0901234569', 'cs9@gmail.com', N'Bùi Văn Phúc', N'Số 369, kiệt 8', 'minhchung.png', 'hashedpass9', N'Hoạt động', 'avatar9.jpg', GETDATE(), NULL),
('CSTN000010', 'P000000004', N'Bệnh viện Ung bướu Đà Nẵng', '0901234570', 'cs10@gmail.com', N'Đỗ Thị Khánh', N'Số 741, kiệt 10', 'minhchung.png', 'hashedpass10', N'Không hoạt động', 'avatar10.jpg', GETDATE(), NULL),
('CSTN000011', 'P000000002', N'Trung tâm Y tế quận Thanh Khê', '0901234571', 'cs11@gmail.com', N'Phan Văn Luận', N'Số 852, kiệt 11', 'minhchung.png', 'hashedpass11', N'Hoạt động', 'avatar11.jpg', GETDATE(), NULL),
('CSTN000012', 'P000000001', N'Trung tâm Kiểm soát bệnh tật Đà Nẵng', '0901234572', 'cs12@gmail.com', N'Lý Thị Minh', N'Số 963, kiệt 12', 'minhchung.png', 'hashedpass12', N'Không hoạt động', 'avatar12.jpg', GETDATE(), NULL),
('CSTN000013', 'P000000004', N'Trường Cao đẳng Công nghệ Đà Nẵng', '0901234573', 'cs13@gmail.com', N'Trương Văn Nam', N'Số 159, kiệt 13', 'minhchung.png', 'hashedpass13', N'Hoạt động', 'avatar13.jpg', GETDATE(), NULL),
('CSTN000014', 'P000000003', N'Trường Đại học Ngoại ngữ Đà Nẵng', '0901234574', 'cs14@gmail.com', N'Hà Thị Phúc', N'Số 753, kiệt 14', 'minhchung.png', 'hashedpass14', N'Hoạt động', 'avatar14.jpg', GETDATE(), NULL),
('CSTN000015', 'P000000002', N'Trung tâm Y tế quận Cẩm Lệ', '0901234575', 'cs15@gmail.com', N'Nguyễn Văn Phúc', N'Số 456, kiệt 15', 'minhchung.png', 'hashedpass15', N'Không hoạt động', 'avatar15.jpg', GETDATE(), NULL),
('CSTN000016', 'P000000004', N'Bệnh viện Chỉnh hình và Phục hồi chức năng Đà Nẵng', '0901234576', 'cs16@gmail.com', N'Trần Thị Quyên', N'Số 789, kiệt 16', 'minhchung.png', 'hashedpass16', N'Hoạt động', 'avatar16.jpg', GETDATE(), NULL),
('CSTN000017', 'P000000001', N'Trung tâm Y tế quận Sơn Trà', '0901234577', 'cs17@gmail.com', N'Lê Văn Tú', N'Số 123, kiệt 17', 'minhchung.png', 'hashedpass17', N'Hoạt động', 'avatar17.jpg', GETDATE(), NULL),
('CSTN000018', 'P000000003', N'Trường Đại học Sư phạm Đà Nẵng', '0901234578', 'cs18@gmail.com', N'Phạm Thị Hải', N'Số 456, kiệt 18', 'minhchung.png', 'hashedpass18', N'Không hoạt động', 'avatar18.jpg', GETDATE(), NULL),
('CSTN000019', 'P000000004', N'Viện Nghiên cứu và Đào tạo Việt - Anh Đà Nẵng', '0901234579', 'cs19@gmail.com', N'Đặng Văn Tuấn', N'Số 789, kiệt 19', 'minhchung.png', 'hashedpass19', N'Hoạt động', 'avatar19.jpg', GETDATE(), NULL),
('CSTN000020', 'P000000002', N'Bệnh viện 199 - Bộ Công An tại Đà Nẵng', '0901234580', 'cs20@gmail.com', N'Hoàng Thị Mai', N'Số 159, kiệt 20', 'minhchung.png', 'hashedpass20', N'Hoạt động', 'avatar20.jpg', GETDATE(), NULL);
GO

-- insert thongBaoDangKiToChuc
INSERT INTO ThongBaoDangKiToChuc (IdThongBaoDK, IdNguoiDung, TieuDe, NoiDung, YeuCau, SoLuongHien, HanDangKi, TgBatDauDK, TgKetThucDK, NgayTao, NgaySua)
VALUES
('TBDK000001', 'GD00000005', N'Chung Tay Hiến Máu - Lan Tỏa Yêu Thương Tại Đại Học Đà Nẵng',
N'Bạn đã sẵn sàng để trở thành người hùng cứu sống hàng trăm cuộc đời? Hãy tham gia chương trình hiến máu tình nguyện tại các trường Đại học Đà Nẵng và các trung tâm y tế trên địa bàn thành phố! Mỗi giọt máu bạn hiến tặng không chỉ là món quà quý giá cho những người đang cần, mà còn là ngọn lửa lan tỏa yêu thương, kết nối cộng đồng. Đừng chần chừ, hãy đăng ký ngay hôm nay để cùng chúng tôi viết nên câu chuyện nhân ái tại thành phố biển xinh đẹp! Sự tham gia của bạn sẽ mang lại hy vọng và nụ cười cho những bệnh nhân cần máu. Hãy để trái tim bạn dẫn lối!',
N'Phòng tổ chức phải có diện tích tối thiểu 150m², đủ ánh sáng tự nhiên và thông thoáng; Hệ thống điện, nước hoạt động ổn định; Có nhà vệ sinh sạch sẽ; Khu vực đỗ xe rộng rãi, an toàn cho ít nhất 50 xe máy và 10 ô tô; Trang bị đủ bàn ghế, thiết bị y tế cơ bản; Tối thiểu 30 tình nguyện viên tham gia.',
100, '2025-06-12', '2025-06-15 08:00:00', '2025-06-15 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000002', 'GD00000005', N'Giọt Máu Rực Rỡ - Sẻ Chia Sự Sống Tại Đại Học Bách Khoa Đà Nẵng',
N'Hỡi các bạn sinh viên và cộng đồng Đà Nẵng! Hãy cùng chúng tôi tham gia ngày hội hiến máu tình nguyện tại Đại học Bách Khoa và các trung tâm y tế lớn trong thành phố. Một hành động nhỏ của bạn có thể cứu sống một cuộc đời, mang lại ánh sáng cho những bệnh nhân đang chiến đấu từng ngày. Mỗi giọt máu hiến tặng là một món quà vô giá, là biểu tượng của lòng nhân ái và tinh thần đoàn kết. Hãy đến, đăng ký và trở thành một phần của hành trình cao đẹp này! Chúng tôi tin rằng, với sự tham gia của bạn, Đà Nẵng sẽ càng thêm rực rỡ bởi những trái tim ấm áp.',
N'Yêu cầu phòng tổ chức có diện tích trên 200m²; Đủ ánh sáng và thông thoáng; Có điện, nước đầy đủ; Nhà vệ sinh tiện nghi; Khu vực đỗ xe rộng, an toàn cho ít nhất 70 xe máy và 15 ô tô; Bàn ghế và thiết bị y tế hiện đại; Ít nhất 50 tình nguyện viên hỗ trợ.',
150, '2025-06-13', '2025-06-16 08:00:00', '2025-06-16 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000003', 'GD00000005', N'Giọt Máu Hồng - Thắp Sáng Tương Lai Tại Đại Học Kinh Tế Đà Nẵng',
N'Hãy cùng chúng tôi biến những giọt máu hồng thành ngọn lửa hy vọng tại Đại học Kinh tế Đà Nẵng và các trung tâm y tế trong thành phố! Chương trình hiến máu tình nguyện lần này không chỉ là cơ hội để bạn đóng góp cho cộng đồng, mà còn là dịp để thể hiện tinh thần trách nhiệm và lòng nhân ái. Mỗi giọt máu bạn hiến tặng là một món quà vô giá, mang lại sự sống cho những người đang cần. Hãy đăng ký ngay hôm nay để cùng chúng tôi thắp sáng tương lai và lan tỏa yêu thương khắp thành phố Đà Nẵng!',
N'Phòng tổ chức rộng tối thiểu 180m², đầy đủ ánh sáng tự nhiên; Hệ thống điện, nước tốt; Có khu vực vệ sinh sạch sẽ; Chỗ để xe an toàn cho tối thiểu 40 xe máy và 8 ô tô; Bàn ghế thoải mái; Thiết bị y tế cần thiết; Tối thiểu 35 tình nguyện viên tham gia.',
120, '2025-06-14', '2025-06-17 08:00:00', '2025-06-17 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000004', 'GD00000005', N'Hành Trình Hiến Máu - Kết Nối Tình Người Tại Đại Học Sư Phạm Kỹ Thuật Đà Nẵng',
N'Hiến máu là nghĩa cử cao đẹp, là cách chúng ta trao đi yêu thương và hy vọng. Hãy tham gia chương trình hiến máu tình nguyện tại Đại học Sư Phạm Kỹ Thuật Đà Nẵng và các trung tâm y tế trong thành phố. Mỗi đơn vị máu bạn hiến tặng là một cơ hội để cứu sống những người đang cần sự giúp đỡ. Đừng ngần ngại, hãy đăng ký ngay để cùng chúng tôi lan tỏa tinh thần nhân đạo, thắp sáng niềm tin và mang lại nụ cười cho cộng đồng. Hành trình này cần có bạn - những trái tim nhiệt huyết và đầy yêu thương!',
N'Phòng trên 160m², thông thoáng; Có đầy đủ điện, nước, và nhà vệ sinh; Chỗ để xe rộng, an toàn cho tối thiểu 30 xe máy và 5 ô tô; Trang bị bàn ghế, thiết bị y tế; Ít nhất 40 tình nguyện viên.',
200, '2025-06-15', '2025-06-18 08:00:00', '2025-06-18 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000005', 'GD00000005', N'Hiến Máu Cứu Người - Chung Tay Vì Cộng Đồng Tại Đại Học Sư Phạm Đà Nẵng',
N'Mỗi giọt máu là một món quà, mỗi món quà là một cuộc đời! Hãy tham gia chương trình hiến máu tình nguyện tại Đại học Sư Phạm Đà Nẵng và các trung tâm y tế trong thành phố. Đây là cơ hội để bạn góp phần mang lại hy vọng, lan tỏa yêu thương và thắp sáng niềm tin cho cộng đồng. Đăng ký ngay để cùng chúng tôi viết nên những câu chuyện đẹp về lòng nhân ái!',
N'Phòng phải có diện tích tối thiểu 170m²; Có ánh sáng và thông thoáng; Hệ thống điện nước tốt; Nhà vệ sinh tiện nghi; Chỗ để xe rộng rãi cho ít nhất 35 xe máy và 7 ô tô; Có bàn ghế và thiết bị y tế; Tối thiểu 45 tình nguyện viên tham gia.',
220, '2025-06-16', '2025-06-19 08:00:00', '2025-06-19 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000006', 'GD00000005', N'Hành Động Nhỏ, Ý Nghĩa Lớn - Hiến Máu Tại Trường Cao Đẳng Y Tế Đà Nẵng',
N'Một hành động nhỏ có thể tạo nên điều kỳ diệu! Hãy tham gia chương trình hiến máu tình nguyện tại các trung tâm y tế và trường đại học trên địa bàn Đà Nẵng. Mỗi giọt máu bạn hiến tặng là một tia hy vọng, một món quà quý giá dành cho những bệnh nhân đang chiến đấu với bệnh tật. Chúng tôi kêu gọi các bạn sinh viên, giảng viên và cộng đồng cùng chung tay, cùng sẻ chia để mang lại sự sống và niềm vui. Đăng ký ngay để trở thành một phần của hành trình nhân ái này!',
N'Phòng có diện tích tối thiểu 160m², đầy đủ ánh sáng và thông thoáng; Hệ thống điện, nước tốt; Nhà vệ sinh sạch sẽ; Khu vực đỗ xe cho tối thiểu 40 xe máy và 10 ô tô; Trang bị bàn ghế và thiết bị y tế; Tối thiểu 40 tình nguyện viên.',
180, '2025-06-17', '2025-06-20 08:00:00', '2025-06-20 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000007', 'GD00000005', N'Ngày Hội Hiến Máu - Kết Nối Yêu Thương Tại Trung Tâm Y Tế Quận Hải Châu',
N'Hãy cùng chúng tôi mang đến những phép màu cho cuộc sống! Tham gia chương trình hiến máu tình nguyện tại Trung tâm Y tế Hải Châu và các trường đại học trong thành phố Đà Nẵng. Mỗi giọt máu bạn hiến tặng là một tia sáng hy vọng, là món quà vô giá dành cho những người đang chiến đấu với bệnh tật. Đăng ký ngay hôm nay để trở thành một phần của hành trình nhân ái, lan tỏa yêu thương và kết nối cộng đồng Đà Nẵng!',
N'Phòng tổ chức có diện tích tối thiểu 140m²; Có hệ thống điện, nước ổn định; Nhà vệ sinh tiện nghi; Khu vực đỗ xe an toàn cho tối thiểu 30 xe máy và 5 ô tô; Có bàn ghế, thiết bị y tế; Tối thiểu 35 tình nguyện viên.',
160, '2025-06-18', '2025-06-21 08:00:00', '2025-06-21 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000008', 'GD00000005', N'Giọt Máu Cho Đi - Sự Sống Nở Hoa Tại Bệnh Viện Đà Nẵng',
N'Hãy cùng chúng tôi mang đến những điều kỳ diệu từ những giọt máu hồng! Chương trình hiến máu tình nguyện tại Bệnh viện Đà Nẵng và các trường đại học Đà Nẵng là cơ hội để bạn góp phần cứu sống những người đang cần. Mỗi giọt máu bạn hiến tặng là một món quà vô giá, là biểu tượng của lòng nhân ái và tinh thần đoàn kết. Đăng ký ngay để cùng chúng tôi lan tỏa yêu thương và thắp sáng tương lai!',
N'Phòng có diện tích tối thiểu 150m²; Có ánh sáng tự nhiên và thông thoáng; Hệ thống điện nước ổn định; Nhà vệ sinh sạch sẽ; Khu vực đỗ xe an toàn cho tối thiểu 50 xe máy và 10 ô tô; Có bàn ghế và thiết bị y tế; Tối thiểu 45 tình nguyện viên.',
190, '2025-06-19', '2025-06-22 08:00:00', '2025-06-22 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000009', 'GD00000005', N'Hiến Máu Nhân Đạo - Chung Tay Cứu Sống Tại Bệnh Viện Phụ Sản - Nhi Đà Nẵng',
N'Hãy để giọt máu của bạn trở thành nguồn sống cho những người đang cần! Tham gia chương trình hiến máu tình nguyện tại Bệnh viện Phụ Sản - Nhi Đà Nẵng và các trung tâm y tế trong thành phố. Đây là cơ hội để bạn thể hiện lòng nhân ái, góp phần mang lại hy vọng và sức mạnh cho cộng đồng. Mỗi hành động của bạn là một câu chuyện đẹp, là ngọn lửa thắp sáng tương lai. Đăng ký ngay để cùng chúng tôi lan tỏa yêu thương!',
N'Phòng tổ chức phải rộng tối thiểu 140m²; Có hệ thống điện nước đầy đủ; Nhà vệ sinh sạch sẽ; Khu vực đỗ xe an toàn cho ít nhất 30 xe máy và 7 ô tô; Có bàn ghế và thiết bị y tế; Tối thiểu 40 tình nguyện viên.',
180, '2025-06-20', '2025-06-23 08:00:00', '2025-06-23 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000010', 'GD00000005', N'Giọt Máu Rực Rỡ - Ngày Hội Hiến Máu Tại Bệnh Viện Ung Bướu Đà Nẵng',
N'Hãy cùng chúng tôi thắp sáng ngọn lửa yêu thương tại Bệnh viện Ung Bướu Đà Nẵng và các trung tâm y tế trong thành phố! Chương trình hiến máu tình nguyện lần này là cơ hội để bạn thể hiện tinh thần nhân đạo, góp phần mang lại sự sống cho những người đang cần. Mỗi giọt máu bạn hiến tặng là một món quà vô giá, là cầu nối giữa những trái tim. Đăng ký ngay hôm nay để cùng chúng tôi lan tỏa thông điệp nhân ái và xây dựng một cộng đồng đoàn kết!',
N'Phòng tổ chức có diện tích tối thiểu 160m²; Ánh sáng và thông thoáng; Có điện, nước và nhà vệ sinh đầy đủ; Khu vực đỗ xe an toàn cho tối thiểu 40 xe máy và 8 ô tô; Bàn ghế và thiết bị y tế đầy đủ; Tối thiểu 45 tình nguyện viên.',
130, '2025-06-21', '2025-06-24 08:00:00', '2025-06-24 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000011', 'GD00000005', N'Giọt Máu Hồng - Thắp Sáng Tương Lai Tại Trung Tâm Y Tế Quận Thanh Khê',
N'Hãy cùng chúng tôi thắp sáng ngọn lửa yêu thương tại Trung tâm Y tế Thanh Khê và các trường đại học Đà Nẵng! Chương trình hiến máu tình nguyện lần này là cơ hội để bạn thể hiện tinh thần nhân đạo, góp phần mang lại sự sống cho những người đang cần. Mỗi giọt máu bạn hiến tặng là một món quà vô giá, là cầu nối giữa những trái tim. Đăng ký ngay để cùng chúng tôi lan tỏa yêu thương!',
N'Phòng tổ chức tối thiểu 180m²; Có ánh sáng tự nhiên và thông thoáng; Hệ thống điện nước hoạt động tốt; Nhà vệ sinh sạch sẽ; Khu vực đỗ xe rộng rãi; Trang bị bàn ghế và thiết bị y tế; Tối thiểu 50 tình nguyện viên tham gia.',
230, '2025-06-22', '2025-06-25 08:00:00', '2025-06-25 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000012', 'GD00000005', N'Sẻ Chia Máu, Sẻ Chia Sự Sống - Ngày Hội Tại Trung Tâm Kiểm Soát Bệnh Tật Đà Nẵng',
N'Hãy để trái tim bạn lên tiếng! Tham gia ngay chương trình hiến máu tình nguyện tại Trung tâm Kiểm Soát Bệnh Tật Đà Nẵng và các trung tâm y tế trong thành phố. Mỗi giọt máu bạn hiến tặng là một lời hứa cho sự sống, một món quà nhân ái dành cho những người đang cần. Đăng ký ngay hôm nay để cùng chúng tôi lan tỏa thông điệp "Sẻ chia máu, sẻ chia sự sống"!',
N'Phòng tổ chức tối thiểu 140m²; Có ánh sáng, điện nước đầy đủ; Nhà vệ sinh tiện nghi; Khu vực đỗ xe an toàn cho tối thiểu 35 xe máy và 7 ô tô; Có bàn ghế và thiết bị y tế; Tối thiểu 40 tình nguyện viên tham gia.',
90, '2025-06-12', '2025-06-15 08:00:00', '2025-06-15 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000013', 'GD00000005', N'Hành Trình Hiến Máu - Lan Tỏa Tình Người Tại Trường Cao Đẳng Công Nghệ Đà Nẵng',
N'Một giọt máu cho đi, một cuộc đời ở lại! Hãy tham gia chương trình hiến máu tình nguyện tại Trường Cao Đẳng Công Nghệ Đà Nẵng và các trung tâm y tế trong thành phố. Đây là cơ hội để bạn thể hiện tinh thần nhân đạo, mang lại hy vọng và sức sống cho những bệnh nhân đang cần máu. Hãy đăng ký ngay để cùng chúng tôi lan tỏa thông điệp yêu thương, kết nối cộng đồng và thắp sáng những nụ cười!',
N'Phòng tổ chức có diện tích tối thiểu 160m²; Đầy đủ ánh sáng, điện nước; Nhà vệ sinh sạch sẽ; Khu vực đỗ xe an toàn; Trang bị bàn ghế và thiết bị y tế; Tối thiểu 45 tình nguyện viên tham gia.',
200, '2025-06-13', '2025-06-16 08:00:00', '2025-06-16 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000014', 'GD00000005', N'Hiến Máu Cứu Người - Chung Tay Vì Cộng Đồng Tại Đại Học Ngoại Ngữ Đà Nẵng',
N'Mỗi giọt máu là một món quà, mỗi món quà là một cuộc đời! Hãy tham gia chương trình hiến máu tình nguyện tại Đại học Ngoại Ngữ Đà Nẵng và các trung tâm y tế trong thành phố. Đây là cơ hội để bạn góp phần mang lại hy vọng, lan tỏa yêu thương và thắp sáng niềm tin cho cộng đồng. Đăng ký ngay để cùng chúng tôi viết nên những câu chuyện đẹp về lòng nhân ái!',
N'Phòng tổ chức có diện tích tối thiểu 150m²; Có ánh sáng tự nhiên và thông thoáng; Có điện nước đầy đủ; Nhà vệ sinh tiện nghi; Khu vực đỗ xe rộng; Trang bị bàn ghế và thiết bị y tế; Tối thiểu 40 tình nguyện viên tham gia.',
220, '2025-06-14', '2025-06-17 08:00:00', '2025-06-17 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000015', 'GD00000005', N'Giọt Máu Cho Đi - Sự Sống Nở Hoa Tại Trung Tâm Y Tế Quận Cẩm Lệ',
N'Hãy cùng chúng tôi mang đến những điều kỳ diệu từ những giọt máu hồng! Chương trình hiến máu tình nguyện tại Trung tâm Y tế Quận Cẩm Lệ và các trường đại học Đà Nẵng là cơ hội để bạn góp phần cứu sống những người đang cần. Mỗi giọt máu bạn hiến tặng là một món quà vô giá, là biểu tượng của lòng nhân ái và tinh thần đoàn kết. Đăng ký ngay để cùng chúng tôi lan tỏa yêu thương và thắp sáng tương lai!',
N'Phòng tổ chức có diện tích tối thiểu 160m²; Đầy đủ ánh sáng, hệ thống điện nước tốt; Nhà vệ sinh sạch sẽ; Khu vực đỗ xe an toàn cho ít nhất 40 xe máy và 8 ô tô; Có bàn ghế và thiết bị y tế; Tối thiểu 45 tình nguyện viên.',
190, '2025-06-15', '2025-06-18 08:00:00', '2025-06-18 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000016', 'GD00000005', N'Hiến Máu Nhân Đạo - Chung Tay Vì Cộng Đồng Tại Bệnh Viện Chỉnh Hình Và Phục Hồi Chức Năng Đà Nẵng',
N'Bạn có muốn trở thành người hùng trong lòng ai đó? Hãy tham gia chương trình hiến máu tình nguyện tại Bệnh viện Chỉnh Hình Và Phục Hồi Chức Năng Đà Nẵng và các trung tâm y tế trong thành phố. Một hành động nhỏ của bạn có thể mang lại phép màu cho những bệnh nhân đang cần máu. Hãy đăng ký ngay để cùng chúng tôi tạo nên một Đà Nẵng tràn ngập yêu thương và hy vọng!',
N'Phòng tổ chức có diện tích tối thiểu 180m²; Có ánh sáng tự nhiên và thông thoáng; Hệ thống điện nước hoạt động tốt; Nhà vệ sinh sạch sẽ; Khu vực đỗ xe an toàn rộng rãi; Có bàn ghế và thiết bị y tế; Tối thiểu 50 tình nguyện viên.',
250, '2025-06-16', '2025-06-19 08:00:00', '2025-06-19 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000017', 'GD00000005', N'Giọt Máu Rực Rỡ - Ngày Hội Hiến Máu Tại Trung Tâm Y Tế Quận Sơn Trà',
N'Hãy cùng chúng tôi thắp sáng ngọn lửa yêu thương tại Trung tâm Y tế Quận Sơn Trà và các trung tâm y tế trong thành phố! Chương trình hiến máu tình nguyện lần này là cơ hội để bạn thể hiện tinh thần nhân đạo, góp phần mang lại sự sống cho những người đang cần. Mỗi giọt máu bạn hiến tặng là một món quà vô giá, là cầu nối giữa những trái tim. Đăng ký ngay hôm nay để cùng chúng tôi lan tỏa thông điệp nhân ái và xây dựng một cộng đồng đoàn kết!',
N'Phòng tổ chức diện tích tối thiểu 150m²; Đầy đủ ánh sáng và thông thoáng; Hệ thống điện nước tốt; Nhà vệ sinh sạch sẽ; Khu vực đỗ xe rộng; Có bàn ghế và thiết bị y tế; Tối thiểu 45 tình nguyện viên.',
130, '2025-06-17', '2025-06-20 08:00:00', '2025-06-20 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000018', 'GD00000005', N'Hành Trình Hiến Máu - Kết Nối Tình Người Tại Đại Học Sư Phạm Đà Nẵng',
N'Hiến máu là nghĩa cử cao đẹp, là cách chúng ta trao đi yêu thương và hy vọng. Hãy tham gia chương trình hiến máu tình nguyện tại Đại học Sư Phạm Đà Nẵng và các trung tâm y tế trong thành phố. Mỗi đơn vị máu bạn hiến tặng là một cơ hội để cứu sống những người đang cần sự giúp đỡ. Đừng ngần ngại, hãy đăng ký ngay để cùng chúng tôi lan tỏa tinh thần nhân đạo, thắp sáng niềm tin và mang lại nụ cười cho cộng đồng. Hành trình này cần có bạn - những trái tim nhiệt huyết và đầy yêu thương!',
N'Phòng tổ chức có diện tích tối thiểu 160m²; Đầy đủ ánh sáng tự nhiên; Hệ thống điện nước ổn định; Nhà vệ sinh sạch sẽ; Khu vực đỗ xe an toàn; Có bàn ghế và thiết bị y tế; Tối thiểu 40 tình nguyện viên.',
200, '2025-06-18', '2025-06-21 08:00:00', '2025-06-21 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000019', 'GD00000005', N'Sẻ Chia Máu, Sẻ Chia Sự Sống - Ngày Hội Tại Viện Nghiên Cứu Và Đào Tạo Việt - Anh Đà Nẵng',
N'Hãy để trái tim bạn lên tiếng! Tham gia ngay chương trình hiến máu tình nguyện tại Viện Nghiên Cứu Và Đào Tạo Việt - Anh Đà Nẵng và các trung tâm y tế trong thành phố. Mỗi giọt máu bạn hiến tặng là một lời hứa cho sự sống, một món quà nhân ái dành cho những người đang cần. Đăng ký ngay hôm nay để cùng chúng tôi lan tỏa thông điệp "Sẻ chia máu, sẻ chia sự sống"!',
N'Phòng tổ chức có diện tích tối thiểu 140m²; Đầy đủ ánh sáng; Hệ thống điện nước hoạt động; Nhà vệ sinh sạch sẽ; Khu vực đỗ xe an toàn; Có bàn ghế và thiết bị y tế; Tối thiểu 35 tình nguyện viên.',
90, '2025-06-19', '2025-06-22 08:00:00', '2025-06-22 17:00:00', '2025-06-10 23:17:00', NULL),
('TBDK000020', 'GD00000005', N'Giọt Máu Hồng - Thắp Sáng Tương Lai Tại Bệnh Viện 199 - Bộ Công An Tại Đà Nẵng',
N'Hãy cùng chúng tôi thắp sáng ngọn lửa yêu thương tại Bệnh viện 199 - Bộ Công An Tại Đà Nẵng và các trường đại học Đà Nẵng! Chương trình hiến máu tình nguyện lần này là cơ hội để bạn thể hiện tinh thần nhân đạo, góp phần mang lại sự sống cho những người đang cần. Mỗi giọt máu bạn hiến tặng là một món quà vô giá, là cầu nối giữa những trái tim. Đăng ký ngay để cùng chúng tôi lan tỏa yêu thương!',
N'Phòng tổ chức tối thiểu 150m²; Đầy đủ ánh sáng và thông thoáng; Hệ thống điện nước tốt; Nhà vệ sinh sạch sẽ; Khu vực đỗ xe rộng rãi; Bàn ghế và thiết bị y tế đầy đủ; Tối thiểu 45 tình nguyện viên tham gia.',
230, '2025-06-20', '2025-06-23 08:00:00', '2025-06-23 17:00:00', '2025-06-10 23:17:00', NULL);
GO

INSERT INTO DangKiToChucHienMau (IdSuKien, IdThongBaoDK, IdCoSoTinhNguyen, NgayDangKi, TinhTrangDK, SoLuongDK, SoLuongDDK, TrangThaiSuKien, HanDK, TgBatDauSK, TgKetThucSK, NgayTao, NgaySua)
VALUES
('SK00000001', 'TBDK000001', 'CSTN000001', '2025-06-10 23:17:00', N'Đã duyệt', 100, 120, N'Đã duyệt', '2025-06-14', '2025-06-15 08:00:00', '2025-06-15 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000002', 'TBDK000002', 'CSTN000002', '2025-06-10 23:17:00', N'Chưa duyệt', 150, 100, N'Chưa duyệt', '2025-06-15', '2025-06-16 08:00:00', '2025-06-16 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000003', 'TBDK000003', 'CSTN000003', '2025-06-10 23:17:00', N'Đã duyệt', 120, 180, N'Đã duyệt', '2025-06-16', '2025-06-17 08:00:00', '2025-06-17 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000004', 'TBDK000004', 'CSTN000004', '2025-06-10 23:17:00', N'Từ chối', 200, 90, N'Chưa duyệt', '2025-06-17', '2025-06-18 08:00:00', '2025-06-18 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000005', 'TBDK000005', 'CSTN000005', '2025-06-10 23:17:00', N'Đã duyệt', 220, 140, N'Đã duyệt', '2025-06-18', '2025-06-19 08:00:00', '2025-06-19 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000006', 'TBDK000006', 'CSTN000006', '2025-06-10 23:17:00', N'Chưa duyệt', 180, 80, N'Chưa duyệt', '2025-06-19', '2025-06-20 08:00:00', '2025-06-20 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000007', 'TBDK000007', 'CSTN000007', '2025-06-10 23:17:00', N'Đã duyệt', 160, 130, N'Đã duyệt', '2025-06-20', '2025-06-21 08:00:00', '2025-06-21 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000008', 'TBDK000008', 'CSTN000008', '2025-06-10 23:17:00', N'Từ chối', 190, 100, N'Chưa duyệt', '2025-06-21', '2025-06-22 08:00:00', '2025-06-22 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000009', 'TBDK000009', 'CSTN000009', '2025-06-10 23:17:00', N'Đã duyệt', 180, 150, N'Đã duyệt', '2025-06-22', '2025-06-23 08:00:00', '2025-06-23 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000010', 'TBDK000010', 'CSTN000010', '2025-06-10 23:17:00', N'Chưa duyệt', 130, 110, N'Chưa duyệt', '2025-06-23', '2025-06-24 08:00:00', '2025-06-24 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000011', 'TBDK000011', 'CSTN000011', '2025-06-10 23:17:00', N'Đã duyệt', 230, 160, N'Đã duyệt', '2025-06-24', '2025-06-25 08:00:00', '2025-06-25 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000012', 'TBDK000012', 'CSTN000012', '2025-06-10 23:17:00', N'Từ chối', 90, 80, N'Chưa duyệt', '2025-06-14', '2025-06-15 08:00:00', '2025-06-15 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000013', 'TBDK000013', 'CSTN000013', '2025-06-10 23:17:00', N'Đã duyệt', 200, 170, N'Đã duyệt', '2025-06-15', '2025-06-16 08:00:00', '2025-06-16 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000014', 'TBDK000014', 'CSTN000014', '2025-06-10 23:17:00', N'Chưa duyệt', 220, 120, N'Chưa duyệt', '2025-06-16', '2025-06-17 08:00:00', '2025-06-17 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000015', 'TBDK000015', 'CSTN000015', '2025-06-10 23:17:00', N'Đã duyệt', 190, 180, N'Đã duyệt', '2025-06-17', '2025-06-18 08:00:00', '2025-06-18 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000016', 'TBDK000016', 'CSTN000016', '2025-06-10 23:17:00', N'Từ chối', 250, 90, N'Chưa duyệt', '2025-06-18', '2025-06-19 08:00:00', '2025-06-19 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000017', 'TBDK000017', 'CSTN000017', '2025-06-10 23:17:00', N'Đã duyệt', 130, 190, N'Đã duyệt', '2025-06-19', '2025-06-20 08:00:00', '2025-06-20 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000018', 'TBDK000018', 'CSTN000018', '2025-06-10 23:17:00', N'Chưa duyệt', 200, 130, N'Chưa duyệt', '2025-06-20', '2025-06-21 08:00:00', '2025-06-21 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000019', 'TBDK000019', 'CSTN000019', '2025-06-10 23:17:00', N'Đã duyệt', 90, 200, N'Đã duyệt', '2025-06-21', '2025-06-22 08:00:00', '2025-06-22 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000020', 'TBDK000020', 'CSTN000020', '2025-06-10 23:17:00', N'Từ chối', 230, 100, N'Chưa duyệt', '2025-06-22', '2025-06-23 08:00:00', '2025-06-23 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000021', 'TBDK000001', 'CSTN000010', '2025-06-10 23:17:00', N'Đã duyệt', 140, 110, N'Đã duyệt', '2025-06-14', '2025-06-15 08:00:00', '2025-06-15 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000022', 'TBDK000002', 'CSTN000009', '2025-06-10 23:17:00', N'Chưa duyệt', 170, 90, N'Chưa duyệt', '2025-06-15', '2025-06-16 08:00:00', '2025-06-16 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000023', 'TBDK000003', 'CSTN000008', '2025-06-10 23:17:00', N'Đã duyệt', 130, 160, N'Đã duyệt', '2025-06-16', '2025-06-17 08:00:00', '2025-06-17 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000024', 'TBDK000004', 'CSTN000007', '2025-06-10 23:17:00', N'Từ chối', 180, 80, N'Chưa duyệt', '2025-06-17', '2025-06-18 08:00:00', '2025-06-18 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000025', 'TBDK000005', 'CSTN000006', '2025-06-10 23:17:00', N'Đã duyệt', 200, 140, N'Đã duyệt', '2025-06-18', '2025-06-19 08:00:00', '2025-06-19 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000026', 'TBDK000006', 'CSTN000005', '2025-06-10 23:17:00', N'Chưa duyệt', 160, 100, N'Chưa duyệt', '2025-06-19', '2025-06-20 08:00:00', '2025-06-20 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000027', 'TBDK000007', 'CSTN000004', '2025-06-10 23:17:00', N'Đã duyệt', 150, 120, N'Đã duyệt', '2025-06-20', '2025-06-21 08:00:00', '2025-06-21 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000028', 'TBDK000008', 'CSTN000003', '2025-06-10 23:17:00', N'Từ chối', 190, 110, N'Chưa duyệt', '2025-06-21', '2025-06-22 08:00:00', '2025-06-22 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000029', 'TBDK000009', 'CSTN000002', '2025-06-10 23:17:00', N'Đã duyệt', 170, 130, N'Đã duyệt', '2025-06-22', '2025-06-23 08:00:00', '2025-06-23 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000030', 'TBDK000010', 'CSTN000001', '2025-06-10 23:17:00', N'Chưa duyệt', 140, 100, N'Chưa duyệt', '2025-06-23', '2025-06-24 08:00:00', '2025-06-24 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000031', 'TBDK000001', 'CSTN000020', '2025-06-10 23:17:00', N'Đã duyệt', 210, 150, N'Đã duyệt', '2025-06-14', '2025-06-15 08:00:00', '2025-06-15 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000032', 'TBDK000002', 'CSTN000019', '2025-06-10 23:17:00', N'Từ chối', 100, 90, N'Chưa duyệt', '2025-06-15', '2025-06-16 08:00:00', '2025-06-16 17:00:00', '2025-06-10 23:00:00', '2025-06-10 23:17:00'),
('SK00000033', 'TBDK000003', 'CSTN000018', '2025-06-10 23:17:00', N'Đã duyệt', 180, 160, N'Đã duyệt', '2025-06-16', '2025-06-17 08:00:00', '2025-06-17 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:00:00'),
('SK00000034', 'TBDK000004', 'CSTN000017', '2025-06-10 23:17:00', N'Chưa duyệt', 220, 120, N'Chưa duyệt', '2025-06-17', '2025-06-18 08:00:00', '2025-06-18 17:00:00', '2025-06-10 23:00:00', '2025-06-10 23:17:00'),
('SK00000035', 'TBDK000005', 'CSTN000016', '2025-06-10 23:17:00', N'Đã duyệt', 190, 170, N'Đã duyệt', '2025-06-18', '2025-06-19 08:00:00', '2025-06-19 17:00:00', '2025-06-10 23:00:00', '2025-06-10 23:17:00'),
('SK00000036', 'TBDK000006', 'CSTN000015', '2025-06-10 23:17:00', N'Từ chối', 240, 100, N'Chưa duyệt', '2025-06-19', '2025-06-20 08:00:00', '2025-06-20 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000037', 'TBDK000007', 'CSTN000014', '2025-06-10 23:17:00', N'Đã duyệt', 130, 180, N'Đã duyệt', '2025-06-20', '2025-06-21 08:00:00', '2025-06-21 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000038', 'TBDK000008', 'CSTN000013', '2025-06-10 23:17:00', N'Chưa duyệt', 200, 110, N'Chưa duyệt', '2025-06-21', '2025-06-22 08:00:00', '2025-06-22 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000039', 'TBDK000009', 'CSTN000012', '2025-06-01 23:17:00', N'Đã duyệt', 110, 190, N'Đã duyệt', '2025-06-22', '2025-06-23 08:00:00', '2025-06-23 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:00:00'),
('SK00000040', 'TBDK000010', 'CSTN000011', '2025-06-10 23:17:00', N'Từ chối', 230, 100, N'Chưa duyệt', '2025-06-23', '2025-06-24 08:00:00', '2025-06-24 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000041', 'TBDK000001', 'CSTN000015', '2025-06-10 23:17:00', N'Đã duyệt', 150, 120, N'Đã duyệt', '2025-06-14', '2025-06-15 08:00:00', '2025-06-15 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000042', 'TBDK000002', 'CSTN000016', '2025-06-10 23:17:00', N'Chưa duyệt', 180, 100, N'Chưa duyệt', '2025-06-15', '2025-06-16 08:00:00', '2025-06-16 17:00:00', '2025-06-10 23:00:00', '2025-06-10 23:17:00'),
('SK00000043', 'TBDK000003', 'CSTN000017', '2025-06-10 23:17:00', N'Từ chối', 200, 90, N'Chưa duyệt', '2025-06-16', '2025-06-17 08:00:00', '2025-06-17 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000044', 'TBDK000004', 'CSTN000018', '2025-06-10 23:17:00', N'Từ chối', 170, 110, N'Chưa duyệt', '2025-06-17', '2025-06-18 08:00:00', '2025-06-18 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000045', 'TBDK000005', 'CSTN000019', '2025-06-10 23:17:00', N'Đã duyệt', 190, 130, N'Đã duyệt', '2025-06-18', '2025-06-19 08:00:00', '2025-06-19 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000046', 'TBDK000006', 'CSTN000001', '2025-06-10 23:17:00', N'Chưa duyệt', 160, 140, N'Chưa duyệt', '2025-06-19', '2025-06-20 08:00:00', '2025-06-20 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000047', 'TBDK000007', 'CSTN000002', '2025-06-10 23:17:00', N'Đã duyệt', 210, 150, N'Đã duyệt', '2025-06-20', '2025-06-21 08:00:00', '2025-06-21 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000048', 'TBDK000008', 'CSTN000003', '2025-06-10 23:17:00', N'Từ chối', 140, 210, N'Chưa duyệt', '2025-06-21', '2025-06-22 08:00:00', '2025-06-22 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000049', 'TBDK000009', 'CSTN000004', '2025-06-10 23:17:00', N'Đã duyệt', 220, 160, N'Đã duyệt', '2025-06-22', '2025-06-23 08:00:00', '2025-06-23 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000050', 'TBDK000010', 'CSTN000005', '2025-06-10 23:17:00', N'Chưa duyệt', 130, 110, N'Chưa duyệt', '2025-06-23', '2025-06-24 08:00:00', '2025-06-24 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000051', 'TBDK000001', 'CSTN000005', '2025-06-10 23:17:00', N'Đã duyệt', 230, 170, N'Đã duyệt', '2025-06-14', '2025-06-15 08:00:00', '2025-06-15 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000052', 'TBDK000002', 'CSTN000006', '2025-06-10 23:17:00', N'Từ chối', 180, 120, N'Chưa duyệt', '2025-06-15', '2025-06-16 08:00:00', '2025-06-16 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000053', 'TBDK000003', 'CSTN000007', '2025-06-10 23:17:00', N'Đã duyệt', 200, 140, N'Đã duyệt', '2025-06-16', '2025-06-17 08:00:00', '2025-06-17 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000054', 'TBDK000004', 'CSTN000008', '2025-06-10 23:17:00', N'Chưa duyệt', 150, 100, N'Chưa duyệt', '2025-06-17', '2025-06-18 08:00:00', '2025-06-18 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000055', 'TBDK000005', 'CSTN000009', '2025-06-10 23:17:00', N'Từ chối', 240, 130, N'Chưa duyệt', '2025-06-18', '2025-06-19 08:00:00', '2025-06-19 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000056', 'TBDK000006', 'CSTN000015', '2025-06-10 23:17:00', N'Đã duyệt', 170, 150, N'Đã duyệt', '2025-06-19', '2025-06-20 08:00:00', '2025-06-20 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000057', 'TBDK000007', 'CSTN000016', '2025-06-10 23:17:00', N'Chưa duyệt', 190, 110, N'Chưa duyệt', '2025-06-20', '2025-06-21 08:00:00', '2025-06-21 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000058', 'TBDK000008', 'CSTN000017', '2025-06-10 23:17:00', N'Đã duyệt', 210, 160, N'Đã duyệt', '2025-06-21', '2025-06-22 08:00:00', '2025-06-22 17:00:00', '2025-06-10 23:00:00', '2025-06-10 23:17:00'),
('SK00000059', 'TBDK000009', 'CSTN000018', '2025-06-10 23:17:00', N'Từ chối', 160, 120, N'Chưa duyệt', '2025-06-22', '2025-06-23 08:00:00', '2025-06-23 17:00:00', '2025-06-10 23:17:00', '2025-06-10 23:17:00'),
('SK00000060', 'TBDK000010', 'CSTN000019', '2025-06-10 23:17:00', N'Đã duyệt', 220, 170, N'Đã duyệt', '2025-06-23', '2025-06-24 08:00:00', '2025-06-24 17:00:00', '2025-06-10 23:00:00', '2025-06-10 23:17:00');
GO
-- Insert into DanhMucDVMau
INSERT INTO DanhMucDVMau (IdDanhMucDVMau, SoLuongMau, GhiChu)
VALUES
('DMDVM00001', 150, N'Đơn vị máu 150ml'),
('DMDVM00002', 250, N'Đơn vị máu 250ml'),
('DMDVM00003', 350, N'Đơn vị máu 350ml'),
('DMDVM00004', 450, N'Đơn vị máu 450ml');
GO

 -- insert bảng DangKiHienMau
INSERT INTO DangKiHienMau (IdDangKiHienMau, IdNguoiHienMau, IdBacSi, IdNhanVienDuyet, IdSuKien, IdDanhMucDVMau, TrangThaiHienMau, TrangThaiDonDK, ChieuCao, CanNang, NhietDo, NhipTim, HuyetAp, DaTungHienMau, TienSuBenh, MacBenhHienTai, ThongTin12ThangQua, ThongTin6ThangQua, ThongTin1ThangQua, ThongTin14NgayQua, ThongTin7NgayQua, ThongTinPhuNu12ThangQua, TTSKKhamSangLoc, TTSKSauHien, GhiChu, NgayDangKi, NoiDungPhanHoi, NgayPhanHoi, TrangThaiNguoiHienMau)
VALUES
('DKHM000001', 'ND00000004', 'BS00000002', 'NV00000003', 'SK00000001', 'DMDVM00001', N'Chờ khám', N'Đã duyệt', 170.5, 65.0, 36.5, 80, 120, N'Có', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Đạt điều kiện', NULL, N'Khỏe mạnh', DATEADD(DAY, -10, GETDATE()), NULL, NULL, N'Đủ điều kiện'),
('DKHM000002', 'ND00000009', 'BS00000002', 'NV00000003', 'SK00000001', 'DMDVM00002', N'Chờ khám', N'Đã duyệt', 165.0, 60.0, 36.7, 75, 115, N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Đạt điều kiện', NULL, N'Khỏe mạnh', DATEADD(DAY, -9, GETDATE()), NULL, NULL, N'Đủ điều kiện'),
('DKHM000003', 'ND00000006', 'BS00000002', 'NV00000003', 'SK00000003', 'DMDVM00003', N'Chờ khám', N'Đã duyệt', 172.0, 70.0, 36.6, 78, 118, N'Có', N'Viêm gan B', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Không đạt', NULL, N'Có bệnh lý', DATEADD(DAY, -8, GETDATE()), NULL, NULL, N'Không đủ điều kiện'),
('DKHM000004', 'ND00000009', 'BS00000002', 'NV00000003', 'SK00000003', 'DMDVM00004', N'Chờ khám', N'Đã duyệt', 168.5, 62.5, 36.8, 82, 122, N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Đạt điều kiện', NULL, N'Khỏe mạnh', DATEADD(DAY, -7, GETDATE()), NULL, NULL, N'Đủ điều kiện'),
('DKHM000005', 'ND00000010', 'BS00000007', 'NV00000008', 'SK00000005', 'DMDVM00001', N'Chờ khám', N'Đã duyệt', 170.0, 66.0, 36.5, 79, 119, N'Có', N'Hen suyễn', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Không đạt', NULL, N'Có bệnh lý', DATEADD(DAY, -6, GETDATE()), NULL, NULL, N'Không đủ điều kiện'),
('DKHM000006', 'ND00000014', 'BS00000007', 'NV00000008', 'SK00000005', 'DMDVM00002', N'Chờ khám', N'Đã duyệt', 166.0, 61.0, 36.7, 76, 116, N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Đạt điều kiện', NULL, N'Khỏe mạnh', DATEADD(DAY, -5, GETDATE()), NULL, NULL, N'Đủ điều kiện'),
('DKHM000007', 'ND00000014', 'BS00000007', 'NV00000008', 'SK00000007', 'DMDVM00003', N'Chờ khám', N'Đã duyệt', 171.0, 68.0, 36.6, 80, 120, N'Có', N'Bệnh tim nhẹ', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Không đạt', NULL, N'Có bệnh lý', DATEADD(DAY, -4, GETDATE()), NULL, NULL, N'Không đủ điều kiện'),
('DKHM000008', 'ND00000015', 'BS00000007', 'NV00000008', 'SK00000007', 'DMDVM00004', N'Chờ khám', N'Đã duyệt', 169.0, 63.0, 36.8, 81, 121, N'Có', N'Không', N'Không', N'Đi nước ngoài', N'Không', N'Không', N'Không', N'Không', NULL, N'Đạt điều kiện', NULL, N'Khỏe mạnh', DATEADD(DAY, -3, GETDATE()), NULL, NULL, N'Đủ điều kiện'),
('DKHM000009', 'ND00000016', 'BS00000011', 'NV00000013', 'SK00000009', 'DMDVM00001', N'Chờ khám', N'Đã duyệt', 170.5, 65.5, 36.5, 79, 119, N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Đạt điều kiện', NULL, N'Khỏe mạnh', DATEADD(DAY, -2, GETDATE()), NULL, NULL, N'Đủ điều kiện'),
('DKHM000010', 'ND00000009', 'BS00000011', 'NV00000013', 'SK00000009', 'DMDVM00002', N'Chờ khám', N'Đã duyệt', 165.5, 60.5, 36.7, 75, 115, N'Có', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Đạt điều kiện', NULL, N'Khỏe mạnh', DATEADD(DAY, -1, GETDATE()), NULL, NULL, N'Đủ điều kiện'),
('DKHM000011', 'ND00000017', 'BS00000011', 'NV00000013', 'SK00000011', 'DMDVM00003', N'Chờ khám', N'Đã duyệt', 172.5, 70.5, 36.6, 78, 118, N'Có', N'Viêm gan B', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Không đạt', NULL, N'Có bệnh lý', DATEADD(DAY, -10, GETDATE()), NULL, NULL, N'Không đủ điều kiện'),
('DKHM000012', 'ND00000018', 'BS00000011', 'NV00000013', 'SK00000011', 'DMDVM00004', N'Chờ khám', N'Đã duyệt', 168.0, 62.0, 36.8, 82, 122, N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Đạt điều kiện', NULL, N'Khỏe mạnh', DATEADD(DAY, -9, GETDATE()), NULL, NULL, N'Đủ điều kiện'),
('DKHM000013', 'ND00000009', 'BS00000012', 'NV00000003', 'SK00000013', 'DMDVM00001', N'Chờ khám', N'Đã duyệt', 170.0, 66.0, 36.5, 79, 119, N'Có', N'Hen suyễn', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Không đạt', NULL, N'Có bệnh lý', DATEADD(DAY, -8, GETDATE()), NULL, NULL, N'Không đủ điều kiện'),
('DKHM000014', 'ND00000009', 'BS00000012', 'NV00000003', 'SK00000013', 'DMDVM00002', N'Chờ khám', N'Đã duyệt', 166.0, 61.0, 36.7, 76, 116, N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Đạt điều kiện', NULL, N'Khỏe mạnh', DATEADD(DAY, -7, GETDATE()), NULL, NULL, N'Đủ điều kiện'),
('DKHM000015', 'ND00000014', 'BS00000012', 'NV00000003', 'SK00000015', 'DMDVM00003', N'Chờ khám', N'Đã duyệt', 171.0, 68.0, 36.6, 80, 120, N'Có', N'Bệnh tim nhẹ', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Không đạt', NULL, N'Có bệnh lý', DATEADD(DAY, -6, GETDATE()), NULL, NULL, N'Không đủ điều kiện'),
('DKHM000016', 'ND00000009', 'BS00000012', 'NV00000003', 'SK00000015', 'DMDVM00004', N'Chờ khám', N'Đã duyệt', 169.0, 63.0, 36.8, 81, 121, N'Có', N'Không', N'Không', N'Đi nước ngoài', N'Không', N'Không', N'Không', N'Không', NULL, N'Đạt điều kiện', NULL, N'Khỏe mạnh', DATEADD(DAY, -5, GETDATE()), NULL, NULL, N'Đủ điều kiện'),
('DKHM000017', 'ND00000004', 'BS00000002', 'NV00000008', 'SK00000017', 'DMDVM00001', N'Chờ khám', N'Đã duyệt', 170.5, 65.5, 36.5, 79, 119, N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Đạt điều kiện', NULL, N'Khỏe mạnh', DATEADD(DAY, -4, GETDATE()), NULL, NULL, N'Đủ điều kiện'),
('DKHM000018', 'ND00000015', 'BS00000002', 'NV00000008', 'SK00000017', 'DMDVM00002', N'Chờ khám', N'Đã duyệt', 165.5, 60.5, 36.7, 75, 115, N'Có', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Đạt điều kiện', NULL, N'Khỏe mạnh', DATEADD(DAY, -3, GETDATE()), NULL, NULL, N'Đủ điều kiện'),
('DKHM000019', 'ND00000014', 'BS00000002', 'NV00000008', 'SK00000019', 'DMDVM00003', N'Chờ khám', N'Đã duyệt', 172.5, 70.5, 36.6, 78, 118, N'Có', N'Viêm gan B', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Không đạt', NULL, N'Có bệnh lý', DATEADD(DAY, -2, GETDATE()), NULL, NULL, N'Không đủ điều kiện'),
('DKHM000020', 'ND00000018', 'BS00000002', 'NV00000008', 'SK00000019', 'DMDVM00004', N'Chờ khám', N'Đã duyệt', 168.0, 62.0, 36.8, 82, 122, N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', N'Không', NULL, N'Đạt điều kiện', NULL, N'Khỏe mạnh', DATEADD(DAY, -1, GETDATE()), NULL, NULL, N'Đủ điều kiện');
GO

-- Insert into GiayChungNhan
INSERT INTO GiayChungNhan (IdGiayChungNhan, IdSuKienHienMau, IdNguoiDung, NgayCap)
VALUES
('GCN0000001', 'SK00000001', 'ND00000004', DATEADD(DAY, -5, GETDATE())),
('GCN0000002', 'SK00000001', 'ND00000009', DATEADD(DAY, -5, GETDATE())),
('GCN0000003', 'SK00000003', 'ND00000014', DATEADD(DAY, -4, GETDATE())),
('GCN0000004', 'SK00000003', 'ND00000009', DATEADD(DAY, -4, GETDATE())),
('GCN0000005', 'SK00000005', 'ND00000004', DATEADD(DAY, -3, GETDATE())),
('GCN0000006', 'SK00000005', 'ND00000009', DATEADD(DAY, -3, GETDATE())),
('GCN0000007', 'SK00000007', 'ND00000014', DATEADD(DAY, -2, GETDATE())),
('GCN0000008', 'SK00000007', 'ND00000009', DATEADD(DAY, -2, GETDATE())),
('GCN0000009', 'SK00000009', 'ND00000004', DATEADD(DAY, -1, GETDATE())),
('GCN0000010', 'SK00000009', 'ND00000009', DATEADD(DAY, -1, GETDATE())),
('GCN0000011', 'SK00000011', 'ND00000004', DATEADD(DAY, -5, GETDATE())),
('GCN0000012', 'SK00000011', 'ND00000009', DATEADD(DAY, -5, GETDATE())),
('GCN0000013', 'SK00000013', 'ND00000014', DATEADD(DAY, -4, GETDATE())),
('GCN0000014', 'SK00000013', 'ND00000010', DATEADD(DAY, -4, GETDATE())),
('GCN0000015', 'SK00000015', 'ND00000004', DATEADD(DAY, -3, GETDATE())),
('GCN0000016', 'SK00000015', 'ND00000009', DATEADD(DAY, -3, GETDATE())),
('GCN0000017', 'SK00000017', 'ND00000014', DATEADD(DAY, -2, GETDATE())),
('GCN0000018', 'SK00000017', 'ND00000009', DATEADD(DAY, -2, GETDATE())),
('GCN0000019', 'SK00000019', 'ND00000004', DATEADD(DAY, -1, GETDATE())),
('GCN0000020', 'SK00000019', 'ND00000009', DATEADD(DAY, -1, GETDATE()));
GO

-- lệnh cập nhật
update dbo.DangKiHienMau
set TrangThaiDonDK =N'Chưa duyệt'

update dbo.DangKiHienMau
set TrangThaiHienMau =N'Chưa duyệt'

update dbo.DangKiHienMau
set TTSKKhamSangLoc =N'Chưa duyệt'

update dbo.DangKiHienMau
set TrangThaiNguoiHienMau =N'Chưa duyệt'

-- Cập nhật database để set dữ liệu 
UPDATE dbo.DangKiHienMau
SET TrangThaiDonDK       = N'Hoàn thành',
    TrangThaiHienMau      = N'Đã hiến',
    TTSKKhamSangLoc       = N'Đã duyệt',
    TrangThaiNguoiHienMau = N'Đạt điều kiện',
	NgaySua = GETDATE()

WHERE idDangKiHienMau = 'DKHM000001';

