create database BT_tuan5
use BT_tuan5
go
--tạo bảng khách hàng
CREATE TABLE KHACHHANG (
    MaKhachHang INT PRIMARY KEY,
    TenCongTy NVARCHAR(100),
    TenGiaoDich NVARCHAR(100),
    DiaChi NVARCHAR(200),
    DienThoai VARCHAR(15),
    Email NVARCHAR(100),
    Fax VARCHAR(15)
);
--tạo bảng nhà cung cấp
CREATE TABLE NHACUNGCAP (
    MaCongTy INT PRIMARY KEY,
    TenCongTy NVARCHAR(100),
    TenGiaoDich NVARCHAR(100),
    DiaChi NVARCHAR(200),
    DienThoai VARCHAR(15),
    Fax VARCHAR(15),
    Email NVARCHAR(100)
);
--tạo bảng loại hàng
CREATE TABLE LOAIHANG (
    MaLoaiHang INT PRIMARY KEY,
    TenLoaiHang NVARCHAR(100)
);
--tạo bảng mặt hàng
CREATE TABLE MATHANG (
    MaHang INT PRIMARY KEY,
    TenHang NVARCHAR(100),
    MaLoaiHang INT,
    MaCongTy INT,
    SoLuong INT,
    DonViTinh NVARCHAR(50),
    GiaHang DECIMAL(18, 2),
    FOREIGN KEY (MaLoaiHang) REFERENCES LOAIHANG(MaLoaiHang),
    FOREIGN KEY (MaCongTy) REFERENCES NHACUNGCAP(MaCongTy)
);
--tạo bảng nhân viên
CREATE TABLE NHANVIEN (
    MaNhanVien INT PRIMARY KEY,
    Ho NVARCHAR(50),
    Ten NVARCHAR(50),
    NgaySinh DATE,
    NgayLamViec DATE,
    DiaChi NVARCHAR(200),
    DienThoai VARCHAR(15),
    LuongCoBan DECIMAL(18, 2),
    PhuCap DECIMAL(18, 2)
);
--tạo bảng đơn đặt hàng 
CREATE TABLE DONDATHANG (
    SoHoaDon INT PRIMARY KEY,
    MaKhachHang INT,
    MaNhanVien INT,
    NgayDatHang DATE,
    NgayGiaoHang DATE,
    NgayChuyenHang DATE,
    NoiGiaoHang NVARCHAR(200),
    FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang),
    FOREIGN KEY (MaNhanVien) REFERENCES NHANVIEN(MaNhanVien)
);
--tạo bảng ci tiết đặt hàng
CREATE TABLE CHITIETDATHANG (
    SoHoaDon INT,
    MaHang INT,
    GiaBan DECIMAL(18, 2),
    SoLuong INT,
    MucGiamGia DECIMAL(5, 2),
    PRIMARY KEY (SoHoaDon, MaHang),
    FOREIGN KEY (SoHoaDon) REFERENCES DONDATHANG(SoHoaDon),
    FOREIGN KEY (MaHang) REFERENCES MATHANG(MaHang)
);