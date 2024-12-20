﻿-- Bổ sung câu lệnh if exists
if exists (select * from sys.databases where name = 'CONGTACGIAOHANG')
	begin
		use master
		alter database CONGTACGIAOHANG set single_user with rollback immediate
		drop database CONGTACGIAOHANG;
	end

CREATE DATABASE CONGTACGIAOHANG
GO
USE CONGTACGIAOHANG

--Tao bang KhachHang--
CREATE TABLE KhachHang
(
	maKH			char(10) primary key,
	tenCongTy		nvarchar(30),
	tenGiaoDich		nvarchar(30),
	diaChi			nvarchar(100) not null,
	Email			varchar(20) unique not null,
	dienThoai		varchar(11) not null,
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
	diaChi		nvarchar(100),
	dienThoai   varchar(11) unique,
	luongCoBan  decimal(15,2),
	phuCap		decimal(15,2)
);

--Tao bang DonDatHang--
CREATE TABLE DonDatHang
(
	soHoaDon	   char(10) primary key,
    KHNo           char(10),
    NVNo           char(10),	
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
	dienThoai	 varchar(11) unique,
	FAX			 char(10) unique,
	Email	     varchar(20) unique
);

--Tao bang MatHang
CREATE TABLE MatHang
(
	maHang		char(10) primary key,
	tenHang		nvarchar(20),
    CTNo        char(10),
    LHNo        char(10),
	soLuong		int,
	donViTinh	nvarchar(10),
	giaHang		money
);
--Tao bang ChiTietDatHang

CREATE TABLE ChiTietDatHang
(
	HDNo		char(10),
	MHNo	    char(10),
	giaBan		money,
	soLuong		int,
	mucGiamGia  decimal(5,2)
    primary key(HDNo,MHNo)
);

--1.	Thiết lập  mối quan hệ giữa các bảng.
-- Ràng buộc khóa ngoại cho bảng DonDatHang
alter table DonDatHang
	add constraint FK_DonDatHang_KHNo foreign key (KHNo) references KhachHang(MaKH)
				on delete
					cascade
				on update
                    cascade, 
		constraint FK_DonDatHang_NVNo foreign key (NVNo) references NhanVien(MaNV)
				on delete
					cascade
				on update 
					cascade
-- Ràng buộc khóa ngoại cho bảng MatHang
alter table MatHang
    add constraint FK_DonDatHang_CTNo foreign key (CTNo)  references NhaCungCap(maCT)
				on delete
					cascade
				on update
                    cascade,
        constraint FK_DonDatHang_LHNo foreign key (LHNo)  references LoaiHang(maLH)
				on delete
					cascade
				on update
                    cascade
-- Ràng buộc khóa ngoại cho bảng ChiTietDatHang
alter table ChiTietDatHang
	add constraint FK_ChiTietDatHang_HDNo foreign key (HDNo) references DonDatHang(soHoaDon)
				on delete
					cascade
				on update
                    cascade,
		CONSTRAINT FK_ChiTietDatHang_MHNo foreign key (MHNo) references MatHang(maHang)
				on delete
					cascade
				on update
                    cascade  

--2.	Bổ sung ràng buộc thiết lập giá trị mặc định bằng 1 cho cột SOLUONG  và bằng 0 cho cột MUCGIAMGIA trong bảng CHITIETDATHANG
ALTER TABLE  ChiTietDatHang
    add constraint DF_ChiTietDatHang_soLuong default 1 for soLuong,
        constraint DF_ChiTietDatHang_mucGiamGia default 0 for mucGiamGia 

--3.	Bổ sung cho bảng DONDATHANG ràng buộc kiểm tra ngày giao hàng và ngày chuyển hàng phải sau hoặc bằng với ngày đặt hàng. 
ALTER TABLE DonDatHang
	ADD CONSTRAINT CK_DonDatHang_Dates CHECK (ngayGiaoHang >= ngayDatHang AND ngayChuyenHang >= ngayDatHang);

--4.	Bổ sung ràng buộc cho bảng NHANVIEN để đảm bảo rằng một nhân viên chỉ có thể làm việc trong công ty khi đủ 18 tuổi và không quá 60 tuổi.
ALTER TABLE NhanVien
    ADD CONSTRAINT CK_NHANVIEN_AGE CHECK (DATEDIFF(YEAR, ngaySinh, GETDATE()) BETWEEN 18 AND 60)
