use AgroMor
--SCRIPT PARA EVADIR IMPUESTOS :3
UPDATE Ventas SET CodEmpleado ='008'
WHERE CodEmpleado ='009'

--2
UPDATE Pedidos SET CodEmpleado ='008'
WHERE CodEmpleado ='009'

--3
UPDATE NotaCredito SET CodEmpleado ='008'
WHERE CodEmpleado ='009'
--4
UPDATE ReciboPagos SET CodEmpleado ='008'
WHERE CodEmpleado ='009'

DELETE FROM Empleado
WHERE CodEmpleado = '009'

/*Select*from Empleado
WHERE CodEmpleado = '009'*/