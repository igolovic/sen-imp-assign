USE [master]
GO
/****** Object:  Database [MyCompany]    Script Date: 21.5.2021. 13:55:20 ******/
CREATE DATABASE [MyCompany]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MyCompany', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.IVANINSTANCE\MSSQL\DATA\MyCompany.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MyCompany_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.IVANINSTANCE\MSSQL\DATA\MyCompany_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MyCompany] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyCompany].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyCompany] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyCompany] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyCompany] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyCompany] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyCompany] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyCompany] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyCompany] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyCompany] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyCompany] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyCompany] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyCompany] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyCompany] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyCompany] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyCompany] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyCompany] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MyCompany] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyCompany] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyCompany] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyCompany] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyCompany] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyCompany] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyCompany] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyCompany] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MyCompany] SET  MULTI_USER 
GO
ALTER DATABASE [MyCompany] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyCompany] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyCompany] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyCompany] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MyCompany] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MyCompany] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [MyCompany] SET QUERY_STORE = OFF
GO
USE [MyCompany]
GO
/****** Object:  Table [dbo].[ProductItem]    Script Date: 21.5.2021. 13:55:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Product_Id] [int] NOT NULL,
	[InventoryDateLocation_Id] [int] NOT NULL,
	[SerialNumber] [bigint] NOT NULL,
 CONSTRAINT [PK__ProductI__3214EC075FB518F7] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 21.5.2021. 13:55:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InventoryId] [varchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 21.5.2021. 13:55:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Company_Id] [int] NOT NULL,
	[ItemReference] [bigint] NOT NULL,
	[ProductName] [varchar](512) NOT NULL,
 CONSTRAINT [PK__Product__3214EC075B25DB96] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryDateLocation]    Script Date: 21.5.2021. 13:55:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryDateLocation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Inventory_Id] [int] NOT NULL,
	[InventoryDate] [datetime2](7) NOT NULL,
	[InventoryLocation_Id] [int] NOT NULL,
 CONSTRAINT [PK__Inventor__3214EC073C46EE2F] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_CountOfInventoriedItemsGroupedBySpecificProductForSpecificInventory]    Script Date: 21.5.2021. 13:55:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_CountOfInventoriedItemsGroupedBySpecificProductForSpecificInventory]
AS
SELECT	i.InventoryId
		, COUNT(*) AS CountOfProductItems
		, [p].ProductName
FROM	[dbo].[ProductItem] AS [pi]
INNER JOIN
		[dbo].[Product] AS p
ON		p.Id = [pi].Product_Id
INNER JOIN
		[dbo].[InventoryDateLocation] AS idl
ON		idl.Id = [pi].InventoryDateLocation_Id
INNER JOIN
		[dbo].[Inventory] AS i
ON		i.Id = idl.Inventory_Id
GROUP BY
		i.Id, i.InventoryId, [p].Id, [p].ProductName
--ORDER BY i.InventoryId, CountOfProductItems DESC
GO
/****** Object:  View [dbo].[v_CountOfInventoriedItemsGroupedBySpecificProductPerDay]    Script Date: 21.5.2021. 13:55:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_CountOfInventoriedItemsGroupedBySpecificProductPerDay]
AS
SELECT	idl.InventoryDate
		, COUNT(*) AS CountOfProductItems
		, [p].ProductName
FROM	[dbo].[ProductItem] AS [pi]
INNER JOIN
		[dbo].[Product] AS p
ON		p.Id = [pi].Product_Id
INNER JOIN
		[dbo].[InventoryDateLocation] AS idl
ON		idl.Id = [pi].InventoryDateLocation_Id
GROUP BY
		idl.InventoryDate, [p].Id, [p].ProductName
--ORDER BY idl.InventoryDate, CountOfProductItems DESC
GO
/****** Object:  Table [dbo].[Company]    Script Date: 21.5.2021. 13:55:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyPrefix] [bigint] NOT NULL,
	[CompanyName] [varchar](512) NOT NULL,
 CONSTRAINT [PK__Company__3214EC07BB738488] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_CountOfInventoriedItemsGroupedBySpecificCompany]    Script Date: 21.5.2021. 13:55:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_CountOfInventoriedItemsGroupedBySpecificCompany]
AS
SELECT	c.CompanyName
		, COUNT(*) AS CountOfProductItems
FROM	[dbo].[ProductItem] AS [pi]
INNER JOIN
		[dbo].[Product] AS p
ON		p.Id = [pi].Product_Id
INNER JOIN
		[dbo].[Company] AS c
ON		c.Id = p.Company_Id
GROUP BY
		c.Id, c.CompanyName
--ORDER BY CountOfProductItems DESC, c.CompanyName
GO
/****** Object:  Table [dbo].[InventoryLocation]    Script Date: 21.5.2021. 13:55:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryLocation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InventoryLocationName] [varchar](512) NOT NULL,
 CONSTRAINT [PK__Inventor__3214EC071055B90B] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Company__C2281033CA6534FB]    Script Date: 21.5.2021. 13:55:20 ******/
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [UQ__Company__C2281033CA6534FB] UNIQUE NONCLUSTERED 
(
	[CompanyPrefix] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Inventor__F5FDE6B2224FF9C7]    Script Date: 21.5.2021. 13:55:20 ******/