--Thêm dữ liệu bảng KhachHang
INSERT INTO KhachHang (maKH, tenCongTy, tenGiaoDich, diaChi, Email, dienThoai, FAX) VALUES
('KH0001', 'Công Ty A', 'Giao Dịch A', 'Hà Nội', 'email1@cty.com', '0123456789', '0123456780'),
('KH0002', 'Công Ty B', 'Giao Dịch B', 'Hồ Chí Minh', 'email2@cty.com', '0123456788', '0123456781'),
('KH0003', 'Công Ty C', 'Giao Dịch C', 'Đà Nẵng', 'email3@cty.com', '0123456787', '0123456782'),
('KH0004', 'Công Ty D', 'Giao Dịch D', 'Hải Phòng', 'email4@cty.com', '0123456786', '0123456783'),
('KH0005', 'Công Ty E', 'Giao Dịch E', 'Cần Thơ', 'email5@cty.com', '0123456785', '0123456784'),
('KH0006', 'Công Ty F', 'Giao Dịch F', 'Vũng Tàu', 'email6@cty.com', '0123456784', '0123456785'),
('KH0007', 'Công Ty G', 'Giao Dịch G', 'Bình Dương', 'email7@cty.com', '0123456783', '0123456786'),
('KH0008', 'Công Ty H', 'Giao Dịch H', 'Đồng Nai', 'email8@cty.com', '0123456782', '0123456787'),
('KH0009', 'Công Ty I', 'Giao Dịch I', 'Thanh Hóa', 'email9@cty.com', '0123456781', '0123456788'),
('KH0010', 'Công Ty J', 'Giao Dịch J', 'Nghệ An', 'email10@cty.com', '0123456780', '0123456789');
--Thêm dữ liệu bảng NhanVien
INSERT INTO NhanVien (maNV, ho, ten, ngaySinh, ngayLamViec, diaChi, dienThoai, luongCoBan, phuCap) VALUES
('NV0001', 'Nguyen', 'Anh', '1990-05-12', '2015-04-10', 'Hà Nội', '0912345670', 8000000, 500000),
('NV0002', 'Le', 'Bao', '1985-07-25', '2014-07-14', 'Hồ Chí Minh', '0912345671', 8500000, 500000),
('NV0003', 'Tran', 'Cuong', '1995-09-10', '2018-02-10', 'Đà Nẵng', '0912345672', 7800000, 600000),
('NV0004', 'Pham', 'Duy', '1980-02-15', '2010-08-15', 'Hải Phòng', '0912345673', 9200000, 500000),
('NV0005', 'Do', 'Dung', '1988-10-22', '2016-11-10', 'Cần Thơ', '0912345674', 8700000, 700000),
('NV0006', 'Ho', 'Em', '1993-03-30', '2019-09-05', 'Vũng Tàu', '0912345675', 8100000, 500000),
('NV0007', 'Bui', 'Gia', '1987-06-10', '2017-04-10', 'Bình Dương', '0912345676', 8300000, 600000),
('NV0008', 'Vu', 'Hao', '1990-08-05', '2015-12-22', 'Đồng Nai', '0912345677', 8000000, 500000),
('NV0009', 'Dang', 'Hieu', '1979-11-15', '2009-03-18', 'Thanh Hóa', '0912345678', 9300000, 500000),
('NV0010', 'Ly', 'Khoa', '1996-12-20', '2021-01-15', 'Nghệ An', '0912345679', 7900000, 500000);
--thêm dữ liệu vào bảng LoaiHang
INSERT INTO DonDatHang (soHoaDon, KHNo, NVNo, ngayDatHang, ngayGiaoHang, ngayChuyenHang, noiGiaoHang) VALUES
('HD0001', 'KH0001', 'NV0001', '2023-10-10', '2023-10-12', '2023-10-15', 'Hà Nội'),
('HD0002', 'KH0002', 'NV0002', '2023-10-11', '2023-10-13', '2023-10-16', 'Hồ Chí Minh'),
('HD0003', 'KH0003', 'NV0003', '2023-10-12', '2023-10-14', '2023-10-17', 'Đà Nẵng'),
('HD0004', 'KH0004', 'NV0004', '2023-10-13', '2023-10-15', '2023-10-18', 'Hải Phòng'),
('HD0005', 'KH0005', 'NV0005', '2023-10-14', '2023-10-16', '2023-10-19', 'Cần Thơ'),
('HD0006', 'KH0006', 'NV0006', '2023-10-15', '2023-10-17', '2023-10-20', 'Vũng Tàu'),
('HD0007', 'KH0007', 'NV0007', '2023-10-16', '2023-10-18', '2023-10-21', 'Bình Dương'),
('HD0008', 'KH0008', 'NV0008', '2023-10-17', '2023-10-19', '2023-10-22', 'Đồng Nai'),
('HD0009', 'KH0009', 'NV0009', '2023-10-18', '2023-10-20', '2023-10-23', 'Thanh Hóa'),
('HD0010', 'KH0010', 'NV0010', '2023-10-19', '2023-10-21', '2023-10-24', 'Nghệ An');
--Thêm dữ liệu vào bảng NhaCungCap
INSERT INTO NhaCungCap (maCT, tenCongTy, tenGiaoDich, diaChi, dienThoai, FAX, Email) VALUES
('CT0001', 'Nhà Cung Cấp A', 'Giao Dịch A', 'Hà Nội', '0934567890', '0234567890', 'ncc1@cty.com'),
('CT0002', 'Nhà Cung Cấp B', 'Giao Dịch B', 'Hồ Chí Minh', '0934567891', '0234567891', 'ncc2@cty.com'),
('CT0003', 'Nhà Cung Cấp C', 'Giao Dịch C', 'Đà Nẵng', '0934567892', '0234567892', 'ncc3@cty.com'),
('CT0004', 'Nhà Cung Cấp D', 'Giao Dịch D', 'Hải Phòng', '0934567893', '0234567893', 'ncc4@cty.com'),
('CT0005', 'Nhà Cung Cấp E', 'Giao Dịch E', 'Cần Thơ', '0934567894', '0234567894', 'ncc5@cty.com'),
('CT0006', 'Nhà Cung Cấp F', 'Giao Dịch F', 'Vũng Tàu', '0934567895', '0234567895', 'ncc6@cty.com'),
('CT0007', 'Nhà Cung Cấp G', 'Giao Dịch G', 'Bình Dương', '0934567896', '0234567896', 'ncc7@cty.com'),
('CT0008', 'Nhà Cung Cấp H', 'Giao Dịch H', 'Đồng Nai', '0934567897', '0234567897', 'ncc8@cty.com'),
('CT0009', 'Nhà Cung Cấp I', 'Giao Dịch I', 'Thanh Hóa', '0934567898', '0234567898', 'ncc9@cty.com'),
('CT0010', 'Nhà Cung Cấp J', 'Giao Dịch J', 'Nghệ An', '0934567899', '0234567899', 'ncc10@cty.com');
--Thêm dữ liệu vào bảng LoaiHang
INSERT INTO LoaiHang (maLH, tenLH) VALUES
('LH0001', 'Điện tử'),
('LH0002', 'Gia dụng'),
('LH0003', 'Thời trang'),
('LH0004', 'Thực phẩm'),
('LH0005', 'Đồ chơi'),
('LH0006', 'Văn phòng phẩm'),
('LH0007', 'Thiết bị y tế'),
('LH0008', 'Sách'),
('LH0009', 'Đồ gỗ'),
('LH0010', 'Hóa mỹ phẩm');
--Thêm dữ liệu vào bảng MatHang
INSERT INTO MatHang (maHang, tenHang, CTNo, LHNo, soLuong, donViTinh, giaHang) VALUES
('MH0001', 'Laptop', 'CT0001', 'LH0001', 100, 'Cái', 15000000),
('MH0002', 'Tủ lạnh', 'CT0002', 'LH0002', 50, 'Cái', 8000000),
('MH0003', 'Áo khoác', 'CT0003', 'LH0003', 200, 'Cái', 500000),
('MH0004', 'Sữa', 'CT0004', 'LH0004', 300, 'Thùng', 350000),
('MH0005', 'Đồ chơi Lego', 'CT0005', 'LH0005', 100, 'Bộ', 1200000),
('MH0006', 'Bút bi', 'CT0006', 'LH0006', 1000, 'Cây', 2000),
('MH0007', 'Máy đo huyết áp', 'CT0007', 'LH0007', 100, 'Cái', 800000),
('MH0008', 'Sách giáo khoa', 'CT0008', 'LH0008', 500, 'Cuốn', 50000),
('MH0009', 'Bàn gỗ', 'CT0009', 'LH0009', 50, 'Cái', 1500000),
('MH0010', 'Nước rửa tay', 'CT0010', 'LH0010', 200, 'Chai', 30000);
--Thêm dữ liệu vào bảng ChiTietDatHang
INSERT INTO ChiTietDatHang (HDNo, MHNo, giaBan, soLuong, mucGiamGia) VALUES
('HD0001', 'MH0001', 14500000, 2, 0.05),
('HD0002', 'MH0002', 7800000, 1, 0.03),
('HD0003', 'MH0003', 480000, 3, 0.02),
('HD0004', 'MH0004', 340000, 5, 0.01),
('HD0005', 'MH0005', 1150000, 1, 0.1),
('HD0006', 'MH0006', 1900, 50, 0.05),
('HD0007', 'MH0007', 760000, 2, 0.04),
('HD0008', 'MH0008', 48000, 20, 0.02),
('HD0009', 'MH0009', 1400000, 1, 0.05),
('HD0010', 'MH0010', 29000, 10, 0.0);
