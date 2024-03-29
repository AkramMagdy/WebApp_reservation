USE [master]
GO
/****** Object:  Database [ReservationHotelOnlineDB]    Script Date: 6/14/2019 9:14:38 AM ******/
CREATE DATABASE [ReservationHotelOnlineDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ReservationHotelOnlineDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQL2016\MSSQL\DATA\ReservationHotelOnlineDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ReservationHotelOnlineDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQL2016\MSSQL\DATA\ReservationHotelOnlineDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ReservationHotelOnlineDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET  MULTI_USER 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ReservationHotelOnlineDB', N'ON'
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET QUERY_STORE = OFF
GO
USE [ReservationHotelOnlineDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [ReservationHotelOnlineDB]
GO
/****** Object:  Table [dbo].[MastarReservation]    Script Date: 6/14/2019 9:14:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MastarReservation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReservationDate] [date] NOT NULL,
 CONSTRAINT [PK_MastarReservation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservation]    Script Date: 6/14/2019 9:14:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoomTypeID] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[NoDays] [int] NOT NULL,
	[TotalPrice] [money] NOT NULL,
	[RoomID] [int] NOT NULL,
	[MastarID] [int] NOT NULL,
 CONSTRAINT [PK_Reservation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 6/14/2019 9:14:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[RoomTypeID] [int] NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomType]    Script Date: 6/14/2019 9:14:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Price] [money] NOT NULL,
 CONSTRAINT [PK_RoomType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[MastarReservation] ON 

INSERT [dbo].[MastarReservation] ([ID], [ReservationDate]) VALUES (1, CAST(N'2019-06-14' AS Date))
INSERT [dbo].[MastarReservation] ([ID], [ReservationDate]) VALUES (2, CAST(N'2019-06-14' AS Date))
INSERT [dbo].[MastarReservation] ([ID], [ReservationDate]) VALUES (3, CAST(N'2019-06-14' AS Date))
INSERT [dbo].[MastarReservation] ([ID], [ReservationDate]) VALUES (4, CAST(N'2019-06-14' AS Date))
INSERT [dbo].[MastarReservation] ([ID], [ReservationDate]) VALUES (5, CAST(N'2019-06-14' AS Date))
SET IDENTITY_INSERT [dbo].[MastarReservation] OFF
SET IDENTITY_INSERT [dbo].[Reservation] ON 

INSERT [dbo].[Reservation] ([ID], [RoomTypeID], [StartDate], [EndDate], [NoDays], [TotalPrice], [RoomID], [MastarID]) VALUES (1, 3, CAST(N'2019-06-14' AS Date), CAST(N'2019-06-22' AS Date), 9, 2700.0000, 24, 1)
INSERT [dbo].[Reservation] ([ID], [RoomTypeID], [StartDate], [EndDate], [NoDays], [TotalPrice], [RoomID], [MastarID]) VALUES (2, 3, CAST(N'2019-07-05' AS Date), CAST(N'2019-07-17' AS Date), 13, 3900.0000, 22, 2)
INSERT [dbo].[Reservation] ([ID], [RoomTypeID], [StartDate], [EndDate], [NoDays], [TotalPrice], [RoomID], [MastarID]) VALUES (3, 3, CAST(N'2019-06-07' AS Date), CAST(N'2019-06-17' AS Date), 11, 3300.0000, 25, 3)
INSERT [dbo].[Reservation] ([ID], [RoomTypeID], [StartDate], [EndDate], [NoDays], [TotalPrice], [RoomID], [MastarID]) VALUES (4, 2, CAST(N'2019-06-19' AS Date), CAST(N'2019-06-30' AS Date), 12, 2400.0000, 19, 3)
INSERT [dbo].[Reservation] ([ID], [RoomTypeID], [StartDate], [EndDate], [NoDays], [TotalPrice], [RoomID], [MastarID]) VALUES (5, 2, CAST(N'2019-06-20' AS Date), CAST(N'2019-06-29' AS Date), 10, 2000.0000, 19, 3)
INSERT [dbo].[Reservation] ([ID], [RoomTypeID], [StartDate], [EndDate], [NoDays], [TotalPrice], [RoomID], [MastarID]) VALUES (6, 3, CAST(N'2019-06-14' AS Date), CAST(N'2019-06-15' AS Date), 2, 600.0000, 23, 4)
INSERT [dbo].[Reservation] ([ID], [RoomTypeID], [StartDate], [EndDate], [NoDays], [TotalPrice], [RoomID], [MastarID]) VALUES (7, 2, CAST(N'2019-06-25' AS Date), CAST(N'2019-06-29' AS Date), 5, 1000.0000, 21, 5)
SET IDENTITY_INSERT [dbo].[Reservation] OFF
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (14, N'110', 1)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (15, N'120', 1)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (16, N'130', 1)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (17, N'140', 1)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (18, N'210', 2)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (19, N'220', 2)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (20, N'230', 2)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (21, N'240', 2)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (22, N'310', 3)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (23, N'320', 3)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (24, N'330', 3)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (25, N'340', 3)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (26, N'410', 4)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (27, N'420', 4)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (28, N'430', 4)
INSERT [dbo].[Room] ([ID], [Name], [RoomTypeID]) VALUES (29, N'440', 4)
SET IDENTITY_INSERT [dbo].[Room] OFF
SET IDENTITY_INSERT [dbo].[RoomType] ON 

INSERT [dbo].[RoomType] ([ID], [Type], [Price]) VALUES (1, N'Superior Room', 100.0000)
INSERT [dbo].[RoomType] ([ID], [Type], [Price]) VALUES (2, N'Suite ', 200.0000)
INSERT [dbo].[RoomType] ([ID], [Type], [Price]) VALUES (3, N'Family Room', 300.0000)
INSERT [dbo].[RoomType] ([ID], [Type], [Price]) VALUES (4, N'Villas ', 400.0000)
SET IDENTITY_INSERT [dbo].[RoomType] OFF
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_MastarReservation] FOREIGN KEY([MastarID])
REFERENCES [dbo].[MastarReservation] ([ID])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_MastarReservation]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Room] FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([ID])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_Room]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_RoomType] FOREIGN KEY([RoomTypeID])
REFERENCES [dbo].[RoomType] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_RoomType]
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_RoomType] FOREIGN KEY([RoomTypeID])
REFERENCES [dbo].[RoomType] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [FK_Room_RoomType]
GO
USE [master]
GO
ALTER DATABASE [ReservationHotelOnlineDB] SET  READ_WRITE 
GO
