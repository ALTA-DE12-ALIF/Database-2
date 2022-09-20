use alta_online_shop;

-- DROP --
DROP TABLE Product;
DROP TABLE User;
DROP TABLE Detail_Transaksi;
DROP TABLE Transaksi_Pelanggan;
DROP TABLE Kurir;
DROP TABLE payment_method;
DROP TABLE payment_description;
DROP TABLE User2;
DROP TABLE User_alamat;

-- CREATE --
    CREATE TABLE Product
    (
        id_product VARCHAR(5) primary key,
        product_type VARCHAR(255) not null,
        product_description VARCHAR(255) not null,
        merk VARCHAR(200) not null,
        payment_method VARCHAR(255) not null
    );

    CREATE TABLE User
    (
        id_user VARCHAR(5) primary key,
        nama VARCHAR(100) not null,
        alamat VARCHAR(255) not null,
        tanggal_lahir DATE not null,
        status_user VARCHAR(255) not null,
        gender VARCHAR(50) not null,
        created_at timestamp default current_timestamp(),
        updated_at datetime default current_timestamp on update current_timestamp()
    );

    CREATE TABLE Detail_Transaksi
    (
        id_DtTransaksi VARCHAR(5) primary key,
        constraint foreign key (Product) references Product(id_product),
        constraint foreign key (Transaksi_Pelanggan) references Transaksi_Pelanggan(id_trPelanggan)
    );

    CREATE TABLE Transaksi_Pelanggan
    (
        id_trPelanggan VARCHAR(5) primary key,
        constraint foreign key (Product) references Product(id_product)
    );

    CREATE TABLE Kurir
    (
        id_karir int AUTO_INCREMENT primary key,
        nama_karir VARCHAR(255) not null,
        created_at timestamp default current_timestamp(),
        updated_at timestamp default current_timestamp()
    );


    -- CREATE TABLE BARU --
    -- ONE TO ONE USER -> PAYMENT METHOD
    CREATE TABLE payment_method
    (
        id_payment int AUTO_INCREMENT primary key,
        jenis_pembayaran VARCHAR(255) not null,
        nama_jenispembayaran VARCHAR(255) not null
    );

    CREATE TABLE payment_description
    (
        id_pay_detail int primary key references payment_method(id_payment),
        nama_rekening VARCHAR(100) not null,
        nomor_rekening VARCHAR(200) not null
    );

    -- ONE TO MANY USER -> ALAMAT --
    CREATE TABLE User2
    (
        id_user2 VARCHAR(5) primary key,
        nama VARCHAR(100) not null,
        alamat VARCHAR(255) not null,
        tanggal_lahir DATE not null,
        status_user VARCHAR(255) not null,
        gender VARCHAR(50) not null,
        created_at timestamp default current_timestamp(),
        updated_at datetime default current_timestamp on update current_timestamp()
    );

    CREATE TABLE User_alamat
    (
        id_alamat int AUTO_INCREMENT primary key,
        id_user2 int,
        alamat VARCHAR(255) not null,
        constraint FK_Id_User2 foreign key (id_user2) references User2(id_user2)
    );

    -- MANY TO MANY USER -> PAYMENT METHOD --
    CREATE TABLE User2
    (
        id_user2 VARCHAR(5) primary key,
        id_payment int,
        nama VARCHAR(100) not null,
        alamat VARCHAR(255) not null,
        tanggal_lahir DATE not null,
        status_user VARCHAR(255) not null,
        gender VARCHAR(50) not null,
        created_at timestamp default current_timestamp(),
        updated_at datetime default current_timestamp on update current_timestamp(),
        constraint foreign key (payment_method) references payment_method(id_payment)
    );

    CREATE TABLE payment_method
    (
        id_payment int AUTO_INCREMENT primary key,
        id_user2 int,
        jenis_pembayaran VARCHAR(255) not null,
        nama_rekening VARCHAR(255) not null,
        nomor_rekening VARCHAR(255) not null,
        constraint FK_Payment_User2 foreign key (id_user2) references User2(id_user2)
    );

-- ALTER --
ALTER TABLE Kurir add column ongkos_dasar int;

ALTER TABLE Kurir RENAME TO shipping;