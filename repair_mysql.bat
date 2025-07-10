@echo off
title XAMPP MySQL Advanced Repair Tool
color 0A
setlocal enabledelayedexpansion

echo =============================================
echo  XAMPP MySQL Advanced Repair Tool
echo  Versi 2.0 - Untuk error shutdown tak terduga
echo =============================================
echo.

:: Set path XAMPP (sesuaikan jika perlu)
set xampp_path=C:\xampp
set mysql_path=%xampp_path%\mysql
set mysql_data=%mysql_path%\data

:: Langkah 1: Cek dan bebaskan port 3306
echo [LANGKAH 1] Memeriksa port 3306...
netstat -ano | findstr 3306 > nul
if %errorlevel% equ 0 (
    echo [WARNING] Port 3306 sedang digunakan!
    echo Proses yang menggunakan port 3306:
    netstat -ano | findstr 3306
    echo.
    set /p killproc="Hentikan proses ini? (y/n): "
    if /i "!killproc!"=="y" (
        for /f "tokens=5" %%a in ('netstat -ano ^| findstr 3306') do (
            taskkill /F /PID %%a
            echo Proses PID %%a dihentikan.
        )
    )
) else (
    echo Port 3306 tersedia.
)

:: Langkah 2: Hentikan semua proses MySQL
echo.
echo [LANGKAH 2] Menghentikan semua proses MySQL...
taskkill /F /IM mysqld.exe /T > nul 2>&1
timeout /t 2 /nobreak > nul

:: Langkah 3: Perbaikan service MySQL
echo.
echo [LANGKAH 3] Memperbaiki service MySQL...
cd /d %mysql_path%\bin
mysqld --remove > nul 2>&1
mysqld --install > nul 2>&1

:: Langkah 4: Periksa file ibdata1 dan ib_logfile
echo.
echo [LANGKAH 4] Memeriksa file sistem MySQL...
if exist "%mysql_data%\ibdata1" (
    echo Membackup file ibdata1...
    copy "%mysql_data%\ibdata1" "%mysql_data%\ibdata1.bak_%date:/=-%"
)
if exist "%mysql_data%\ib_logfile0" (
    echo Menghapus file log yang mungkin rusak...
    del "%mysql_data%\ib_logfile*"
)

:: Langkah 5: Rebuild tabel sistem
echo.
echo [LANGKAH 5] Memperbaiki tabel sistem...
mysqld --initialize-insecure --user=mysql
echo Tabel sistem diinisialisasi ulang.

:: Langkah 6: Set ulang password root
echo.
echo [LANGKAH 6] Set ulang password root...
echo UPDATE mysql.user SET authentication_string=PASSWORD('') WHERE User='root'; > reset_root.sql
echo FLUSH PRIVILEGES; >> reset_root.sql

:: Langkah 7: Mulai service MySQL
echo.
echo [LANGKAH 7] Memulai MySQL service...
net start mysql

echo.
echo =============================================
echo  PROSES PERBAIKAN SELESAI
echo =============================================
echo.
echo Jika MySQL masih gagal, lakukan:
echo 1. Periksa file error log di %mysql_data%\mysql_error.log
echo 2. Coba jalankan mysqld secara manual dari command prompt
echo 3. Pertimbangkan backup data dan install ulang XAMPP
echo.
pause
