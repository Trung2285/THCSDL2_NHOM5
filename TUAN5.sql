CREATE DATABASE CONGTACGIAOHANG
GO
USE CONGTACGIAOHANG
--Tao bang KhachHang--
CREATE TABLE KhachHang
(
	maKH			char(10) primary key,
	tenCongTy		nvarchar(30),
	tenGiaoDich		nvarchar(30),
	diaChi			nvarchar(30),
	Email			varchar(20),
	dienThoai		char(10),
	FAX				char(10)
);
--Tao bang NhanVien
CREATE TABLE NhanVien
(
	maNV		char(10) primary key,
	ho			nvarchar(10),
	ten			nvarchar(15),
	ngaySinh	date,
	ngayLamViec date,
	diaChi		nvarchar(30),
	dienThoai   char(10),
	luongCoBan  money,
	phuCap		money
);
--Tao bang DonDatHang--
CREATE TABLE DonDatHang
(
	soHoaDon	   char(10) primary key,
	maKHNo1		   char(10) foreign key references KhachHang(maKH),
	maNVNo1		   char(10) foreign key references NhanVien(maNV),		
	ngayDatHang    date,
	ngayGiaoHang   date,
	ngayChuyenHang date,
	noiGiaoHang    nvarchar(20)
);
--Tao bang LoaiHang
CREATE TABLE LoaiHang
(
	maLH	char(10) primary key,
	tenLH	nvarchar(20)
);
--Tao bang NhaCungCap
CREATE TABLE NhaCungCap
(
	maCT		 char(10) primary key,
	tenCongTy	 nvarchar(30),
	tenGiaoDich  nvarchar(30),
	diaChi		 nvarchar(30),
	dienThoai	 char(10),
	FAX			 char(10),
	Email	     varchar(20)
);
--Tao bang MatHang
CREATE TABLE MatHang
(
	maHang		char(10) primary key,
	tenHang		nvarchar(20),
	maCTNo1		char(10) foreign key references NhaCungCap(maCT),
	maLHNo1		char(10) foreign key references LoaiHang(maLH),
	soLuong		int,
	donViTinh	varchar(10),
	giaHang		money
);
--Tao bang ChiTietDatHang
CREATE TABLE ChiTietDatHang
(
	soHDNo1		char(10) foreign key references DonDatHang(soHoaDon),
	maHangNo1	char(10) foreign key references MatHang(maHang),
	giaBan		money,
	soLuong		int,
	mucGiamGia  float
);