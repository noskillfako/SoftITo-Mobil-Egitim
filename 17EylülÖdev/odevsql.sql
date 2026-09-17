create table Ogrenci (
    OgrenciNo int primary key,
    Ad varchar(50) not null,
    Soyad varchar(50) not null,
    DogumTarihi date,
    Bolum int not null,
    foreign key (Bolum) references Bolum(BolumID)
    on delete restrict
    on update cascade
);
create table Bolum (
    BolumID int primary key,
    BolumAdi varchar(50) not null
);
create table Ders (
    DersID int primary key,
    DersAdi varchar(50) not null,
    Kredi int not null
    BolummID int not null,
    foreign key (BolummID) references Bolum(BolumID)
    on delete restrict
    on update cascade
);
create table OgrenciDers (
    OgrenciNo int not null,
    DersID int not null,
    Donem varchar(10) not null,
    Notu int,
    primary key (OgrenciNo, DersID, Donem),
    foreign key (OgrenciNo) references Ogrenci(OgrenciNo),
    on delete cascade,
    on update cascade,
    foreign key (DersID) references Ders(DersID),
    on delete cascade,
    on update cascade
);