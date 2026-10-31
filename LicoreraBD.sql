Create Database dbGuayabo;
go

Use dbGuayabo;
go

Create Table Ciudad(
	IdCiudad nvarchar(15) primary key,
	Nombre nvarchar(30) not null
);
go

Create Table TipoSucursal(
	IdTipoSucursal nvarchar(15) primary key,
	Nombre nvarchar(30) not null
);
go

Create Table Marca(
	IdMarca nvarchar(15) primary key,
	Nombre nvarchar(30) not null
);
go

Create Table Producto(
	IdProducto nvarchar(15) primary key,
	Nombre nvarchar(50) not null,
	Precio numeric(8,1) not null,
	IdMarca nvarchar(15) not null,

	Constraint fk_idMarca
	Foreign Key (IdMarca) References Marca(IdMarca) on Update Cascade
);
go

Create Table Sucursal(
	IdSucursal nvarchar(15) primary key,
	Nombre nvarchar(50) not null,
	Direccion nvarchar(100) not null,
	Horario nvarchar(50) not null,
	Telefono nvarchar(15) not null,
	IdCiudad nvarchar(15) not null,
	IdTipoSucursal nvarchar(15) not null,

	Constraint fk_idCiudad
	Foreign Key (IdCiudad) References Ciudad(IdCiudad) on Update Cascade,

	Constraint fk_idTipoSucursal
	Foreign Key (IdTipoSucursal) References TipoSucursal(IdTipoSucursal) on Update Cascade
);
go

Create Table Inventario(
	IdSucursal nvarchar(15) not null,
	IdProducto nvarchar(15) not null,
	Cantidad int not null,

	Constraint pk_inventario
	Primary Key (IdSucursal, IdProducto),

	Constraint fk_idSucursal
	Foreign Key (IdSucursal) References Sucursal(IdSucursal) on Update Cascade,

	Constraint fk_idProducto
	Foreign Key (IdProducto) References Producto(IdProducto) on Update Cascade
);
go

Insert Ciudad Values
('C001','Medellin'),
('C002','Bello'),
('C003','Envigado'),
('C004','Itagui');
go

Insert TipoSucursal Values
('TS001','Punto de venta'),
('TS002','Bodega'),
('TS003','Sucursal principal');
go

Insert Marca Values
('M001','Aguardiente Antioqueno'),
('M002','Ron Medellin'),
('M003','Old Parr'),
('M004','Bacardi'),
('M005','Smirnoff');
go

Insert Producto Values
('P001','Aguardiente Antioqueno 750ml',45000.0,'M001'),
('P002','Aguardiente Antioqueno Sin Azucar 750ml',47000.0,'M001'),
('P003','Ron Medellin 750ml',52000.0,'M002'),
('P004','Old Parr 750ml',115000.0,'M003'),
('P005','Bacardi Carta Blanca 750ml',65000.0,'M004'),
('P006','Smirnoff 750ml',58000.0,'M005');
go

Insert Sucursal Values
('S001','Guayabo Centro','Carrera 50 # 50-20',
'10:00 AM - 10:00 PM','6041234567','C001','TS003'),

('S002','Guayabo Niquia','Carrera 52 # 45-30',
'10:00 AM - 10:00 PM','6042345678','C002','TS001'),

('S003','Guayabo Envigado','Carrera 43 # 35-15',
'11:00 AM - 11:00 PM','6043456789','C003','TS001'),

('S004','Bodega Guayabo','Calle 30 # 40-25',
'8:00 AM - 6:00 PM','6044567890','C001','TS002');
go

Insert Inventario Values
('S001','P001',25),
('S001','P002',15),
('S001','P003',20),
('S001','P004',10),

('S002','P001',30),
('S002','P003',18),
('S002','P005',12),
('S002','P006',20),

('S003','P002',15),
('S003','P003',25),
('S003','P004',8),
('S003','P006',10),

('S004','P001',100),
('S004','P002',80),
('S004','P003',75),
('S004','P004',40),
('S004','P005',60),
('S004','P006',50);
go

Select * From Ciudad;
Select * From TipoSucursal;
Select * From Marca;
Select * From Producto;
Select * From Sucursal;
Select * From Inventario;
go

Create View vwDetalleInventario
As

Select
	Ciudad.IdCiudad,
	Ciudad.Nombre As Ciudad,
	TipoSucursal.IdTipoSucursal,
	TipoSucursal.Nombre As TipoSucursal,
	Sucursal.IdSucursal,
	Sucursal.Nombre As Sucursal,
	Sucursal.Direccion,
	Sucursal.Horario,
	Sucursal.Telefono,
	Producto.IdProducto,
	Producto.Nombre As Producto,
	Producto.Precio,
	Marca.IdMarca,
	Marca.Nombre As Marca,
	Inventario.Cantidad

From Sucursal

