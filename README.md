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
## 8. Một số giao diện minh họa

Dưới đây là một số ảnh chụp giao diện người dùng của hệ thống:
Giao diện trang chủ
<img width="1919" height="1023" alt="image" src="https://github.com/user-attachments/assets/1b6b9700-0040-485c-9602-478582ee8637" />
<img width="1919" height="1021" alt="image" src="https://github.com/user-attachments/assets/039dfd88-c682-4e6e-8fce-ee1754193790" />

Giao diện đăng kí 
<img width="1919" height="1018" alt="image" src="https://github.com/user-attachments/assets/f5a196e3-3cdb-4e77-96f4-9a301123ff10" />
<img width="1917" height="1023" alt="image" src="https://github.com/user-attachments/assets/2edb7dab-4347-4570-a7d8-d6c15e836502" />

Giao diện đăng nhập
<img width="1919" height="1022" alt="image" src="https://github.com/user-attachments/assets/27a4da70-3b0e-4362-9f73-18133ed9fedd" />
<img width="1917" height="1017" alt="image" src="https://github.com/user-attachments/assets/66d8b628-5871-4136-b860-94988546fa64" />

Giao diện các câu hỏi thường gặp khi hiến máu
<img width="1919" height="1019" alt="image" src="https://github.com/user-attachments/assets/9c04b81a-45e3-4428-8106-cbfd6f226000" />

Giao diện trang liên hệ
<img width="1919" height="1020" alt="image" src="https://github.com/user-attachments/assets/758141d4-d5cd-46bb-848b-15c91d19f957" />

Trang tìm kiếm lịch đăng kí hiến máu
<img width="1911" height="1022" alt="image" src="https://github.com/user-attachments/assets/226a8952-9a9f-42b7-96c2-adc953c23818" />
<img width="1919" height="1021" alt="image" src="https://github.com/user-attachments/assets/e4c86fdb-7307-40e5-b83d-135f767ee59b" />

Giao diện sử đăng kí hiến máu
<img width="1919" height="1024" alt="image" src="https://github.com/user-attachments/assets/13608240-2024-4c9f-9434-0ac56579a8fd" />

Giao diện trang cá nhân 
<img width="1919" height="1019" alt="image" src="https://github.com/user-attachments/assets/2f9f4bf8-9478-4021-84e4-6b26107fda97" />

Giao diện giấy chứng nhận 
<img width="1919" height="1019" alt="image" src="https://github.com/user-attachments/assets/29cac23e-82cd-4951-bd58-4dd86a1ac90d" />

Giao diện duyệt đơn đăng kí tổ chức hiến máu 
<img width="626" height="335" alt="image" src="https://github.com/user-attachments/assets/7ff89659-9883-423a-ac5b-154584b24d76" />
<img width="626" height="330" alt="image" src="https://github.com/user-attachments/assets/2c347d6b-827f-4cb8-acbe-fb3a2be5ba0f" />
<img width="626" height="331" alt="image" src="https://github.com/user-attachments/assets/e6877de0-5f39-4c5c-a500-155feacd2c78" />
<img width="626" height="336" alt="image" src="https://github.com/user-attachments/assets/42d6d465-dd01-416c-9758-4f2f886b447f" />
<img width="626" height="336" alt="image" src="https://github.com/user-attachments/assets/bb2558de-dc98-427d-956b-674337aaf912" />
<img width="626" height="331" alt="image" src="https://github.com/user-attachments/assets/eb7d7a03-960d-4189-89e6-4d3b2fb24696" />

Quản trị duyệt sự kiện
<img width="1913" height="1028" alt="image" src="https://github.com/user-attachments/assets/15bb4418-f897-4f6a-bd87-24c65efe74bb" />
