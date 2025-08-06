# Dự án Donate\_Blood

## 1. Giới thiệu

**Donate\_Blood** là một hệ thống quản lý hiến máu giúp kết nối giữa người hiến máu và các cơ sở y tế tình nguyện. Người dùng có thể đăng ký làm người hiến máu, theo dõi lịch hiến máu, trong khi các tổ chức tình nguyện có thể đăng ký tổ chức các sự kiện hiến máu. Hệ thống cũng cung cấp giao diện quản trị để phê duyệt hoặc từ chối các yêu cầu tổ chức sự kiện.

## 2. Tính năng chính

### 👤 Người hiến máu

* Đăng ký tài khoản.
* Cập nhật thông tin cá nhân và nhóm máu.
* Xem trạng thái đăng ký hiến máu.
* Theo dõi lịch sử và lịch hẹn hiến máu.

### 🏥 Cơ sở tình nguyện

* Đăng ký tài khoản tổ chức.
* Gửi yêu cầu tổ chức sự kiện hiến máu.

### 🔐 Quản trị viên

* Duyệt hoặc từ chối các yêu cầu tổ chức sự kiện.
* Quản lý thông tin người dùng và tổ chức.

## 3. Công nghệ sử dụng

| Thành phần    | Công nghệ                   |
| ------------- | --------------------------- |
| Backend       | C#, ASP.NET Core (.NET 8.0) |
| Cơ sở dữ liệu | Microsoft SQL Server        |
| Giao diện     | HTML, CSS, JavaScript       |

## 4. Hướng dẫn cài đặt

### Bước 1: Tải về mã nguồn

```bash
git clone https://github.com/nguyenvanlinh1105/donate_blood.git
cd donate_blood
```

### Bước 2: Mở bằng Visual Studio

* Mở file `.sln` bằng Visual Studio.
* Đảm bảo máy bạn đã cài đặt SDK .NET 8.0.

### Bước 3: Cấu hình kết nối cơ sở dữ liệu

* Mở file `appsettings.json`.
* Cập nhật thông tin kết nối SQL Server:

```json
"ConnectionStrings": {
  "DefaultConnection": "Server=TEN_SERVER;Database=HIENMAUNHANDAO;User Id=TEN_USER;Password=MAT_KHAU;TrustServerCertificate=True;"
}
```

### Bước 4: Chạy dự án

* Nhấn **F5** hoặc nút **Start** trong Visual Studio.
* Mở trình duyệt và truy cập địa chỉ `https://localhost:xxxx` (port tùy máy).

## 5. Cấu trúc dự án

```
donate_blood/
├── Controllers/          # Các API endpoint
├── Models/               # Các mô hình dữ liệu
├── Views/                # Giao diện người dùng (HTML/CSS/JS)
├── appsettings.json      # Tập tin cấu hình
└── Program.cs / Startup.cs
```

## 6. Ghi chú

Dự án hiện đang trong quá trình phát triển. Các tính năng dự kiến:

* Gửi email nhắc nhở lịch hiến máu.
* Tích hợp bản đồ để tìm sự kiện gần vị trí người dùng.
* Thống kê theo nhóm máu và khu vực.

## 7. Tác giả

* GitHub: [nguyenvanlinh1105](https://github.com/nguyenvanlinh1105)
* Dự án: [Donate\_Blood](https://github.com/nguyenvanlinh1105/donate_blood)

---