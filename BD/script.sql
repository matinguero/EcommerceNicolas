USE [EcommerceNicolas]
GO
/****** Object:  UserDefinedFunction [dbo].[DevolverMontoCarrito]    Script Date: 3/5/2024 12:25:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DevolverMontoCarrito]
(
	-- Add the parameters for the function here
	@id_usuario as int 
)
RETURNS float
AS
BEGIN
	-- Declare the return variable here
	Declare @MontoTotal as float = 0





	--ARMAR UN BUCLE / CURSOR

	-- Declaro las variables del cursor
	DECLARE @quantity int, @costounitario as float

	
	--declaro el cursor
	DECLARE Carrito_Tabla CURSOR FOR
	
	SELECT     Carrito.Cantidad, Carrito.precio_unitario
	FROM         Carrito
	WHERE     Carrito.usuario_id=@id_usuario
	
	--abro el cursor
	OPEN Carrito_Tabla
	--hago el FETCH del primer registro
	FETCH NEXT FROM Carrito_Tabla
	INTO @quantity, @costounitario


	--mientras haya registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
			--HAGO CUENTA
			 Set @MontoTotal = @MontoTotal + (@quantity * @costounitario)
			
	FETCH NEXT FROM Carrito_Tabla
	INTO @quantity, @costounitario
	END
	CLOSE Carrito_Tabla
	DEALLOCATE Carrito_Tabla
		





	-- Return the result of the function
	RETURN @MontoTotal


END

GO
/****** Object:  UserDefinedFunction [dbo].[DevolverPrecioEnPesos]    Script Date: 3/5/2024 12:25:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DevolverPrecioEnPesos]
(
	-- Add the parameters for the function here
	@PrecioDolar as float
)
RETURNS float
AS
BEGIN
	-- Declare the return variable here
	DECLARE @retValorEnPesos as float
	-- Add the T-SQL statements to compute the return value here
	DECLARE @ValorCotizacion as float
	set @ValorCotizacion = (Select top 1 Cotizacion from Cotizacion where fecha_fin is null)

	set @retValorEnPesos = cast(@PrecioDolar * @ValorCotizacion as decimal(10,2))

	-- Return the result of the function
	RETURN @retValorEnPesos

END
GO
/****** Object:  Table [dbo].[Admins]    Script Date: 3/5/2024 12:25:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admins](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Apellido] [varchar](50) NULL,
	[email] [varchar](100) NULL,
 CONSTRAINT [PK_Admins] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carrito]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrito](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[producto_id] [int] NULL,
	[precio_unitario] [float] NULL,
	[cantidad] [int] NULL,
	[usuario_id] [int] NULL,
	[fecha] [datetime] NULL,
 CONSTRAINT [PK_Carrito] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoriaProducto]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriaProducto](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[categoria_id] [int] NULL,
	[producto_id] [int] NULL,
 CONSTRAINT [PK_CategoriaProducto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
 CONSTRAINT [PK_Categorias] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cotizacion]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cotizacion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cotizacion] [float] NULL,
	[fecha_inicio] [datetime] NULL,
	[fecha_fin] [datetime] NULL,
 CONSTRAINT [PK_Cotizacion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orden]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[usuario_id] [int] NULL,
	[costo_total] [float] NULL,
	[fecha_orden] [datetime] NULL,
	[cotizacion_id] [int] NULL,
 CONSTRAINT [PK_Orden] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrdenDetalle]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdenDetalle](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[orden_id] [int] NULL,
	[producto_id] [int] NULL,
	[cantidad] [int] NULL,
	[precio_unitario] [float] NULL,
 CONSTRAINT [PK_OrdenDetalle] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Descripcion] [varchar](max) NULL,
	[Precio] [float] NULL,
	[Stock] [int] NULL,
	[Activo] [int] NULL,
	[Foto] [varbinary](max) NULL,
	[FechaAlta] [datetime] NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Apellido] [varchar](50) NULL,
	[Email] [varchar](100) NULL,
	[Direccion] [varchar](1000) NULL,
	[Telefono] [varchar](100) NULL,
	[clave] [varchar](50) NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admins] ON 

INSERT [dbo].[Admins] ([id], [Nombre], [Apellido], [email]) VALUES (1, N'Nicolas', N'Delponte', N'nico@nico')
INSERT [dbo].[Admins] ([id], [Nombre], [Apellido], [email]) VALUES (2, N'martin', N'a', N'martin@martin')
SET IDENTITY_INSERT [dbo].[Admins] OFF
GO
SET IDENTITY_INSERT [dbo].[CategoriaProducto] ON 

INSERT [dbo].[CategoriaProducto] ([id], [categoria_id], [producto_id]) VALUES (1, 1, 1)
INSERT [dbo].[CategoriaProducto] ([id], [categoria_id], [producto_id]) VALUES (4, 3, 1)
INSERT [dbo].[CategoriaProducto] ([id], [categoria_id], [producto_id]) VALUES (2, 3, 2)
SET IDENTITY_INSERT [dbo].[CategoriaProducto] OFF
GO
SET IDENTITY_INSERT [dbo].[Categorias] ON 

INSERT [dbo].[Categorias] ([id], [Nombre]) VALUES (1, N'Accesorios Video')
INSERT [dbo].[Categorias] ([id], [Nombre]) VALUES (2, N'Insumos Oficina')
INSERT [dbo].[Categorias] ([id], [Nombre]) VALUES (3, N'Accesorios PCs')
SET IDENTITY_INSERT [dbo].[Categorias] OFF
GO
SET IDENTITY_INSERT [dbo].[Cotizacion] ON 

INSERT [dbo].[Cotizacion] ([id], [cotizacion], [fecha_inicio], [fecha_fin]) VALUES (1, 765, CAST(N'2023-11-15T00:00:00.000' AS DateTime), CAST(N'2023-11-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Cotizacion] ([id], [cotizacion], [fecha_inicio], [fecha_fin]) VALUES (2, 1100, CAST(N'2024-01-01T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Cotizacion] OFF
GO
SET IDENTITY_INSERT [dbo].[Orden] ON 

INSERT [dbo].[Orden] ([id], [usuario_id], [costo_total], [fecha_orden], [cotizacion_id]) VALUES (1, 1, 20.8, CAST(N'2024-02-29T00:11:50.367' AS DateTime), 2)
INSERT [dbo].[Orden] ([id], [usuario_id], [costo_total], [fecha_orden], [cotizacion_id]) VALUES (2, 1, 52, CAST(N'2024-02-29T00:16:40.160' AS DateTime), 2)
INSERT [dbo].[Orden] ([id], [usuario_id], [costo_total], [fecha_orden], [cotizacion_id]) VALUES (3, 1, 31.200000000000003, CAST(N'2024-02-29T00:18:25.767' AS DateTime), 2)
INSERT [dbo].[Orden] ([id], [usuario_id], [costo_total], [fecha_orden], [cotizacion_id]) VALUES (4, 1, 104, CAST(N'2024-02-29T12:07:42.727' AS DateTime), 2)
INSERT [dbo].[Orden] ([id], [usuario_id], [costo_total], [fecha_orden], [cotizacion_id]) VALUES (5, 1, 218.4, CAST(N'2024-02-29T12:12:14.353' AS DateTime), 2)
INSERT [dbo].[Orden] ([id], [usuario_id], [costo_total], [fecha_orden], [cotizacion_id]) VALUES (6, 1, 107.2, CAST(N'2024-03-04T14:03:25.543' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[Orden] OFF
GO
SET IDENTITY_INSERT [dbo].[OrdenDetalle] ON 

INSERT [dbo].[OrdenDetalle] ([id], [orden_id], [producto_id], [cantidad], [precio_unitario]) VALUES (1, 1, 1, 2, 10.4)
INSERT [dbo].[OrdenDetalle] ([id], [orden_id], [producto_id], [cantidad], [precio_unitario]) VALUES (2, 2, 1, 5, 10.4)
INSERT [dbo].[OrdenDetalle] ([id], [orden_id], [producto_id], [cantidad], [precio_unitario]) VALUES (3, 3, 1, 3, 10.4)
INSERT [dbo].[OrdenDetalle] ([id], [orden_id], [producto_id], [cantidad], [precio_unitario]) VALUES (4, 4, 1, 10, 10.4)
INSERT [dbo].[OrdenDetalle] ([id], [orden_id], [producto_id], [cantidad], [precio_unitario]) VALUES (5, 5, 1, 21, 10.4)
INSERT [dbo].[OrdenDetalle] ([id], [orden_id], [producto_id], [cantidad], [precio_unitario]) VALUES (6, 6, 1, 6, 10.4)
INSERT [dbo].[OrdenDetalle] ([id], [orden_id], [producto_id], [cantidad], [precio_unitario]) VALUES (7, 6, 2, 8, 5.6)
SET IDENTITY_INSERT [dbo].[OrdenDetalle] OFF
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([id], [Nombre], [Descripcion], [Precio], [Stock], [Activo], [Foto], [FechaAlta]) VALUES (1, N'Camara web', N'si', 10.4, -22, 1, NULL, CAST(N'2024-02-08T17:42:27.493' AS DateTime))
INSERT [dbo].[Productos] ([id], [Nombre], [Descripcion], [Precio], [Stock], [Activo], [Foto], [FechaAlta]) VALUES (2, N'Hojas A4', N'para imprimir', 5.6, 92, 1, NULL, CAST(N'2024-02-08T17:47:07.430' AS DateTime))
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([id], [Nombre], [Apellido], [Email], [Direccion], [Telefono], [clave]) VALUES (1, N'nico', N'appelllidos', N'nico@nico', N'caca ', N'1160054285', N'hola')
INSERT [dbo].[Usuarios] ([id], [Nombre], [Apellido], [Email], [Direccion], [Telefono], [clave]) VALUES (2, N'nico', N'delponte', N'nicolas@nicolas', NULL, NULL, N'caca')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
/****** Object:  Index [IX_CategoriaProducto]    Script Date: 3/5/2024 12:25:42 PM ******/
ALTER TABLE [dbo].[CategoriaProducto] ADD  CONSTRAINT [IX_CategoriaProducto] UNIQUE NONCLUSTERED 
(
	[categoria_id] ASC,
	[producto_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Usuarios]    Script Date: 3/5/2024 12:25:42 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Usuarios] ON [dbo].[Usuarios]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Productos] ADD  CONSTRAINT [DF_Productos_FechaAlta]  DEFAULT (getdate()) FOR [FechaAlta]