Inner Join Ciudad
	On Sucursal.IdCiudad = Ciudad.IdCiudad

Inner Join TipoSucursal
	On Sucursal.IdTipoSucursal = TipoSucursal.IdTipoSucursal

Inner Join Inventario
	On Sucursal.IdSucursal = Inventario.IdSucursal

Inner Join Producto
	On Inventario.IdProducto = Producto.IdProducto

Inner Join Marca
	On Producto.IdMarca = Marca.IdMarca;
go

Select * From vwDetalleInventario;
go

Create View vwProductosDisponibles
As

Select
	Producto.IdProducto,
	Producto.Nombre As Producto,
	Marca.Nombre As Marca,
	Producto.Precio,
	Sucursal.IdSucursal,
	Sucursal.Nombre As Sucursal,
	Inventario.Cantidad

From Inventario

Inner Join Producto
	On Inventario.IdProducto = Producto.IdProducto

Inner Join Marca
	On Producto.IdMarca = Marca.IdMarca

Inner Join Sucursal
	On Inventario.IdSucursal = Sucursal.IdSucursal

Where Inventario.Cantidad > 0;
go

Select * From vwProductosDisponibles;
go

Create Procedure spListInventoryxSucursal
@IdSucursal nvarchar(15)
As
Begin

	If Exists(
		Select IdSucursal
		From Sucursal
		Where IdSucursal = @IdSucursal
	)

		Select
			Sucursal.IdSucursal,
			Sucursal.Nombre As Sucursal,
			Producto.IdProducto,
			Producto.Nombre As Producto,
			Marca.Nombre As Marca,
			Producto.Precio,
			Inventario.Cantidad

		From Sucursal

		Inner Join Inventario
			On Sucursal.IdSucursal = Inventario.IdSucursal

		Inner Join Producto
			On Inventario.IdProducto = Producto.IdProducto

		Inner Join Marca
			On Producto.IdMarca = Marca.IdMarca

		Where Sucursal.IdSucursal = @IdSucursal

	Else

		Print 'La sucursal especificada NO existe';

End
go

Exec spListInventoryxSucursal 'S001';
go

Exec spListInventoryxSucursal 'S002';
go

Create Proc spAddProducto
@IdProducto nvarchar(15),
@Nombre nvarchar(50),
@Precio numeric(8,1),
@IdMarca nvarchar(15)
As
Begin

	If Not Exists(
		Select IdProducto
		From Producto
		Where IdProducto = @IdProducto
	)

		If Exists(
			Select IdMarca
			From Marca
			Where IdMarca = @IdMarca
		)

			Insert Producto
			Values (@IdProducto,@Nombre,@Precio,@IdMarca)

		Else

			Print 'La marca especificada NO existe'

	Else

		Print 'El producto con id: '+@IdProducto+' YA existe. Intentelo con otro.';

End
go

Exec spAddProducto
'P007',
'Tequila Jose Cuervo 750ml',
85000,
'M005';
go

Create Procedure spCountProductsxSucursal
@IdSucursal nvarchar(15),
@ProductCount int Output
As
Begin

	Select @ProductCount = Count(Inventario.IdProducto)

	From Inventario

	Inner Join Sucursal
		On Inventario.IdSucursal = Sucursal.IdSucursal

	Where Sucursal.IdSucursal = @IdSucursal

End
go

Declare @CountProduct Int;

Exec spCountProductsxSucursal
@IdSucursal = 'S001',
@ProductCount = @CountProduct Output;

Select @CountProduct As 'Cantidad de Productos';
go

Create Trigger trgAddProducto
On Producto
For Insert
As
Begin

	Select * From Inserted

End
go

Create Trigger trgAddInventario
On Inventario
Instead Of Insert
As
Begin

	If Exists
	(
		Select IdSucursal
		From Sucursal
		Where IdSucursal In
		(
			Select IdSucursal
			From Inserted
		)
	)

		If Exists
		(
			Select IdProducto
			From Producto
			Where IdProducto In
			(
				Select IdProducto
				From Inserted
			)
		)

			If Not Exists
			(
				Select *
				From Inventario i
				Inner Join Inserted ins
					On i.IdSucursal = ins.IdSucursal
					And i.IdProducto = ins.IdProducto
			)

				Begin

					Insert Inventario
					Values
					(
						(Select IdSucursal From Inserted),
						(Select IdProducto From Inserted),
						(Select Cantidad From Inserted)
					);

					Print 'Inventario agregado correctamente...';

				End

			Else

				Print 'El producto ya existe en el inventario de esta sucursal';

		Else

			Print 'El producto NO existe';

	Else

		Print 'La sucursal NO existe';

End
go

Insert Inventario
Values ('S001','P006',20);
go

Select *
From vwDetalleInventario
Where Ciudad = 'Medellin';
go

Select *
From vwProductosDisponibles
Where Cantidad > 20;
go