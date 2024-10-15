--tạo bảng loại hàng
CREATE TABLE LOAIHANG (
maLoaiHang char(10) PRIMARY KEY,  
tenLoaiHang nvarchar(30)              
)
go
--tạo bảng mặt hàng
CREATE TABLE MATHANG (
        maHang char(10) PRIMARY KEY,
        tenHang nvarchar(30),                 
        maCongTy nvarchar(30),                
        maLoaiHang char(10),         
        soLuong int CHECK (soLuong > 0),      
        donViTinh float CHECK (donViTinh > 0),
        giaHang float CHECK (giaHang > 0),   
		CONSTRAINT FK_MATHANG_LOAIHANG FOREIGN KEY (maLoaiHang) REFERENCES LOAIHANG(maLoaiHang)
)