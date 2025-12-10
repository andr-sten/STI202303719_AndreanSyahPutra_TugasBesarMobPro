# 🗺️ Travel Wisata Lokal

## 👥 Tim Pengembang

| Peran       | Nama               | NIM          |
| ----------- | ------------------ | ------------ |
| **Ketua**   | Andrean Syah Putra | STI202303719 |
| **Anggota** | Inez Dea Ariska    | STI202303642 |
| **Anggota** | Fani Amalia        | STI202303653 |
| **Anggota** | Sriyati            | STI202303700 |
| **Anggota** | Ari Nur Anita      | STI202303626 |

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)

Aplikasi mobile berbasis Flutter untuk menemukan dan mengelola destinasi wisata lokal. Proyek ini dikembangkan sebagai tugas kelompok untuk mendemonstrasikan fitur CRUD dengan SQLite, integrasi peta, pencarian, dan manajemen tema.

---

## 📱 Splash Screen & Intro

Tampilan awal aplikasi dengan desain modern dan animasi ringan.

<p align="center">
  <img src="assets/images/splash.jpg" width="230">
</p>

---

## 🏠 Halaman Utama (Home)

Berisi daftar wisata dengan pencarian, filter, dan kartu informasi wisata.

### Light Mode

<p align="center">
  <img src="assets/images/home_light.jpg" width="230">
</p>

---

<p align="center">
  <img src="assets/images/home_light2.jpg" width="230">
</p>

---

### Dark Mode

<p align="center">
  <img src="assets/images/home_dark.jpg" width="230">
</p>

---

<p align="center">
  <img src="assets/images/home_dark2.jpg" width="230">
</p>

---

## ℹ️ Detail Wisata

Menampilkan detail lengkap seperti foto, deskripsi, rating, harga tiket, dan jam operasional.

<p align="center">
  <img src="assets/images/detail.jpg" width="230">
</p>

---

<p align="center">
  <img src="assets/images/detail2.jpg" width="230">
</p>

---

Terdapat tombol elipsis untuk edit / hapus dengan dialog konfirmasi

<p align="center">
  <img src="assets/images/dialoghapus.jpg" width="230">
</p>

---

## 🗺️ Peta Sebaran Lokasi

Menampilkan lokasi semua tempat wisata dalam satu peta, serta lokasi pengguna saat ini.

<p align="center">
  <img src="assets/images/maps.png" width="230">
</p>

---

## 📝 Form Tambah & Edit Wisata

Form untuk menambah atau mengubah data wisata.

<p align="center">
  <img src="assets/images/form.jpg" width="230">
</p>

---

Memilih gambar dengan Image Picker.

<p align="center">
  <img src="assets/images/gambar.jpg" width="230">
</p>

---

Memilih jam operasional wisata dengan Time Picker.

<p align="center">
  <img src="assets/images/time.jpg" width="230">
</p>

---

Memilih titik koordinat melalui peta.

<p align="center">
  <img src="assets/images/tambahpeta.jpg" width="230">
</p>

---

<p align="center">
  <img src="assets/images/tambahpeta2.jpg" width="230">
</p>

---

## 🔍 Halaman Pencarian

Pada halaman ini pengguna dapat mencari wisata dengan kata kunci nama wisata atau lokasi wisata.

<p align="center">
  <img src="assets/images/cari.jpg" width="230">
</p>

---

## ✏️ Halaman About

Menampilkan nama pengembang aplikasi.

<p align="center">
  <img src="assets/images/about.jpg" width="230">
</p>

---

## ✨ Fitur Utama

- **CRUD Lengkap**: Tambah, lihat, edit, hapus data wisata.
- **SQLite Offline Database** (`sqflite`)
- **Integrasi Google Maps**:
  - Menampilkan semua lokasi wisata
  - Memilih titik lokasi
  - Deteksi posisi pengguna
- **Dark/Light Mode** dengan penyimpanan otomatis (`shared_preferences`)
- **Pencarian & Filter kategori**
- **Detail informasi wisata lengkap**
- **UI/UX modern**, custom icon, custom fonts, dan animasi

---

## 🛠️ Teknologi & Paket

- **Flutter (Dart)**
- **State Management:** `setState` native
- **Database:** `sqflite`, `path`
- **Maps:** `google_maps_flutter`
- **Utilities:**
  - `image_picker`
  - `shared_preferences`
  - `intl`
  - `permission_handler`
- **UI Assets:** `flutter_launcher_icons`

---
