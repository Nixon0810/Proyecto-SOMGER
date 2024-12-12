USE SCOMGER;
GO

SELECT 
    DE.IdEmpleado,                          
    DE.Descripcion AS Empleado,             
    DS.IdSucursal,                          
    DS.Descripcion AS Sucursal,             
    COUNT(D.CantidadVendida) AS VecesVendidas       
FROM DimEmpleado DE
INNER JOIN Datos D ON DE.IdEmpleado = D.IdEmpleado 
INNER JOIN DimSucursal DS ON D.IdSucursal = DS.IdSucursal  
GROUP BY 
    DE.IdEmpleado, 
    DE.Descripcion, 
    DS.IdSucursal, 
    DS.Descripcion
ORDER BY DE.Descripcion, DS.Descripcion;
