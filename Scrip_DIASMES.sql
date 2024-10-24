Create table Meses(
 Mes tinyint not null,
 Descripcion  varchar(30),
 CONSTRAINT PK_Meses Primary key (Mes)
)
go
Alter table DimTiempo add constraint Fk_Meses_DimTiempo Foreign Key(Mes) references Meses(Mes)
go
insert into Meses(Mes,Descripcion)
Values(1,'Enero'),
(2,'Febrero'),
(3,'Marzo'),
(4,'Abril'),
(5,'Mayo'),
(6,'Junio'),
(7,'Julio'),
(8,'Agosto'),
(9,'Septiembre'),
(10,'Octubre'),
(11,'Noviembre'),
(12,'Diciembre')
go

Create table DiasSemana(
 DiaSemana tinyint not null,
 Descripcion  varchar(30),
 CONSTRAINT PK_DiasSemanas Primary key (DiaSemana)
)
go

Alter table DimTiempo add constraint Fk_DiasSemanas_DimTiempo Foreign Key(DiaSemana) references DiasSemana(DiaSemana)
go
insert into DiasSemana(DiaSemana,Descripcion)
Values(1,'Lunes'),
(2,'Martes'),
(3,'Miercoles'),
(4,'Jueves'),
(5,'Viernes'),
(6,'Sabado'),
(7,'Domingo')
go

