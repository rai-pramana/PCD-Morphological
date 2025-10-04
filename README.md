# PCD-Morphological

Program aplikasi GUI MATLAB untuk melakukan operasi morfologi pada citra digital. Project ini dikembangkan sebagai tugas mata kuliah Pengolahan Citra Digital.

## 👥 Tim Pengembang (Kelompok F)

| Nama                             | NIM        |
| -------------------------------- | ---------- |
| I Kadek Rai Pramana              | 2105551094 |
| Ni Putu Adnya Puspita Dewi       | 2105551099 |
| Gusti Ngurah Satya Bagus Partama | 2105551100 |
| Dyah Putri Maheswari             | 2105551102 |

## 📋 Deskripsi

Aplikasi ini merupakan implementasi GUI MATLAB yang menyediakan berbagai operasi morfologi untuk pengolahan citra digital, termasuk:

-   **Operasi Dasar**: Dilasi dan Erosi
-   **Operasi Gabungan**: Opening dan Closing
-   **Operasi Khusus**: Thinning dan Thickening

## ✨ Fitur Utama

### 🖼️ Manajemen Citra

-   Upload foto dari file sistem
-   Konversi otomatis ke grayscale dan biner
-   Preview citra asli, biner, dan hasil operasi
-   Simpan hasil operasi ke file

### 🔧 Operasi Morfologi

#### Operasi Dasar

-   **Dilasi**: Memperbesar/mengembangkan objek dalam citra
-   **Erosi**: Memperkecil/mengikis objek dalam citra

#### Operasi Gabungan

-   **Opening**: Erosi diikuti dilasi (menghilangkan noise kecil)
-   **Closing**: Dilasi diikuti erosi (mengisi lubang kecil)

#### Operasi Khusus

-   **Thinning**: Menipis objek hingga menjadi skeleton
-   **Thickening**: Menebalkan objek dengan iterasi tertentu

### 🔷 Struktur Elemen (Structuring Element)

Mendukung berbagai bentuk struktur elemen:

-   **Disk**: Bentuk lingkaran
-   **Diamond**: Bentuk berlian
-   **Square**: Bentuk persegi
-   **Octagon**: Bentuk oktagon

## 🚀 Cara Penggunaan

### Persyaratan Sistem

-   MATLAB R2016b atau versi lebih baru
-   Image Processing Toolbox

### Instalasi dan Menjalankan

1. Clone atau download repository ini
2. Buka MATLAB
3. Navigasi ke direktori project
4. Jalankan command berikut:
    ```matlab
    morphological
    ```

### Langkah Penggunaan

1. **Upload Foto**: Klik tombol "Upload Foto" untuk memilih citra
2. **Pilih Struktur Elemen**:
    - Pilih bentuk (Disk, Diamond, Square, atau Octagon)
    - Masukkan ukuran/radius pada input field
3. **Pilih Operasi**: Klik salah satu tombol operasi morfologi
4. **Lihat Hasil**: Hasil akan ditampilkan pada panel kanan
5. **Simpan**: Klik "Simpan Foto" untuk menyimpan hasil

## 📁 Struktur File

```
PCD-Morphological/
├── morphological.m          # File utama aplikasi GUI
├── morphological.fig        # File layout GUI (jika ada)
└── README.md               # Dokumentasi project
```

## 🔬 Detail Teknis

### Algoritma yang Diimplementasikan

1. **Konversi Citra**:

    ```matlab
    fotoGrayscale = im2gray(foto);
    fotoBW = not(imbinarize(fotoGrayscale));
    ```

2. **Operasi Morfologi**:

    - Dilasi: `imdilate(fotoBW, SE)`
    - Erosi: `imerode(fotoBW, SE)`
    - Opening: `imdilate(imerode(fotoBW, SE), SE)`
    - Closing: `imerode(imdilate(fotoBW, SE), SE)`

3. **Operasi Khusus**:
    - Thinning: `bwmorph(fotoBW, 'thin', Inf)`
    - Thickening: `bwmorph(fotoBW, 'thicken', n)`

### Struktur Elemen

```matlab
SE = strel(bentuk, ukuran);
```

## 📊 Contoh Penggunaan

### Menghilangkan Noise (Opening)

1. Upload citra yang mengandung noise kecil
2. Pilih struktur elemen "Disk" dengan radius 2-3
3. Klik tombol "Opening"
4. Noise kecil akan hilang dari citra

### Mengisi Lubang (Closing)

1. Upload citra dengan lubang kecil pada objek
2. Pilih struktur elemen "Disk" dengan radius sesuai ukuran lubang
3. Klik tombol "Closing"
4. Lubang kecil akan terisi

## 🎯 Aplikasi Praktis

-   **Preprocessing citra**: Menghilangkan noise dan memperbaiki struktur objek
-   **Analisis bentuk**: Ekstraksi skeleton dan analisis kontur
-   **Segmentasi citra**: Memisahkan objek dari background
-   **Deteksi tepi**: Menggunakan operasi morfologi gradient

## 📝 Catatan Pengembangan

-   GUI dibuat menggunakan MATLAB GUIDE
-   Menggunakan Image Processing Toolbox untuk operasi morfologi
-   Implementasi event-driven programming untuk interaksi user
-   Validasi input untuk mencegah error runtime

## 📞 Kontak

Untuk pertanyaan atau saran terkait project ini, silakan hubungi salah satu anggota tim pengembang.

---

**Mata Kuliah**: Pengolahan Citra Digital - Kelas C  
**Tahun**: 2022  
**Institusi**: [Nama Universitas]
