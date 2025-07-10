## 📌 Deskripsi
Batch script ini membantu memperbaiki masalah MySQL di XAMPP yang sering mengalami shutdown tak terduga (unexpected shutdown). Script ini melakukan serangkaian perbaikan otomatis, termasuk:
- Memeriksa dan membersihkan port yang digunakan MySQL (3306)
- Menghentikan proses MySQL yang bermasalah
- Memperbaiki instalasi service MySQL
- Membackup data dan memperbaiki file sistem MySQL
- Mengatur ulang password root (opsional)

## 📋 Fitur Utama
✅ Perbaikan Port 3306
- Mengecek apakah port MySQL sedang digunakan oleh proses lain
- Memberikan opsi untuk menghentikan proses yang memblokir port

✅ Perbaikan Service MySQL
- Menghapus dan menginstall ulang service MySQL
- Memastikan konfigurasi service benar

✅ Perbaikan File Sistem MySQL
- Membackup file penting (ibdata1, tabel sistem)
- Menghapus file log yang mungkin rusak (ib_logfile*)
- Menginisialisasi ulang tabel sistem jika diperlukan

✅ Reset Password Root (Opsional)
- Mengembalikan password root MySQL ke kosong (opsional)

🛠 Cara Penggunaan
- Jalankan sebagai Administrator
- Klik kanan file repair_mysql.bat → Run as Administrator.
- Ikuti Instruksi di Layar
- Script akan memandu Anda melalui proses perbaikan.
- Mulai Ulang XAMPP
- Setelah selesai, jalankan kembali XAMPP dan cek apakah MySQL berjalan normal.

# ⚠ Catatan Penting
✅ Backup Data ⚠
- Script secara otomatis membackup folder data MySQL, tetapi disarankan untuk melakukan backup manual sebelum menjalankan perbaikan.
- Lokasi XAMPP Default
- Script mengasumsikan XAMPP terinstall di C:\xampp. Jika berbeda, edit variabel xampp_path di dalam script.
