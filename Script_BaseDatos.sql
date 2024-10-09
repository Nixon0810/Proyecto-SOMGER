
DROP TABLE Datos
go



DROP TABLE DimLinea
go



DROP TABLE DimMarca
go



DROP TABLE DimEmpleado
go



DROP TABLE DimProducto
go



DROP TABLE DimTiempo
go



DROP TABLE DimSucursal
go



CREATE TABLE DimSucursal
( 
	IdSucursal           varchar(3)  NOT NULL ,
	Descripcion          varchar(100)  NULL ,
	CONSTRAINT PK_Sucursal PRIMARY KEY (IdSucursal ASC)
)
go



CREATE TABLE DimTiempo
( 
	IdTiempo             varchar(20)  NOT NULL ,
	Ano                  int  NULL ,
	Mes                  tinyint  NULL ,
	Dia                  tinyint  NULL ,
	DiaSemana            tinyint  NULL ,
	Hora                 time  NULL ,
	CONSTRAINT PK_Tiempo PRIMARY KEY (IdTiempo ASC)
)
go



CREATE TABLE DimProducto
( 
	IdProducto           varchar(8)  NOT NULL ,
	Descripcion          varchar(100)  NULL ,
	CONSTRAINT PK_Producto PRIMARY KEY (IdProducto ASC)
)
go



CREATE TABLE DimEmpleado
( 
	IdEmpleado           varchar(3)  NOT NULL ,
	Descripcion          varchar(100)  NULL ,
	CONSTRAINT PK_Empleado PRIMARY KEY (IdEmpleado ASC)
)
go



CREATE TABLE DimMarca
( 
	IdMarca              varchar(5)  NOT NULL ,
	Descripcion          varchar(40)  NULL ,
	CONSTRAINT PK_Marca PRIMARY KEY (IdMarca ASC)
)
go



CREATE TABLE DimLinea
( 
	IdLinea              varchar(5)  NOT NULL ,
	Descripcion          varchar(40)  NULL ,
	CONSTRAINT PK_Linea PRIMARY KEY (IdLinea ASC)
)
go



CREATE TABLE Datos
( 
	IdSucursal           varchar(3)  NOT NULL ,
	IdTiempo             varchar(20)  NOT NULL ,
	IdEmpleado           varchar(3)  NOT NULL ,
	IdProducto           varchar(8)  NOT NULL ,
	IdMarca              varchar(5)  NOT NULL ,
	IdLinea              varchar(5)  NOT NULL ,
	CantidadVendida      numeric(18,2)  NULL ,
	SubTotal             numeric(18,2)  NULL ,
	CONSTRAINT PK_Datos PRIMARY KEY (IdSucursal ASC,IdTiempo ASC,IdEmpleado ASC,IdProducto ASC,IdMarca ASC,IdLinea ASC),
	CONSTRAINT FK_Sucursal_Datos FOREIGN KEY (IdSucursal) REFERENCES DimSucursal(IdSucursal),
	CONSTRAINT FK_Tiempo_Datos FOREIGN KEY (IdTiempo) REFERENCES DimTiempo(IdTiempo),
	CONSTRAINT FK_Producto_Datos FOREIGN KEY (IdProducto) REFERENCES DimProducto(IdProducto),
	CONSTRAINT FK_Empleado_Datos FOREIGN KEY (IdEmpleado) REFERENCES DimEmpleado(IdEmpleado),
	CONSTRAINT FK_Marca_Datos FOREIGN KEY (IdMarca) REFERENCES DimMarca(IdMarca),
	CONSTRAINT FK_Linea_Datos FOREIGN KEY (IdLinea) REFERENCES DimLinea(IdLinea)
)
go


