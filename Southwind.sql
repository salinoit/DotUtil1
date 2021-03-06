USE [master]
GO
/****** Object:  Database [Southwind]    Script Date: 09/09/2019 09:18:06 ******/
CREATE DATABASE [Southwind]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Southwind_Data', FILENAME = N'C:\SQL Server\Southwind.mdf' , SIZE = 67200KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Southwind_Log', FILENAME = N'C:\SQL Server\Southwind.ldf' , SIZE = 996544KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Southwind] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Southwind].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [Southwind] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Southwind] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Southwind] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Southwind] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Southwind] SET ARITHABORT OFF 
GO
ALTER DATABASE [Southwind] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Southwind] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Southwind] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Southwind] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Southwind] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Southwind] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Southwind] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Southwind] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Southwind] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Southwind] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Southwind] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Southwind] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Southwind] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Southwind] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [Southwind] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Southwind] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [Southwind] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Southwind] SET RECOVERY FULL 
GO
ALTER DATABASE [Southwind] SET  MULTI_USER 
GO
ALTER DATABASE [Southwind] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Southwind] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Southwind] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Southwind] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Southwind] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Southwind] SET QUERY_STORE = OFF
GO
USE [Southwind]
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
USE [Southwind]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 09/09/2019 09:18:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Dep_ID] [int] IDENTITY(1,1) NOT NULL,
	[Dep_Name] [nvarchar](300) NULL,
	[Dep_Office] [nvarchar](300) NULL,
	[Loc_ID] [int] NULL,
	[Update_By] [nvarchar](100) NULL,
	[Update_Time] [datetime] NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[Dep_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 09/09/2019 09:18:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Emp_ID] [int] IDENTITY(1,1) NOT NULL,
	[Emp_First_Name] [nvarchar](300) NULL,
	[Emp_Last_Name] [nvarchar](300) NULL,
	[Emp_Job_Title] [nvarchar](300) NULL,
	[Emp_Manager_ID] [int] NULL,
	[Dep_ID] [int] NULL,
	[Update_By] [nvarchar](100) NULL,
	[Update_Time] [datetime] NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[Emp_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location]    Script Date: 09/09/2019 09:18:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[Loc_ID] [int] IDENTITY(1,1) NOT NULL,
	[Loc_Name] [nvarchar](300) NULL,
	[Loc_Country] [nvarchar](300) NULL,
	[Loc_Address1] [nvarchar](300) NULL,
	[Loc_Address2] [nvarchar](300) NULL,
	[Loc_City] [nvarchar](300) NULL,
	[Loc_Zip] [nvarchar](100) NULL,
	[Update_By] [nvarchar](100) NULL,
	[Update_Time] [datetime] NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[Loc_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logging]    Script Date: 09/09/2019 09:18:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logging](
	[Log_ID] [int] IDENTITY(1,1) NOT NULL,
	[Log_Severity] [nvarchar](50) NOT NULL,
	[Log_Source] [nvarchar](1000) NULL,
	[Log_Message] [varchar](4000) NULL,
	[Log_StackTrace] [nvarchar](4000) NULL,
	[Update_By] [nvarchar](100) NULL,
	[Update_Time] [datetime] NULL,
 CONSTRAINT [Logging_PK] PRIMARY KEY CLUSTERED 
(
	[Log_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([Dep_ID], [Dep_Name], [Dep_Office], [Loc_ID], [Update_By], [Update_Time]) VALUES (1, N'IT Services', N'Building 2a', 1, N'mgledhill', CAST(N'2019-09-08T15:00:00.000' AS DateTime))
INSERT [dbo].[Department] ([Dep_ID], [Dep_Name], [Dep_Office], [Loc_ID], [Update_By], [Update_Time]) VALUES (2, N'Human Resources', N'Building 3a', 1, N'mgledhll', CAST(N'2019-09-08T15:04:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([Emp_ID], [Emp_First_Name], [Emp_Last_Name], [Emp_Job_Title], [Emp_Manager_ID], [Dep_ID], [Update_By], [Update_Time]) VALUES (1, N'Mike', N'Jones', N'Software Developer', 2, 1, N'mgledhill', CAST(N'2019-09-08T15:00:00.000' AS DateTime))
INSERT [dbo].[Employee] ([Emp_ID], [Emp_First_Name], [Emp_Last_Name], [Emp_Job_Title], [Emp_Manager_ID], [Dep_ID], [Update_By], [Update_Time]) VALUES (2, N'Sandra', N'Müller', N'COO', NULL, 1, N'mgledhill', CAST(N'2019-09-08T15:04:00.000' AS DateTime))
INSERT [dbo].[Employee] ([Emp_ID], [Emp_First_Name], [Emp_Last_Name], [Emp_Job_Title], [Emp_Manager_ID], [Dep_ID], [Update_By], [Update_Time]) VALUES (3, N'Jason', N'Turner', N'Senior Developer', 2, 1, N'mgledhill', CAST(N'2019-09-08T15:04:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Employee] OFF
SET IDENTITY_INSERT [dbo].[Location] ON 

INSERT [dbo].[Location] ([Loc_ID], [Loc_Name], [Loc_Country], [Loc_Address1], [Loc_Address2], [Loc_City], [Loc_Zip], [Update_By], [Update_Time]) VALUES (1, N'Zurich', N'Switzerland', N'13-15 Stockerstrasse', N'', N'Zurich', N'8040', N'mgledhill', CAST(N'2019-09-08T14:40:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Location] OFF

ALTER TABLE [dbo].[Department]  WITH NOCHECK ADD  CONSTRAINT [FK_Department_Location] FOREIGN KEY([Loc_ID])
REFERENCES [dbo].[Location] ([Loc_ID])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Department] NOCHECK CONSTRAINT [FK_Department_Location]
GO
ALTER TABLE [dbo].[Employee]  WITH NOCHECK ADD  CONSTRAINT [FK_Employee_Department] FOREIGN KEY([Dep_ID])
REFERENCES [dbo].[Department] ([Dep_ID])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Employee] NOCHECK CONSTRAINT [FK_Employee_Department]
GO
ALTER TABLE [dbo].[Employee]  WITH NOCHECK ADD  CONSTRAINT [FK_Employee_Employee] FOREIGN KEY([Emp_Manager_ID])
REFERENCES [dbo].[Employee] ([Emp_ID])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Employee] NOCHECK CONSTRAINT [FK_Employee_Employee]
GO
USE [master]
GO
ALTER DATABASE [Southwind] SET  READ_WRITE 
GO
