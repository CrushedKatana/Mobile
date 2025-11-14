# Praktikum 11 - Books App
## Mengunduh Data dari Web Service (API)

**Nama:** Katana  
**NIM:** [Your NIM]

---

## Praktikum 1: Mengunduh Data dari Web Service (API)

### Langkah 1: Buat Project Baru
✅ Project Flutter dengan nama `books` telah dibuat di folder `week11`

Menambahkan dependensi http:
```bash
flutter pub add http
```

### Langkah 2: Cek file pubspec.yaml
✅ Plugin http berhasil ditambahkan ke `pubspec.yaml`

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.6.0
```

### Langkah 3: Buka file main.dart

#### Soal 1


```dart
return MaterialApp(
  title: 'Back from the Future - Charel',
  theme: ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  home: const FuturePage(),
);
```

### Langkah 4: Tambah method getData()

#### Soal 2
📚 **Buku Favorit:** Loner Life in Another World Vol. 1 (manga)
- **Judul:** Loner Life in Another World Vol. 1 (manga)
- **Penulis:** Shoji Goji
- **ID Buku:** `TBnWDwAAQBAJ`

**URL API Google Books:**
```
https://www.googleapis.com/books/v1/volumes/TBnWDwAAQBAJ
```

**Screenshot JSON Response:**

![](./screenshots/image.png)

*Catatan: Silakan akses URL di atas di browser untuk melihat response JSON lengkap dari Google Books API*

**Kode getData():**
```dart
Future<Response> getData() async {
  const authority = 'www.googleapis.com';
  const path = '/books/v1/volumes/TBnWDwAAQBAJ';
  Uri url = Uri.https(authority, path);
  return http.get(url);
}
```

### Langkah 5: Tambah kode di ElevatedButton

#### Soal 3

**Penjelasan kode:**

**1. `substring(0, 450)`:**
- Method `substring()` digunakan untuk mengambil sebagian string dari data JSON yang diterima
- Parameter `(0, 450)` berarti mengambil karakter dari indeks 0 sampai 450
- Ini dilakukan untuk membatasi jumlah data yang ditampilkan di layar agar tidak terlalu panjang dan memudahkan pembacaan
- Tanpa substring, seluruh response JSON (yang bisa sangat panjang) akan ditampilkan dan membuat UI tidak rapi

**2. `catchError()`:**
- Method `catchError()` adalah error handler untuk menangani exception yang mungkin terjadi saat melakukan HTTP request
- Jika terjadi error (misalnya: tidak ada koneksi internet, timeout, atau URL tidak valid), maka kode di dalam `catchError()` akan dijalankan
- Dalam kasus ini, jika terjadi error, variabel `result` akan diisi dengan string `'An error occurred'` dan `setState()` dipanggil untuk memperbarui UI
- Ini membuat aplikasi lebih robust dan user-friendly karena memberikan feedback yang jelas ketika terjadi kesalahan

**Kode lengkap ElevatedButton:**
```dart
ElevatedButton(
  child: const Text('GO!'),
  onPressed: () {
    setState(() {});
    getData().then((value) {
      result = value.body.toString().substring(0, 450);
      setState(() {});
    }).catchError((_) {
      result = 'An error occurred';
      setState(() {});
    });
  },
),
```

**Hasil Praktikum:**

![](./screenshots/image1.png)

