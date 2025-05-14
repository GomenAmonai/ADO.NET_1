CREATE DATABASE MusicDB;
GO

USE MusicDB;
GO


IF OBJECT_ID('dbo.songs', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.songs (
        song_id        INT           IDENTITY(1,1) PRIMARY KEY,
        title          NVARCHAR(200) NOT NULL,
        artist         NVARCHAR(200) NOT NULL,
        file_path      NVARCHAR(500) NOT NULL,
        file_size_kb   INT           NOT NULL DEFAULT 0,
        duration_sec   INT           NOT NULL DEFAULT 0
    );
END
ELSE
BEGIN

    IF COL_LENGTH('dbo.songs', 'file_size_kb') IS NULL
        ALTER TABLE dbo.songs ADD file_size_kb INT NOT NULL DEFAULT 0;
    IF COL_LENGTH('dbo.songs', 'duration_sec') IS NULL
        ALTER TABLE dbo.songs ADD duration_sec INT NOT NULL DEFAULT 0;
END
GO


INSERT INTO dbo.songs (title, artist, file_path, file_size_kb, duration_sec)
VALUES
('Song A', 'Artist 1', 'C:\Music\songA.mp3', 5120, 215),
('Song B', 'Artist 2', 'C:\Music\songB.mp3', 7340, 180);
GO