GO
ALTER TABLE [dbo].[Carrito]  WITH CHECK ADD  CONSTRAINT [FK_Carrito_Productos] FOREIGN KEY([producto_id])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[Carrito] CHECK CONSTRAINT [FK_Carrito_Productos]
GO
ALTER TABLE [dbo].[Carrito]  WITH CHECK ADD  CONSTRAINT [FK_Carrito_Usuarios] FOREIGN KEY([usuario_id])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[Carrito] CHECK CONSTRAINT [FK_Carrito_Usuarios]
GO
ALTER TABLE [dbo].[CategoriaProducto]  WITH CHECK ADD  CONSTRAINT [FK_CategoriaProducto_Categorias] FOREIGN KEY([categoria_id])
REFERENCES [dbo].[Categorias] ([id])
GO
ALTER TABLE [dbo].[CategoriaProducto] CHECK CONSTRAINT [FK_CategoriaProducto_Categorias]
GO
ALTER TABLE [dbo].[CategoriaProducto]  WITH CHECK ADD  CONSTRAINT [FK_CategoriaProducto_Productos] FOREIGN KEY([producto_id])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[CategoriaProducto] CHECK CONSTRAINT [FK_CategoriaProducto_Productos]
GO
ALTER TABLE [dbo].[Orden]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Cotizacion] FOREIGN KEY([cotizacion_id])
REFERENCES [dbo].[Cotizacion] ([id])
GO
ALTER TABLE [dbo].[Orden] CHECK CONSTRAINT [FK_Orden_Cotizacion]
GO
ALTER TABLE [dbo].[Orden]  WITH CHECK ADD  CONSTRAINT [FK_Orden_Usuarios] FOREIGN KEY([usuario_id])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[Orden] CHECK CONSTRAINT [FK_Orden_Usuarios]
GO
ALTER TABLE [dbo].[OrdenDetalle]  WITH CHECK ADD  CONSTRAINT [FK_OrdenDetalle_Orden] FOREIGN KEY([orden_id])
REFERENCES [dbo].[Orden] ([id])
GO
ALTER TABLE [dbo].[OrdenDetalle] CHECK CONSTRAINT [FK_OrdenDetalle_Orden]
GO
ALTER TABLE [dbo].[OrdenDetalle]  WITH CHECK ADD  CONSTRAINT [FK_OrdenDetalle_Productos] FOREIGN KEY([producto_id])
REFERENCES [dbo].[Productos] ([id])
GO
ALTER TABLE [dbo].[OrdenDetalle] CHECK CONSTRAINT [FK_OrdenDetalle_Productos]
GO
/****** Object:  StoredProcedure [dbo].[spActualizarCarrito]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spActualizarCarrito]
	-- Add the parameters for the stored procedure here
	@producto_id as int,
	@cantidad as int,
	@Usuario_id as int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update Carrito
	set cantidad=@cantidad
	where producto_id=@producto_id
	and usuario_id=@Usuario_id
END
GO
/****** Object:  StoredProcedure [dbo].[spAgregarAlCarrito]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAgregarAlCarrito] 
	-- Add the parameters for the stored procedure here
	@producto_id as int,
	@cantidad as int,
	@Usuario_id as int
AS
BEGIN
	
	SET NOCOUNT ON;
	Declare @precioproducto as float = 0
	set @precioproducto= (select precio from Productos where Productos.id = @producto_id)

	Declare @existecarrito as int = 0
	set @existecarrito = (select id from carrito where Carrito.producto_id=@producto_id and Carrito.usuario_id=@Usuario_id)

if @existecarrito is null
	begin 

   insert into Carrito
   ([producto_id],
   [precio_unitario],
   [cantidad],
   [usuario_id],
   [fecha])
   values
   (@producto_id, @precioproducto,@cantidad,@Usuario_id,GETDATE())
	end
else 
	begin
	Update Carrito
	set cantidad = cantidad + @cantidad,
	Precio_unitario = @precioproducto,
	fecha=getdate()
	where
	Carrito.producto_id = @producto_id and Carrito.usuario_id=@Usuario_id



	end



END
GO
/****** Object:  StoredProcedure [dbo].[spEliminarDelCarrito]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spEliminarDelCarrito]
	-- Add the parameters for the stored procedure here
	 @usuario_id as int,
	 @producto_id as int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from Carrito where producto_id=@producto_id and usuario_id=@usuario_id	
END
GO
/****** Object:  StoredProcedure [dbo].[spGuardarOrden]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGuardarOrden] 
	-- Add the parameters for the stored procedure here
	@usuario_id as int, 
	@OrderID as int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

BEGIN TRAN

	BEGIN TRY

		--CALCULAR MONTO TOTAL
		Declare @MontoTotal as float = 0
		--TENGO QUE CALCULAR EL TOTAL DEL CARRITO
		set @MontoTotal = (Select dbo.DevolverMontoCarrito(@usuario_id))

		--OBTENER COTIZACION ID
		Declare @CotizacionId as int = 0
		set @CotizacionId = (Select top 1 id from Cotizacion where fecha_fin is null)

		--*************************************************************************************************INSERTO LA ORDEN**************************************************************************************************************************
		Declare @NewOrderID as int
	
		Insert into Orden
		 (Fecha_orden,
		 costo_total,
		 usuario_id,
		 cotizacion_id
		) 
	 VALUES 
		(
		 getdate(),
		 @MontoTotal,
		 @usuario_id,
		 @CotizacionId
		)
		
		--VARIABLE DE SQL QUE DEVUELVE EL ULTIMO ID IDENTITY QUE SE GUARDO
		Select @NewOrderID = SCOPE_IDENTITY() 

		--SETEO EL VALOR DE LA VARIABLE DE SALIDA
		Set @OrderID = @NewOrderID

		--CURSOR PARA INSERTAR DETALLE ORDEN
		--*************************************************************************************DETALLES DE LA ORDEN***************************************************************************************
		-- Declaro las variables del cursor
		DECLARE @ProductoId as int, @Cantidad as int, @PrecioUnitario as float
		
		
		DECLARE @CantidadStock as int

		--declaro el cursor
		DECLARE Shopping_tabla CURSOR FOR
	
		SELECT     Carrito.producto_id, Carrito.Cantidad, Carrito.precio_unitario
		FROM         Carrito
		WHERE     Carrito.usuario_id= @usuario_id
	
		--abro el cursor
		OPEN Shopping_tabla
		--hago el FETCH del primer registro
		FETCH NEXT FROM Shopping_tabla
		INTO @ProductoId, @Cantidad, @PrecioUnitario
	
		--mientras haya registros
		WHILE @@FETCH_STATUS = 0
		BEGIN
		
				--INSERTO EL DETALLE
				Insert into OrdenDetalle ([orden_id] ,[producto_id],[Cantidad],[precio_unitario]) 
				VALUES 
				(@NewOrderID, @ProductoId, @Cantidad, @PrecioUnitario) 

				--IR A BUSCAR STOCK DEL PROD
				set @CantidadStock = (select stock from Productos where id = @ProductoId)

				 

						
				--CHEQUEAR SI HAY STOCK
				--SI NO LO HAY YO LANZO UN ERROR
				IF @Cantidad > @CantidadStock
				RAISERROR ('No hay stock para el producto',16,1);

			
				--ACTUALIZO EL STOCK DEL PRODUCTO
				Update Productos set Stock = Stock - @Cantidad where id = @ProductoId
			
		FETCH NEXT FROM Shopping_tabla
		INTO @ProductoId, @Cantidad, @PrecioUnitario
		END
		CLOSE Shopping_tabla
		DEALLOCATE Shopping_tabla
		
		--BORRO DEL SHOPPING_CART
		Delete from Carrito where usuario_id=@usuario_id

		COMMIT TRANSACTION 

	END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION 
			Declare @mensaje as varchar(400)
			--VARIABLE QUE CONTIENE EL MENSAJE DE ERROR
			set @mensaje = ERROR_MESSAGE()
			RAISERROR (@mensaje,16,1);
			return -9999
        END
    END CATCH



    
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertarUsuario]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertarUsuario] 
	-- Add the parameters for the stored procedure here
	@email as varchar (200),
	@nombre as varchar(200),
	@apellido as varchar(200),
	@Clave as varchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into Usuarios
	(Email,Nombre,Apellido,clave)
	VALUES
	(@email,@nombre,@apellido,@Clave)


END
GO
/****** Object:  StoredProcedure [dbo].[spLoginUsuario]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spLoginUsuario] 
	-- Add the parameters for the stored procedure here
	@clave as varchar(100),
	@email as varchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from Usuarios
	where 
	email = @email and clave = @clave
END
GO
/****** Object:  StoredProcedure [dbo].[spModificarUsuario]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spModificarUsuario] 
	-- Add the parameters for the stored procedure here
@id as int,
@nombre as varchar(200),
@apellido as varchar(200),
@clave as varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
Update Usuarios
set
Nombre=@nombre,
Apellido=@apellido,
clave=@clave
where 
id=@id

END
GO
/****** Object:  StoredProcedure [dbo].[spObtenerCarrito]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spObtenerCarrito]
	@IdUsuario as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Carrito.id, Carrito.producto_id, Carrito.cantidad, dbo.DevolverPrecioEnPesos(Carrito.Precio_Unitario) as PrecioEnPesos,
	Carrito.usuario_id, (Carrito.cantidad * dbo.DevolverPrecioEnPesos(Carrito.precio_unitario)) as Subtotal, Productos.Descripcion as DescripcionProducto
	from Carrito
	inner join Productos on
	Carrito.producto_id = Productos.id
	where Carrito.usuario_id=@IdUsuario
END
GO
/****** Object:  StoredProcedure [dbo].[spObtenerCategorias]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spObtenerCategorias]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  select Distinct Categorias.id, nombre from Categorias
  inner join CategoriaProducto
  On Categorias.id = CategoriaProducto.categoria_id

END
GO
/****** Object:  StoredProcedure [dbo].[spObtenerDetalleOrden]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spObtenerDetalleOrden]
	-- Add the parameters for the stored procedure here
	@id_orden as int,
	@id_usuario as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT OrdenDetalle.id
      ,[orden_id]
      ,[producto_id]
      ,[cantidad]
      ,dbo.DevolverPrecioEnPesos(precio_unitario) as PrecioEnPesos,
	  dbo.DevolverPrecioEnPesos(Costo_total) as MontoTotal
	  , Orden.usuario_id,
	  Productos.Nombre

  FROM [OrdenDetalle]
  inner join Orden
  on Orden.id=OrdenDetalle.orden_id
  inner join Productos
  on OrdenDetalle.producto_id = Productos.id
  where orden_id=@id_orden
  and usuario_id=@id_usuario
END
GO
/****** Object:  StoredProcedure [dbo].[spObtenerOrdenes]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spObtenerOrdenes]
	-- Add the parameters for the stored procedure here
	@IdUsuario as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT id, fecha_orden, dbo.DevolverPrecioEnPesos(Costo_total) as MontoTotal, usuario_id, cotizacion_id from Orden where usuario_id = @IdUsuario
	order by fecha_orden desc
END 
GO
/****** Object:  StoredProcedure [dbo].[spObtenerProducto]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spObtenerProducto] 
	-- Add the parameters for the stored procedure here
	@producto_id as int,
	@categoria_id as int

	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT  Productos.id,
      Productos.Nombre,
      Descripcion,
	  Precio,
      dbo.DevolverPrecioEnPesos(Precio) as PrecioEnPesos,
      Stock,
      activo,
      Foto,
      FechaAlta,
	  CategoriaProducto.categoria_id,
	  Categorias.Nombre as categoria

  FROM [Productos] 
  inner join CategoriaProducto on
  Productos.id = CategoriaProducto.producto_id
  inner join Categorias	ON
CategoriaProducto.categoria_id=Categorias.id
where Productos.id=@producto_id
END
GO
/****** Object:  StoredProcedure [dbo].[spObtenerTodosLosProductos]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spObtenerTodosLosProductos]
	-- Add the parameters for the stored procedure here
	 @id_categoria as int = -1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT  Productos.id,
      Productos.Nombre,
      Descripcion,
	  Precio,
      dbo.DevolverPrecioEnPesos(Precio) as PrecioEnPesos,
      Stock,
      activo,
      Foto,
      FechaAlta,
	  CategoriaProducto.categoria_id,
	  Categorias.Nombre as categoria

  FROM [Productos] 
  inner join CategoriaProducto on
  Productos.id = CategoriaProducto.producto_id
  inner join Categorias	ON
CategoriaProducto.categoria_id=Categorias.id
where
(@id_categoria = -1 or categoria_id = @id_categoria)
END

GO
/****** Object:  StoredProcedure [dbo].[spObtenerUsuario]    Script Date: 3/5/2024 12:25:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spObtenerUsuario]
@id as int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from Usuarios where id = @id
END
GO
