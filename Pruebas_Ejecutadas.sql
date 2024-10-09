Use SCOMGER
Go
--Ejecutar Venta por Sucursal por Periodo
EXEC USP_VentasPorSucursalPorPeriodo_SEL
    @IdSucursal = '001',
    @FechaInicio = '2009-01-01',
    @FechaFin = '2010-12-31';
--Ejecutar Venta por Año General y por Sucursal
EXEC USP_VentasPorAnoYSucursal_SEL
    @Ano = 2009,
    @FechaInicio = '2009-01-01',
    @FechaFin = '2009-12-31';

--Filtrar por Sucursal Especifica 
EXEC USP_VentasPorAnoYSucursal_SEL
    @Ano = 2009,
    @FechaInicio = '2009-01-01',
    @FechaFin = '2009-12-31',
    @IdSucursal = '001';
  
 --Ejecutar Venta por Empleado
 EXEC USP_VentasPorEmpleado_SEL
    @IdEmpleado = '003',
    @FechaInicio = '2009-01-01',
    @FechaFin = '2009-12-31',
    @IdSucursal = '001';  -- filtro Opcional

--Ejecutar Venta por Línea
EXEC USP_VentasPorLinea_SEL
    @IdLinea = '00039',
    @FechaInicio = '2011-01-01',
    @FechaFin = '2011-12-31',
    @IdSucursal = '001',  -- Filtro Opcional
    @IdEmpleado = '006';  -- filtro Opcional

-- Ejecutar Venta por Producto
EXEC USP_VentasPorProducto_SEL
    @IdProducto = '00000062',
    @FechaInicio = '2009-01-01',
    @FechaFin = '2013-12-31',
    @IdSucursal = '001',  -- filro Opcional
    @IdEmpleado = '006',  -- filtro Opcional
    @IdLinea = '00039';    -- filtro Opcional
Select*From DimProducto