ALTER TABLE [dbo].[Inventory] ADD UNIQUE NONCLUSTERED 
(
	[InventoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Inventor__C4422681C1203420]    Script Date: 21.5.2021. 13:55:20 ******/
ALTER TABLE [dbo].[InventoryDateLocation] ADD  CONSTRAINT [UQ__Inventor__C4422681C1203420] UNIQUE NONCLUSTERED 
(
	[Inventory_Id] ASC,
	[InventoryDate] ASC,
	[InventoryLocation_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Inventor__EC750B4FCED41B54]    Script Date: 21.5.2021. 13:55:20 ******/
ALTER TABLE [dbo].[InventoryLocation] ADD  CONSTRAINT [UQ__Inventor__EC750B4FCED41B54] UNIQUE NONCLUSTERED 
(
	[InventoryLocationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Product__12045DE22D81EEB1]    Script Date: 21.5.2021. 13:55:20 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [UQ__Product__12045DE22D81EEB1] UNIQUE NONCLUSTERED 
(
	[Company_Id] ASC,
	[ItemReference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__ProductI__6B86F9ABA142D6C8]    Script Date: 21.5.2021. 13:55:20 ******/
ALTER TABLE [dbo].[ProductItem] ADD  CONSTRAINT [UQ__ProductI__6B86F9ABA142D6C8] UNIQUE NONCLUSTERED 
(
	[Product_Id] ASC,
	[InventoryDateLocation_Id] ASC,
	[SerialNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InventoryDateLocation]  WITH CHECK ADD  CONSTRAINT [FK_InventoryDateLocation_Inventory] FOREIGN KEY([Inventory_Id])
REFERENCES [dbo].[Inventory] ([Id])
GO
ALTER TABLE [dbo].[InventoryDateLocation] CHECK CONSTRAINT [FK_InventoryDateLocation_Inventory]
GO
ALTER TABLE [dbo].[InventoryDateLocation]  WITH CHECK ADD  CONSTRAINT [FK_InventoryDateLocation_InventoryLocation] FOREIGN KEY([InventoryLocation_Id])
REFERENCES [dbo].[InventoryLocation] ([Id])
GO
ALTER TABLE [dbo].[InventoryDateLocation] CHECK CONSTRAINT [FK_InventoryDateLocation_InventoryLocation]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Company] FOREIGN KEY([Company_Id])
REFERENCES [dbo].[Company] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Company]
GO
ALTER TABLE [dbo].[ProductItem]  WITH CHECK ADD  CONSTRAINT [FK_ProductItem_InventoryDateLocation] FOREIGN KEY([InventoryDateLocation_Id])
REFERENCES [dbo].[InventoryDateLocation] ([Id])
GO
ALTER TABLE [dbo].[ProductItem] CHECK CONSTRAINT [FK_ProductItem_InventoryDateLocation]
GO
ALTER TABLE [dbo].[ProductItem]  WITH CHECK ADD  CONSTRAINT [FK_ProductItem_Product] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[ProductItem] CHECK CONSTRAINT [FK_ProductItem_Product]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteAllData]    Script Date: 21.5.2021. 13:55:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_DeleteAllData]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRAN 

    DELETE [dbo].[ProductItem]
    DELETE [dbo].[InventoryDateLocation]
    DELETE [dbo].[InventoryLocation]
	DELETE [dbo].[Product]
    DELETE [dbo].[Company]
    DELETE [dbo].[Inventory]

	COMMIT
END
GO
USE [master]
GO
ALTER DATABASE [MyCompany] SET  READ_WRITE 
GO
