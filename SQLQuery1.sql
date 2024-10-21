
CREATE TABLE LOAIHANG (
    MALOAIHANG NVARCHAR(30) PRIMARY KEY,
    TENLOAIHANG NVARCHAR(30)
);
CREATE TABLE MATHANG (
    MAHANG NVARCHAR(30) PRIMARY KEY,
    TENHANG NVARCHAR(30),
    MACONGTY NVARCHAR(30),
    MALOAIHANG NVARCHAR(30),
    SOLUONG INT CHECK (SOLUONG > 0),
    DONVITINH FLOAT CHECK (DONVITINH > 0),
    GIAHANG FLOAT CHECK (GIAHANG > 0),
    FOREIGN KEY (MALOAIHANG) REFERENCES LOAIHANG(MALOAIHANG)
);
