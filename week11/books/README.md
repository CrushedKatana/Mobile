# Praktikum 11 - Books App
## Mengunduh Data dari Web Service (API)

**Nama:** Katana  
**NIM:** [Your NIM]

---

## 📑 Daftar Isi & Navigasi Cepat

### Praktikum 1: Mengunduh Data dari Web Service (API)
- [Soal 1](#soal-1) - Title & Theme Configuration
- [Soal 2](#soal-2) - Google Books API getData()
- [Soal 3](#soal-3) - substring() & catchError()

### Praktikum 2: Menggunakan await/async
- [Soal 4](#soal-4) - Async/Await Methods

### Praktikum 3: Menggunakan Completer di Future
- [Soal 5](#soal-5) - Completer Basics
- [Soal 6](#soal-6) - Error Handling dengan catchError()

### Praktikum 4: Memanggil Future secara paralel
- [Soal 7](#soal-7) - FutureGroup untuk Parallel Execution
- [Soal 8](#soal-8) - Future.wait sebagai Alternatif

### Praktikum 5: Menangani Respon Error pada Async Code
- [Soal 9](#soal-9) - Error Handling dengan then/catchError
- [Soal 10](#soal-10) - Error Handling dengan try-catch/finally

### Praktikum 6: Menggunakan Future dengan StatefulWidget
- [Soal 11](#soal-11) - Geolocation dengan initState
- [Soal 12](#soal-12) - Loading Animation & Browser GPS

### Praktikum 7: Manajemen Future dengan FutureBuilder
- [Soal 13](#soal-13) - FutureBuilder Basic Implementation
- [Soal 14](#soal-14) - Error Handling di FutureBuilder

### Praktikum 8: Navigation route dengan Future Function
- [Soal 15](#soal-15) - Navigation dengan Future untuk Return Value
- [Soal 16](#soal-16) - Color Selection dengan Navigator.pop()

### Praktikum 9: Memanfaatkan async/await dengan Widget Dialog
- [Soal 17](#soal-17) - AlertDialog dengan async/await

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


## Praktikum 2: Menggunakan await/async untuk menghindari callbacks

### Langkah 1: Buka file main.dart
Tambahkan tiga method berisi kode async di dalam class `_FuturePageState`:

```dart
Future<int> returnOneAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 1;
}

Future<int> returnTwoAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 2;
}

Future<int> returnThreeAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 3;
}
```

### Langkah 2: Tambah method count()
Tambahkan method `count()` untuk menjumlahkan hasil dari ketiga method async:

```dart
Future count() async {
  int total = 0;
  total = await returnOneAsync();
  total += await returnTwoAsync();
  total += await returnThreeAsync();
  setState(() {
    result = total.toString();
  });
}
```

### Langkah 3: Panggil count()
Update kode `onPressed()` pada ElevatedButton:

```dart
ElevatedButton(
  child: const Text('GO!'),
  onPressed: () {
    count();
  },
),
```

### Langkah 4: Run
Aplikasi akan menampilkan angka 6 setelah delay 9 detik.

#### Soal 4

**Penjelasan Maksud Kode Langkah 1 dan 2:**

**Langkah 1 - Tiga Method Async:**
- `returnOneAsync()`, `returnTwoAsync()`, dan `returnThreeAsync()` adalah method asynchronous yang mengembalikan nilai `Future<int>`
- Setiap method menggunakan `await Future.delayed(const Duration(seconds: 3))` untuk mensimulasikan operasi yang membutuhkan waktu 3 detik (misalnya: mengambil data dari server)
- Keyword `async` menandai bahwa method ini adalah asynchronous dan dapat menggunakan `await` di dalamnya
- Setelah delay 3 detik, masing-masing method mengembalikan nilai integer (1, 2, dan 3)

**Langkah 2 - Method count():**
- Method `count()` adalah method async yang menunggu hasil dari ketiga method di atas secara berurutan
- Keyword `await` memaksa eksekusi untuk menunggu sampai method selesai sebelum melanjutkan ke baris berikutnya
- Proses berjalan berurutan:
  1. Tunggu 3 detik → dapat nilai 1
  2. Tunggu 3 detik lagi → dapat nilai 2, total = 1 + 2 = 3
  3. Tunggu 3 detik lagi → dapat nilai 3, total = 3 + 3 = 6
- Total waktu: 3 + 3 + 3 = 9 detik
- Setelah semua selesai, `setState()` dipanggil untuk memperbarui UI dengan hasil total (6)

**Perbedaan dengan Praktikum 1:**
- Praktikum 1 menggunakan `.then()` dan callback (lebih kompleks dan sulit dibaca)
- Praktikum 2 menggunakan `async/await` (lebih clean, mudah dibaca seperti kode synchronous)

**Hasil Praktikum:**
![](./screenshots/image2.png)

---

## Praktikum 3: Menggunakan Completer di Future

### Langkah 1: Buka main.dart
Pastikan telah impor package async berikut:

```dart
import 'package:async/async.dart';
```

**Catatan:** Untuk praktikum ini, `Completer` sudah tersedia di `dart:async` yang sudah diimpor sebelumnya, jadi tidak perlu menambahkan package `async` secara terpisah.

### Langkah 2: Tambahkan variabel dan method
Tambahkan variabel late dan method di class `_FuturePageState`:

```dart
late Completer completer;

Future getNumber() {
  completer = Completer<int>();
  calculate();
  return completer.future;
}

Future calculate() async {
  await Future.delayed(const Duration(seconds: 5));
  completer.complete(42);
}
```

### Langkah 3: Ganti isi kode onPressed()
Tambahkan kode berikut pada fungsi `onPressed()`:

```dart
ElevatedButton(
  child: const Text('GO!'),
  onPressed: () {
    getNumber().then((value) {
      setState(() {
        result = value.toString();
      });
    });
  },
),
```

### Langkah 4: Run
Aplikasi akan menampilkan angka 42 setelah delay 5 detik.

#### Soal 5

**Penjelasan Maksud Kode Langkah 2:**

**1. Variabel `late Completer completer;`:**
- Mendeklarasikan variabel `completer` dengan tipe `Completer` menggunakan keyword `late`
- `late` berarti variabel ini akan diinisialisasi nanti (bukan saat deklarasi), tetapi pasti akan diinisialisasi sebelum digunakan
- `Completer` adalah class yang digunakan untuk membuat dan mengontrol Future secara manual

**2. Method `getNumber()`:**
- Method ini membuat instance baru dari `Completer<int>()` yang akan menghasilkan Future dengan nilai integer
- `calculate()` dipanggil untuk memulai proses asynchronous
- `return completer.future` mengembalikan Future yang akan selesai nanti ketika `completer.complete()` dipanggil
- Method ini tidak menggunakan `async` karena langsung mengembalikan Future dari completer

**3. Method `calculate()`:**
- Method async yang mensimulasikan operasi yang memakan waktu 5 detik dengan `Future.delayed()`
- Setelah 5 detik, `completer.complete(42)` dipanggil untuk menyelesaikan Future dengan nilai 42
- Ketika `complete()` dipanggil, semua listener yang menunggu Future tersebut (seperti `.then()` di `onPressed()`) akan menerima nilai 42

**Cara Kerja Completer:**
1. `getNumber()` membuat Completer dan mengembalikan Future-nya
2. `calculate()` berjalan di background, menunggu 5 detik
3. Setelah 5 detik, `completer.complete(42)` "menyelesaikan" Future dengan nilai 42
4. `.then()` di `onPressed()` menerima nilai 42 dan mengupdate UI

**Keuntungan Completer:**
- Memberikan kontrol penuh kapan dan bagaimana Future diselesaikan
- Berguna untuk operasi asynchronous yang kompleks atau event-based
- Memisahkan logika pembuatan Future dengan logika penyelesaiannya

**Hasil Praktikum:**

![](./screenshots/image3.png)

### Langkah 5: Ganti dengan method calculate
**Note:** Langkah ini sudah terimplementasi di Langkah 2.

### Langkah 6: Pindah ke onPressed()
Ganti kode `onPressed()` dengan menambahkan error handling menggunakan `catchError()`:

```dart
ElevatedButton(
  child: const Text('GO!'),
  onPressed: () {
    getNumber().then((value) {
      setState(() {
        result = value.toString();
      });
    }).catchError((e) {
      result = 'An error occurred';
    });
  },
),
```

#### Soal 6

**Jelaskan maksud perbedaan kode langkah 2 dengan langkah 5-6:**

**Perbedaan Utama:**

**Langkah 2 (Method calculate):**
```dart
Future calculate() async {
  await Future.delayed(const Duration(seconds: 5));
  completer.complete(42);
}
```
- Method `calculate()` hanya menyelesaikan Future dengan **sukses** menggunakan `completer.complete(42)`
- Tidak ada penanganan error di dalam method ini
- Future selalu diselesaikan dengan nilai 42 setelah 5 detik

**Langkah 5-6 (onPressed dengan catchError):**
```dart
getNumber().then((value) {
  setState(() {
    result = value.toString();
  });
}).catchError((e) {
  result = 'An error occurred';
});
```
- Menambahkan **error handling** dengan method `catchError()`
- Jika terjadi error saat eksekusi Future (misalnya: exception di `calculate()`, timeout, atau error lainnya), maka `catchError()` akan menangkapnya
- Memberikan feedback kepada user dengan menampilkan pesan error "An error occurred"
- Membuat aplikasi lebih **robust** dan **user-friendly** karena siap menangani kegagalan

**Kesimpulan Perbedaan:**
1. **Langkah 2** fokus pada **logika bisnis** (bagaimana Future diselesaikan)
2. **Langkah 5-6** fokus pada **error handling** (bagaimana menangani jika Future gagal)
3. Langkah 6 menambahkan layer **defensive programming** untuk mencegah aplikasi crash saat terjadi error
4. Dengan `catchError()`, kita memastikan bahwa apapun yang terjadi (sukses atau error), UI tetap akan diupdate dengan informasi yang sesuai

**Best Practice:**
- Selalu tambahkan `catchError()` atau `try-catch` pada operasi asynchronous
- Berikan feedback yang jelas kepada user saat terjadi error
- Hindari aplikasi crash dengan menangani semua kemungkinan error

**Hasil Praktikum:**

![W11: Soal 6](./screenshots/soal6.gif)

*GIF menunjukkan aplikasi menampilkan angka 42 setelah delay 5 detik dengan error handling*

---

## Praktikum 4: Memanggil Future secara paralel

### Langkah 1: Buka file main.dart
Tambahkan method `returnFG()` ke dalam class `_FuturePageState`:

```dart
void returnFG() {
  FutureGroup<int> futureGroup = FutureGroup<int>();
  futureGroup.add(returnOneAsync());
  futureGroup.add(returnTwoAsync());
  futureGroup.add(returnThreeAsync());
  futureGroup.close();
  futureGroup.future.then((List<int> value) {
    int total = 0;
    for (var element in value) {
      total += element;
    }
    setState(() {
      result = total.toString();
    });
  });
}
```

### Langkah 2: Edit onPressed()
Panggil method `returnFG()` pada button.

### Langkah 3: Run
Aplikasi akan menampilkan angka 6 dalam **3 detik** (lebih cepat dari Praktikum 2 yang membutuhkan 9 detik).

#### <a id="soal-7"></a>Soal 7

[🔝 Kembali ke Daftar Isi](#-daftar-isi--navigasi-cepat) | [⬅️ Soal 6](#soal-6) | [➡️ Soal 8](#soal-8)

**Hasil Praktikum:**

![W11: Soal 7](./screenshots/soal7.gif)

*GIF menunjukkan aplikasi menampilkan angka 6 setelah delay 3 detik menggunakan FutureGroup (eksekusi paralel)*

**Penjelasan:**
- **FutureGroup** menjalankan ketiga Future (`returnOneAsync()`, `returnTwoAsync()`, `returnThreeAsync()`) secara **paralel/bersamaan**
- Ketiga method berjalan di waktu yang sama, bukan berurutan
- Total waktu = **3 detik** (waktu terlama dari ketiga method), bukan 9 detik
- Hasil dikembalikan sebagai `List<int>` yang kemudian dijumlahkan
- Lebih efisien untuk operasi yang tidak saling bergantung

### Langkah 4: Ganti variabel futureGroup
Anda dapat menggunakan `Future.wait` sebagai alternatif dari `FutureGroup`:

```dart
Future returnFW() async {
  final futures = Future.wait<int>([
    returnOneAsync(),
    returnTwoAsync(),
    returnThreeAsync(),
  ]);
  
  futures.then((List<int> value) {
    int total = 0;
    for (var element in value) {
      total += element;
    }
    setState(() {
      result = total.toString();
    });
  });
}
```

#### <a id="soal-8"></a>Soal 8

[🔝 Kembali ke Daftar Isi](#-daftar-isi--navigasi-cepat) | [⬅️ Soal 7](#soal-7)

**Jelaskan maksud perbedaan kode langkah 1 dan 4:**

**Perbandingan FutureGroup vs Future.wait:**

| Aspek | Langkah 1: FutureGroup | Langkah 4: Future.wait |
|-------|------------------------|------------------------|
| **Package** | Memerlukan `package:async/async.dart` | Built-in di `dart:async` |
| **Cara Menambahkan Future** | Menggunakan method `add()` satu per satu | Langsung dalam List/Array |
| **Penutupan** | Harus memanggil `close()` | Tidak perlu `close()` |
| **Fleksibilitas** | Dapat menambahkan Future secara dinamis | Semua Future ditentukan di awal |
| **Sintaks** | Lebih verbose (lebih banyak kode) | Lebih ringkas dan sederhana |
| **Kasus Penggunaan** | Cocok untuk Future yang ditambahkan secara dinamis | Cocok untuk jumlah Future yang sudah pasti |

**Langkah 1 - FutureGroup:**
```dart
void returnFG() {
  FutureGroup<int> futureGroup = FutureGroup<int>();
  futureGroup.add(returnOneAsync());      // Tambah satu per satu
  futureGroup.add(returnTwoAsync());
  futureGroup.add(returnThreeAsync());
  futureGroup.close();                     // WAJIB close()
  futureGroup.future.then(...);
}
```

**Keuntungan:**
- Bisa menambahkan Future secara dinamis (dalam loop, kondisional, dll)
- Lebih fleksibel untuk kasus kompleks
- Dapat menambahkan Future setelah object dibuat

**Kekurangan:**
- Harus import package eksternal (`async/async.dart`)
- Harus memanggil `close()` (jika lupa, Future tidak akan selesai)
- Sintaks lebih panjang

**Langkah 4 - Future.wait:**
```dart
Future returnFW() async {
  final futures = Future.wait<int>([      // Langsung dalam array
    returnOneAsync(),
    returnTwoAsync(),
    returnThreeAsync(),
  ]);
  futures.then(...);
}
```

**Keuntungan:**
- Built-in, tidak perlu package tambahan
- Sintaks lebih clean dan ringkas
- Tidak perlu `close()`, lebih aman dari error
- Lebih idiomatik di Dart

**Kekurangan:**
- Semua Future harus ditentukan di awal
- Kurang fleksibel untuk penambahan dinamis

**Kesimpulan:**
- Keduanya menjalankan Future secara **paralel** dengan hasil yang sama
- **Future.wait** lebih direkomendasikan untuk kasus umum karena lebih sederhana
- **FutureGroup** berguna untuk kasus khusus yang memerlukan penambahan Future secara dinamis

**Hasil Praktikum:**

![W11: Soal 8](./screenshots/soal8.gif)

*GIF menunjukkan aplikasi menampilkan angka 6 setelah delay 3 detik menggunakan Future.wait (hasil sama dengan FutureGroup)*

---

## Praktikum 5: Menangani Respon Error pada Async Code

### Langkah 1: Buka file main.dart
Tambahkan method `returnError()` ke dalam class `_FuturePageState`:

```dart
Future returnError() async {
  await Future.delayed(const Duration(seconds: 2));
  throw Exception('Something terrible happened!');
}
```

### Langkah 2: ElevatedButton
Tambahkan kode berikut untuk menangani error dengan `then()`, `catchError()`, dan `whenComplete()`:

```dart
ElevatedButton(
  child: const Text('Soal 9: returnError()'),
  onPressed: () {
    returnError().then((value) {
      setState(() {
        result = 'Success';
      });
    }).catchError((onError) {
      setState(() {
        result = onError.toString();
      });
    }).whenComplete(() => print('Complete'));
  },
),
```

### Langkah 3: Run
Setelah menekan tombol, aplikasi akan menampilkan pesan error dan di debug console akan muncul teks **"Complete"**.

#### <a id="soal-9"></a>Soal 9

[🔝 Kembali ke Daftar Isi](#-daftar-isi--navigasi-cepat) | [⬅️ Soal 8](#soal-8) | [➡️ Soal 10](#soal-10)

**Hasil Praktikum:**

![W11: Soal 9](./screenshots/soal9.gif)

*GIF menunjukkan aplikasi menampilkan error message setelah 2 detik menggunakan then/catchError/whenComplete*

**Penjelasan:**
- `returnError()` mensimulasikan operasi async yang **gagal** dengan throw Exception
- `then()` akan dijalankan jika Future **berhasil** (tidak dijalankan di sini)
- `catchError()` menangkap exception dan menampilkan pesan error ke UI
- `whenComplete()` **selalu dijalankan** di akhir (seperti finally), print "Complete" ke console
- Debug console menampilkan "Complete" setelah error ditangani

### Langkah 4: Tambah method handleError()
Tambahkan method `handleError()` untuk menangani error dengan pola `try-catch-finally`:

```dart
Future handleError() async {
  try {
    await returnError();
  } catch (error) {
    setState(() {
      result = error.toString();
    });
  } finally {
    print('Complete');
  }
}
```

#### <a id="soal-10"></a>Soal 10

[🔝 Kembali ke Daftar Isi](#-daftar-isi--navigasi-cepat) | [⬅️ Soal 9](#soal-9)

**Panggil method handleError() tersebut di ElevatedButton, lalu run. Apa hasilnya? Jelaskan perbedaan kode langkah 1 dan 4!**

**Hasil Praktikum:**

![W11: Soal 10](./screenshots/soal10.gif)

*GIF menunjukkan aplikasi menampilkan error message setelah 2 detik menggunakan try-catch-finally*

**Hasil yang Didapat:**
- Aplikasi menampilkan pesan error yang sama: `Exception: Something terrible happened!`
- Debug console juga menampilkan "Complete"
- **Hasilnya identik dengan Soal 9**, tetapi menggunakan pendekatan berbeda

**Perbedaan Kode Langkah 1 dan 4:**

| Aspek | Langkah 1: then/catchError | Langkah 4: try-catch-finally |
|-------|---------------------------|------------------------------|
| **Paradigma** | Callback-based (functional) | Imperative (procedural) |
| **Keyword** | `then()`, `catchError()`, `whenComplete()` | `try`, `catch`, `finally` |
| **Async Marker** | Tidak wajib `async` | **Wajib** menggunakan `async` |
| **Await** | Tidak menggunakan `await` | Menggunakan `await` |
| **Readability** | Chaining methods | Linear, seperti kode synchronous |
| **Error Type** | Parameter di `catchError(onError)` | Parameter di `catch (error)` |
| **Completion** | `whenComplete()` | `finally` |
| **Sintaks** | Functional programming style | Traditional exception handling |

**Langkah 1 - Callback Approach:**
```dart
returnError()
  .then((value) {
    // Jika sukses (tidak terjadi di sini)
    result = 'Success';
  })
  .catchError((onError) {
    // Tangkap error dengan callback
    result = onError.toString();
  })
  .whenComplete(() => print('Complete'));  // Selalu dieksekusi
```

**Keuntungan:**
- Dapat digunakan tanpa `async` function
- Lebih cocok untuk chain operations
- Lebih functional programming style

**Kekurangan:**
- Kurang familiar bagi programmer dari bahasa lain
- Bisa jadi sulit dibaca jika chain-nya panjang
- Callback hell jika terlalu nested

**Langkah 4 - Try-Catch Approach:**
```dart
Future handleError() async {           // Wajib async
  try {
    await returnError();                // Wajib await
    // Kode setelah ini jika sukses
  } catch (error) {
    // Tangkap error dengan catch block
    result = error.toString();
  } finally {
    print('Complete');                  // Selalu dieksekusi
  }
}
```

**Keuntungan:**
- **Lebih familiar** bagi programmer dari bahasa lain (Java, C#, Python)
- **Lebih mudah dibaca**, seperti kode synchronous
- Lebih jelas flow-nya: coba → gagal → selesai
- Dapat menangani multiple exceptions dengan catch yang berbeda

**Kekurangan:**
- Harus menggunakan `async/await`
- Tidak bisa digunakan langsung di onPressed tanpa wrapper function

**Kesimpulan:**
1. **Kedua metode menghasilkan hasil yang identik**
2. **then/catchError** cocok untuk operasi sederhana dan one-liner
3. **try-catch** lebih direkomendasikan untuk:
   - Kode yang kompleks
   - Programmer yang familiar dengan exception handling tradisional
   - Ketika perlu menangani multiple error types
4. **Best Practice**: Gunakan `try-catch` untuk consistency dan readability

**Kapan Menggunakan yang Mana?**
- **Gunakan then/catchError**: Untuk quick operations, chaining, atau functional style
- **Gunakan try-catch**: Untuk business logic yang kompleks, error handling yang detail, atau ketika tim lebih familiar dengan syntax ini

---

## Praktikum 6: Menggunakan Future dengan StatefulWidget

### Langkah 1: Install plugin geolocator
Tambahkan plugin geolocator dengan mengetik perintah berikut di terminal:

```bash
flutter pub add geolocator
```

### Langkah 2: Tambah permission GPS

**Untuk Android** - Tambahkan baris kode berikut di file `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

**Untuk iOS** - Tambahkan kode ini ke file `ios/Runner/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs to access your location</string>
```

### Langkah 3: Buat file geolocation.dart
Tambahkan file baru `geolocation.dart` di folder lib project.

### Langkah 4: Buat StatefulWidget
Buat class `LocationScreen` di dalam file geolocation.dart.

### Langkah 5: Isi kode geolocation.dart

```dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';
  
  @override
  void initState() {
    super.initState();
    getPosition().then((Position myPos) {
      myPosition = 'Latitude: \${myPos.latitude.toString()} - Longitude: \${myPos.longitude.toString()}';
      setState(() {
        myPosition = myPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Location - Charel'),
      ),
      body: Center(
        child: Text(myPosition),
      ),
    );
  }

  Future<Position> getPosition() async {
    await Geolocator.requestPermission();
    await Geolocator.isLocationServiceEnabled();
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
```

#### <a id="soal-11"></a>Soal 11

[🔝 Kembali ke Daftar Isi](#-daftar-isi--navigasi-cepat) | [⬅️ Soal 10](#soal-10) | [➡️ Soal 12](#soal-12)

✅ **Nama panggilan "Charel" telah ditambahkan pada properti title di AppBar.**

### Langkah 6: Edit main.dart
Panggil screen baru tersebut di file main:

```dart
import 'geolocation.dart';

// Di dalam MyApp
home: const LocationScreen(),
```

### Langkah 7: Run
Run project di device atau emulator (bukan browser).

### Langkah 8: Tambahkan animasi loading
Tambahkan widget loading dengan kode berikut:

```dart
class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';
  bool loading = false;
  
  // ... initState() ...
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Location - Charel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading)
              const CircularProgressIndicator()
            else
              Text(myPosition),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  loading = true;
                });
                getPosition().then((Position myPos) {
                  myPosition = 'Latitude: \${myPos.latitude} - Longitude: \${myPos.longitude}';
                  setState(() {
                    myPosition = myPosition;
                    loading = false;
                  });
                });
              },
              child: const Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### <a id="soal-12"></a>Soal 12

[🔝 Kembali ke Daftar Isi](#-daftar-isi--navigasi-cepat) | [⬅️ Soal 11](#soal-11)

**Delay telah ditambahkan pada method getPosition():**

```dart
Future<Position> getPosition() async {
  await Geolocator.requestPermission();
  await Geolocator.isLocationServiceEnabled();
  await Future.delayed(const Duration(seconds: 3)); // Delay 3 detik
  Position position = await Geolocator.getCurrentPosition();
  return position;
}
```

**Apakah Anda mendapatkan koordinat GPS ketika run di browser? Mengapa demikian?**

**Jawaban:**

**Ya, bisa mendapatkan koordinat GPS di browser**, tetapi dengan beberapa catatan:

1. **Browser Modern Mendukung Geolocation API:**
   - Browser seperti Chrome, Firefox, Safari, dan Edge memiliki built-in Geolocation API
   - Package `geolocator` di Flutter web menggunakan HTML5 Geolocation API

2. **Perbedaan dengan Mobile:**
   - **Mobile (Android/iOS)**: Menggunakan GPS hardware langsung untuk akurasi tinggi
   - **Browser**: Menggunakan kombinasi:
     - **WiFi positioning**: Lokasi berdasarkan WiFi networks terdekat
     - **IP-based location**: Estimasi dari alamat IP
     - **GPS** (jika device memiliki GPS dan browser diberi izin)

3. **Akurasi Berbeda:**
   - **Mobile**: Akurasi tinggi (sampai beberapa meter) dengan GPS
   - **Browser**: Akurasi lebih rendah, biasanya 100-1000 meter tergantung method

4. **Permission Handling:**
   - Browser akan meminta permission popup dari user
   - User harus mengklik "Allow" untuk berbagi lokasi
   - Website harus diakses via HTTPS (kecuali localhost)

5. **Limitasi Browser:**
   - Tidak semua fitur `geolocator` didukung di web
   - Beberapa setting seperti accuracy mode mungkin tidak berfungsi optimal
   - Background location tracking tidak didukung

**Hasil Praktikum:**

![W11: Soal 12](./screenshots/soal12.gif)

*GIF menunjukkan loading animation selama 3 detik, kemudian menampilkan koordinat GPS*

**Kesimpulan:**
- ✅ Browser **bisa** mendapatkan koordinat GPS
- ⚠️ Akurasi **lebih rendah** dibanding mobile app
- 🔒 Memerlukan **HTTPS** dan **user permission**
- 📱 Untuk akurasi tinggi, lebih baik gunakan **native mobile app**

---

## Praktikum 7: Manajemen Future dengan FutureBuilder

### Langkah 1: Modifikasi method getPosition()
Buka file `geolocation.dart` kemudian ganti isi method dengan kode ini:

```dart
Future<Position> getPosition() async {
  await Geolocator.requestPermission();
  await Geolocator.isLocationServiceEnabled();
  await Future.delayed(const Duration(seconds: 3));
  Position position = await Geolocator.getCurrentPosition();
  return position;
}
```

### Langkah 2: Tambah variabel
Tambah variabel ini di class `_LocationScreenState`:

```dart
Future<Position>? position;
```

### Langkah 3: Tambah initState()
Tambah method ini dan set variabel position:

```dart
@override
void initState() {
  super.initState();
  position = getPosition();
}
```

### Langkah 4: Edit method build()
Ganti method build() dengan kode FutureBuilder:

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Current Location - Charel'),
    ),
    body: Center(
      child: FutureBuilder(
        future: position,
        builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Text(snapshot.data.toString());
          } else {
            return const Text('');
          }
        },
      ),
    ),
  );
}
```

#### <a id="soal-13"></a>Soal 13

[🔝 Kembali ke Daftar Isi](#-daftar-isi--navigasi-cepat) | [⬅️ Soal 12](#soal-12) | [➡️ Soal 14](#soal-14)

**Apakah ada perbedaan UI dengan praktikum sebelumnya? Mengapa demikian?**

**Jawaban:**

**Ya, ada perbedaan UI, tetapi fungsionalitas tetap sama.**

**Perbedaan yang Terlihat:**

| Aspek | Praktikum 6 (Manual) | Praktikum 7 (FutureBuilder) |
|-------|---------------------|---------------------------|
| **Button** | ✅ Ada tombol "Get Location" | ❌ Tidak ada tombol |
| **Manual Refresh** | ✅ Bisa refresh manual | ❌ Tidak bisa refresh |
| **Display** | Hanya koordinat | Full Position object |
| **State Management** | Manual dengan setState() | Otomatis oleh FutureBuilder |

**Mengapa Demikian?**

1. **FutureBuilder Lebih Otomatis:**
   - FutureBuilder mengelola state Future secara otomatis
   - Tidak perlu manual setState() untuk update UI
   - Widget rebuild otomatis saat Future selesai

2. **Kode Lebih Clean:**
   ```dart
   // Praktikum 6: Manual
   String myPosition = '';
   bool loading = false;
   setState(() { loading = true; });
   // ... manual handling ...
   
   // Praktikum 7: FutureBuilder
   Future<Position>? position;
   // FutureBuilder handles everything!
   ```

3. **Tampilan Data:**
   - **Praktikum 6**: Format custom `"Latitude: xx - Longitude: yy"`
   - **Praktikum 7**: Raw Position object toString()

4. **No Button Needed:**
   - Praktikum 6 butuh button untuk trigger getData
   - Praktikum 7 otomatis fetch di initState()
   - FutureBuilder langsung monitor Future state

**Keuntungan FutureBuilder:**
- ✅ **Reactive**: UI auto-update tanpa setState()
- ✅ **Clean**: Lebih sedikit boilerplate code
- ✅ **Efficient**: Built-in state management
- ✅ **Declarative**: Lebih mudah dibaca dan maintain

**Kekurangan:**
- ❌ Tidak ada refresh manual (bisa ditambahkan jika perlu)
- ❌ Display kurang user-friendly (bisa diformat ulang)

**Hasil Praktikum:**

![W11: Soal 13](./screenshots/soal13.gif)

*GIF menunjukkan loading animation 3 detik, kemudian menampilkan Position object menggunakan FutureBuilder*

### Langkah 5: Tambah handling error
Tambahkan kode berikut untuk menangani ketika terjadi error:

```dart
else if (snapshot.connectionState == ConnectionState.done) {
  if (snapshot.hasError) {
    return const Text('Something terrible happened!');
  }
  return Text(snapshot.data.toString());
}
```

**Kode lengkap FutureBuilder dengan error handling:**

```dart
FutureBuilder(
  future: position,
  builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Something terrible happened!');
      }
      return Text(snapshot.data.toString());
    } else {
      return const Text('');
    }
  },
)
```

#### <a id="soal-14"></a>Soal 14

[🔝 Kembali ke Daftar Isi](#-daftar-isi--navigasi-cepat) | [⬅️ Soal 13](#soal-13)

**Apakah ada perbedaan UI dengan langkah sebelumnya? Mengapa demikian?**

**Jawaban:**

**Secara visual, TIDAK ada perbedaan UI jika tidak terjadi error.**

**Mengapa Demikian?**

1. **Error Handling Bersifat Preventif:**
   - Code error handling hanya tampil **jika terjadi error**
   - Jika GPS berhasil, UI tetap sama dengan Langkah 4
   - Perbedaan hanya terlihat saat **ada masalah**

2. **Kondisi yang Memicu Error:**
   - ❌ Permission ditolak user
   - ❌ Location service dimatikan
   - ❌ Timeout saat mendapatkan lokasi
   - ❌ Device tidak support GPS

3. **Tanpa Error Handling (Langkah 4):**
   ```dart
   // Jika error terjadi, app bisa crash atau tampil blank
   return Text(snapshot.data.toString()); // Crash jika data null!
   ```

4. **Dengan Error Handling (Langkah 5):**
   ```dart
   if (snapshot.hasError) {
     return const Text('Something terrible happened!');
   }
   return Text(snapshot.data.toString()); // Aman, sudah di-check
   ```

**Comparison Table:**

| Kondisi | Tanpa Error Handling | Dengan Error Handling |
|---------|---------------------|----------------------|
| **GPS Berhasil** | Tampil koordinat ✅ | Tampil koordinat ✅ |
| **Permission Ditolak** | App crash/blank ❌ | "Something terrible happened!" ✅ |
| **Service Mati** | App crash/blank ❌ | "Something terrible happened!" ✅ |
| **Timeout** | App crash/blank ❌ | "Something terrible happened!" ✅ |

**Keuntungan Error Handling:**
- ✅ **App Tidak Crash**: Graceful degradation
- ✅ **User Feedback**: User tahu ada masalah
- ✅ **Better UX**: Informasi jelas daripada blank screen
- ✅ **Production Ready**: Siap untuk real-world scenarios

**Best Practice dengan FutureBuilder:**
```dart
if (snapshot.connectionState == ConnectionState.waiting) {
  return const CircularProgressIndicator(); // Loading state
} else if (snapshot.connectionState == ConnectionState.done) {
  if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}'); // Error state
  }
  return Text(snapshot.data.toString()); // Success state
} else {
  return const Text(''); // Initial state
}
```

**Kapan Error Bisa Terlihat?**
1. Tolak permission GPS saat prompt
2. Matikan Location service di device
3. Simulasi error dengan throw Exception di getPosition()
4. Testing di device tanpa GPS

**Hasil Praktikum:**

![W11: Soal 14](./screenshots/soal14.gif)

*GIF menunjukkan: (1) Normal case - tampil koordinat GPS, (2) Error case - tampil "Something terrible happened!" saat permission ditolak*

**Kesimpulan Praktikum 7:**
- 🎯 **FutureBuilder** adalah cara **reactive** dan **efficient** untuk manage Future + UI
- 🔄 **Auto-rebuild** tanpa perlu setState() manual
- 🛡️ **Error handling** built-in dengan snapshot.hasError
- 📊 **State management** otomatis: waiting → done → success/error
- ✨ Lebih **clean**, **declarative**, dan **production-ready**

---

## Praktikum 8: Navigation route dengan Future Function

### Langkah 1: Buat file baru navigation_first.dart
Buatlah file baru ini di project lib Anda.

### Langkah 2: Isi kode navigation_first.dart

```dart
import 'package:flutter/material.dart';
import 'navigation_second.dart';

class NavigationFirst extends StatefulWidget {
  const NavigationFirst({super.key});

  @override
  State<NavigationFirst> createState() => _NavigationFirstState();
}

class _NavigationFirstState extends State<NavigationFirst> {
  Color color = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigation First Screen - Charel'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Change Color'),
          onPressed: () {
            _navigateAndGetColor(context);
          },
        ),
      ),
    );
  }
}
```

#### <a id="soal-15"></a>Soal 15

[🔝 Kembali ke Daftar Isi](#-daftar-isi--navigasi-cepat) | [⬅️ Soal 14](#soal-14) | [➡️ Soal 16](#soal-16)

**Tambahkan nama panggilan Anda pada tiap properti title sebagai identitas pekerjaan Anda.**

**Jawaban:**

✅ **Sudah ditambahkan nama "Charel" pada semua title:**

```dart
// navigation_first.dart
appBar: AppBar(
  title: const Text('Navigation First Screen - Charel'),
),

// navigation_second.dart
appBar: AppBar(
  title: const Text('Navigation Second Screen - Charel'),
),
```

**Warna tema favorit yang dipilih:**

```dart
Color color = Colors.purple; // Warna awal: Purple

// Pilihan warna di NavigationSecond:
- Purple.shade700  // Warna favorit 1
- Teal.shade700    // Warna favorit 2
- Amber.shade700   // Warna favorit 3
```

**Penjelasan Kode:**

1. **State Variable `color`:**
   ```dart
   Color color = Colors.purple;
   ```
   - Menyimpan warna background yang dipilih
   - Default: Purple (warna favorit)
   - Akan di-update dari NavigationSecond

2. **Background Color:**
   ```dart
   backgroundColor: color,
   ```
   - Menggunakan variabel `color` untuk background Scaffold
   - Berubah dinamis saat user memilih warna baru

3. **Button Change Color:**
   ```dart
   ElevatedButton(
     child: const Text('Change Color'),
     onPressed: () {
       _navigateAndGetColor(context);
     },
   )
   ```
   - Tombol untuk membuka halaman kedua
   - Memanggil method `_navigateAndGetColor()`

### Langkah 3: Tambah method di class _NavigationFirstState

```dart
Future _navigateAndGetColor(BuildContext context) async {
  color = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NavigationSecond()),
      ) ??
      Colors.blue;
  setState(() {});
}
```

**Penjelasan Method:**

1. **Future Function:**
   - Method async yang mengembalikan Future
   - Menunggu hasil dari Navigator.push

2. **Navigator.push:**
   - Membuka NavigationSecond screen
   - Menunggu (await) hingga screen ditutup
   - Return value: Color yang dipilih user

3. **Null Coalescing (`??`):**
   ```dart
   color = await Navigator.push(...) ?? Colors.blue;
   ```
   - Jika user back tanpa pilih warna (null)
   - Gunakan Colors.blue sebagai default

4. **setState():**
   - Update UI dengan warna baru
   - Rebuild widget dengan background color baru

### Langkah 4: Buat file baru navigation_second.dart

### Langkah 5: Buat class NavigationSecond dengan StatefulWidget

```dart
import 'package:flutter/material.dart';

class NavigationSecond extends StatefulWidget {
  const NavigationSecond({super.key});

  @override
  State<NavigationSecond> createState() => _NavigationSecondState();
}

class _NavigationSecondState extends State<NavigationSecond> {
  @override
  Widget build(BuildContext context) {
    Color color;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Second Screen - Charel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Purple'),
              onPressed: () {
                color = Colors.purple.shade700;
                Navigator.pop(context, color);
              },
            ),
            ElevatedButton(
              child: const Text('Teal'),
              onPressed: () {
                color = Colors.teal.shade700;
                Navigator.pop(context, color);
              },
            ),
            ElevatedButton(
              child: const Text('Amber'),
              onPressed: () {
                color = Colors.amber.shade700;
                Navigator.pop(context, color);
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

**Penjelasan Kode:**

1. **Local Variable `color`:**
   ```dart
   Color color;
   ```
   - Temporary variable untuk menyimpan warna yang dipilih
   - Di-assign saat button diklik

2. **3 Color Buttons:**
   - **Purple Button**: `Colors.purple.shade700`
   - **Teal Button**: `Colors.teal.shade700`
   - **Amber Button**: `Colors.amber.shade700`

3. **Navigator.pop dengan Return Value:**
   ```dart
   Navigator.pop(context, color);
   ```
   - Menutup screen kedua
   - Mengirim `color` kembali ke screen pertama
   - Diterima oleh `await Navigator.push(...)` di NavigationFirst

4. **Column dengan spaceEvenly:**
   - Menyusun button secara vertikal
   - Jarak merata antar button

### Langkah 6: Edit main.dart

```dart
import 'navigation_first.dart';

// ...

home: const NavigationFirst(),
```

**Perubahan:**
- Import `navigation_first.dart`
- Ganti `home` dari `LocationScreen()` ke `NavigationFirst()`

### Langkah 7: Run

Lakukan run, jika terjadi error silakan diperbaiki.

#### <a id="soal-16"></a>Soal 16

[🔝 Kembali ke Daftar Isi](#-daftar-isi--navigasi-cepat) | [⬅️ Soal 15](#soal-15)

**Cobalah klik setiap button, apa yang terjadi? Mengapa demikian?**

**Jawaban:**

**Apa yang Terjadi:**

1. **Saat Klik "Change Color" di Screen Pertama:**
   - ✅ App membuka NavigationSecond screen
   - ✅ Animasi push transition (slide dari kanan)
   - ✅ Menampilkan 3 button: Purple, Teal, Amber
   - ⏳ Method `_navigateAndGetColor()` **menunggu** (await) user memilih warna

2. **Saat Klik Button Warna (Purple/Teal/Amber):**
   - ✅ Screen kedua **langsung tertutup** (pop animation)
   - ✅ Background screen pertama **berubah warna** sesuai pilihan
   - ✅ Warna tersimpan di variabel `color`
   - ✅ UI di-rebuild dengan setState()

3. **Saat Klik Back Button (Android) atau Swipe (iOS):**
   - ✅ Screen kedua tertutup
   - ⚠️ Warna screen pertama **tetap** (tidak berubah)
   - 💡 Return value = null → gunakan default `Colors.blue`

**Mengapa Demikian?**

**1. Future & Await Pattern:**
```dart
Future _navigateAndGetColor(BuildContext context) async {
  color = await Navigator.push(...) ?? Colors.blue;
  setState(() {});
}
```
- `await` membuat method **menunggu** hingga Navigator.push selesai
- Eksekusi **berhenti** di line await sampai screen kedua ditutup
- Setelah pop, await mendapat return value (Color)
- Baru kemudian eksekusi lanjut ke setState()

**2. Navigator.pop dengan Return Value:**
```dart
Navigator.pop(context, color); // Mengirim warna ke screen pertama
```
- `Navigator.pop()` bisa mengirim data kembali ke screen sebelumnya
- Parameter kedua = return value
- Diterima oleh `await Navigator.push(...)`

**3. Null Coalescing Operator (`??`):**
```dart
color = await Navigator.push(...) ?? Colors.blue;
```
- Jika user back tanpa klik button → return value = `null`
- Operator `??` memberikan fallback value = `Colors.blue`
- Mencegah error saat assign null ke Color variable

**Flow Execution:**

```
[Screen 1] Klik "Change Color"
     ↓
[_navigateAndGetColor] Navigator.push → await (TUNGGU)
     ↓
[Screen 2] Muncul dengan 3 button
     ↓
[User] Klik "Purple"
     ↓
[Screen 2] color = Colors.purple.shade700
     ↓
[Screen 2] Navigator.pop(context, color) → Kirim warna
     ↓
[Screen 1] await selesai, terima color
     ↓
[Screen 1] setState() → Rebuild dengan warna baru
     ↓
[Result] Background berubah jadi Purple!
```

**Comparison Table:**

| Action | Return Value | Warna Screen 1 |
|--------|--------------|----------------|
| **Klik Purple Button** | `Colors.purple.shade700` | 🟣 Purple |
| **Klik Teal Button** | `Colors.teal.shade700` | 🩵 Teal |
| **Klik Amber Button** | `Colors.amber.shade700` | 🟡 Amber |
| **Back tanpa klik** | `null` → `Colors.blue` | 🔵 Blue |

**Keuntungan Pattern Ini:**

1. ✅ **Clean Navigation Flow**:
   - Push screen baru → Tunggu hasil → Update UI
   - Tidak perlu callback atau global state

2. ✅ **Type-Safe Return Value**:
   - Navigator.push<Color> menjamin return type
   - Compiler check type safety

3. ✅ **Null Safety**:
   - Operator `??` handle case user back tanpa pilih
   - Selalu ada default value

4. ✅ **Reactive UI**:
   - setState() otomatis rebuild dengan data baru
   - User langsung lihat perubahan

**Use Cases dalam Real App:**
- 🎨 **Color Picker**: Pilih warna untuk theme/customization
- 📝 **Form Input**: Edit data di screen baru, return hasil
- 📸 **Image Picker**: Pilih gambar, return File/path
- 🗺️ **Location Picker**: Pilih lokasi di map, return coordinates
- 💳 **Payment Method**: Pilih metode pembayaran, return selection

**Hasil Praktikum:**

![W11: Soal 16](./screenshots/soal16.gif)

*GIF menunjukkan: (1) Klik "Change Color" → Screen kedua muncul, (2) Klik button Purple/Teal/Amber → Background screen pertama berubah warna, (3) Back tanpa klik → Warna jadi blue (default)*

**Kesimpulan Praktikum 8:**
- 🎯 **Future + Navigation** memungkinkan screen mengembalikan data
- 🔄 **await Navigator.push()** membuat code synchronous & mudah dibaca
- 📦 **Navigator.pop(context, value)** mengirim data kembali ke caller
- 🛡️ **Null coalescing** handle edge case user back tanpa input
- ✨ Pattern ini **essential** untuk user input flows di Flutter

---

## Praktikum 9: Memanfaatkan async/await dengan Widget Dialog

### Langkah 1: Buat file baru navigation_dialog.dart
Buat file dart baru di folder lib project Anda.

### Langkah 2: Isi kode navigation_dialog.dart

```dart
import 'package:flutter/material.dart';

class NavigationDialogScreen extends StatefulWidget {
  const NavigationDialogScreen({super.key});

  @override
  State<NavigationDialogScreen> createState() => _NavigationDialogScreenState();
}

class _NavigationDialogScreenState extends State<NavigationDialogScreen> {
  Color color = Colors.purple.shade700;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigation Dialog Screen - Charel'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Change Color'),
          onPressed: () {
            _showColorDialog(context);
          },
        ),
      ),
    );
  }
}
```

**Penjelasan Kode:**

1. **NavigationDialogScreen Widget:**
   - StatefulWidget untuk manage color state
   - Background color berubah berdasarkan pilihan user di dialog

2. **State Variable `color`:**
   ```dart
   Color color = Colors.purple.shade700;
   ```
   - Default color: Purple shade 700 (warna favorit)
   - Akan di-update dari AlertDialog

3. **Scaffold dengan Dynamic Background:**
   ```dart
   backgroundColor: color,
   ```
   - Background berubah sesuai state variable
   - Rebuild saat setState() dipanggil

4. **Button Change Color:**
   ```dart
   onPressed: () {
     _showColorDialog(context);
   }
   ```
   - Trigger method `_showColorDialog()`
   - Menampilkan AlertDialog

### Langkah 3: Tambah method async

```dart
_showColorDialog(BuildContext context) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text('Very important question'),
        content: const Text('Please choose a color'),
        actions: <Widget>[
          TextButton(
            child: const Text('Purple'),
            onPressed: () {
              color = Colors.purple.shade700;
              Navigator.pop(context, color);
            },
          ),
          TextButton(
            child: const Text('Teal'),
            onPressed: () {
              color = Colors.teal.shade700;
              Navigator.pop(context, color);
            },
          ),
          TextButton(
            child: const Text('Amber'),
            onPressed: () {
              color = Colors.amber.shade700;
              Navigator.pop(context, color);
            },
          ),
        ],
      );
    },
  );
  setState(() {});
}
```

**Penjelasan Method:**

1. **Async Method:**
   ```dart
   _showColorDialog(BuildContext context) async {
   ```
   - Method async untuk menunggu dialog selesai
   - Tidak return value (void)

2. **showDialog dengan await:**
   ```dart
   await showDialog(...)
   ```
   - Menampilkan AlertDialog
   - await membuat eksekusi menunggu hingga dialog ditutup
   - Baru lanjut ke setState() setelah dialog tertutup

3. **barrierDismissible: false:**
   ```dart
   barrierDismissible: false,
   ```
   - User **tidak bisa** close dialog dengan tap di luar dialog
   - **Harus** pilih salah satu button
   - Mencegah state inconsistency

4. **AlertDialog Widget:**
   - **title**: "Very important question"
   - **content**: "Please choose a color"
   - **actions**: 3 TextButton untuk pilihan warna

5. **TextButton Actions:**
   ```dart
   TextButton(
     child: const Text('Purple'),
     onPressed: () {
       color = Colors.purple.shade700;
       Navigator.pop(context, color);
     },
   )
   ```
   - Set state variable `color`
   - Close dialog dengan `Navigator.pop()`
   - Return color (opsional, tidak digunakan di praktikum ini)

6. **setState() Setelah Dialog:**
   ```dart
   setState(() {});
   ```
   - Dipanggil setelah await showDialog selesai
   - Rebuild UI dengan warna baru
   - Background berubah sesuai pilihan user

**3 Warna Favorit yang Dipilih:**
- 🟣 **Purple.shade700** - Warna favorit 1
- 🟢 **Teal.shade700** - Warna favorit 2
- 🟡 **Amber.shade700** - Warna favorit 3

### Langkah 4: Panggil method di ElevatedButton

✅ Sudah diimplementasikan di Langkah 2:

```dart
ElevatedButton(
  child: const Text('Change Color'),
  onPressed: () {
    _showColorDialog(context);
  },
)
```

### Langkah 5: Edit main.dart

```dart
import 'navigation_dialog.dart';

// ...

home: const NavigationDialogScreen(),
```

**Perubahan:**
- Import `navigation_dialog.dart`
- Ganti `home` dari `NavigationFirst()` ke `NavigationDialogScreen()`

### Langkah 6: Run

Coba ganti warna background dengan widget dialog tersebut. Jika terjadi error, silakan diperbaiki.

#### <a id="soal-17"></a>Soal 17

[🔝 Kembali ke Daftar Isi](#-daftar-isi--navigasi-cepat) | [⬅️ Soal 16](#soal-16)

**Cobalah klik setiap button, apa yang terjadi? Mengapa demikian?**

**Jawaban:**

**Apa yang Terjadi:**

1. **Saat Klik "Change Color" Button:**
   - ✅ AlertDialog muncul dengan animasi fade-in
   - ✅ Background gelap (modal barrier)
   - ✅ Dialog menampilkan:
     - Title: "Very important question"
     - Content: "Please choose a color"
     - 3 button: Purple, Teal, Amber
   - ⏸️ Method `_showColorDialog()` **berhenti** di await (menunggu)

2. **Saat Klik Button Purple/Teal/Amber:**
   - ✅ State variable `color` di-update dengan warna yang dipilih
   - ✅ `Navigator.pop()` menutup dialog
   - ✅ await selesai, eksekusi lanjut ke `setState()`
   - ✅ UI rebuild dengan background warna baru
   - ✅ Dialog hilang dengan animasi fade-out

3. **Saat Klik Back Button (Hardware) atau Swipe:**
   - ❌ **TIDAK BISA** close dialog
   - 🔒 `barrierDismissible: false` mencegah dismiss
   - ⚠️ User **harus** pilih salah satu warna

4. **Saat Tap di Luar Dialog (Barrier):**
   - ❌ **TIDAK BISA** close dialog
   - 🔒 `barrierDismissible: false` aktif
   - ⚠️ User **wajib** membuat pilihan

**Mengapa Demikian?**

**1. Async/Await Pattern dengan Dialog:**
```dart
_showColorDialog(BuildContext context) async {
  await showDialog(...);
  setState(() {});  // Dipanggil SETELAH dialog tertutup
}
```

**Execution Flow:**
```
[1] User klik "Change Color"
     ↓
[2] _showColorDialog() dipanggil
     ↓
[3] await showDialog(...) → TUNGGU (eksekusi PAUSE)
     ↓
[4] Dialog muncul, user lihat 3 pilihan
     ↓
[5] User klik "Purple"
     ↓
[6] color = Colors.purple.shade700 (update state variable)
     ↓
[7] Navigator.pop(context, color) → Close dialog
     ↓
[8] await selesai, eksekusi LANJUT
     ↓
[9] setState(() {}) → Rebuild UI
     ↓
[10] Background berubah jadi Purple!
```

**2. barrierDismissible: false**

**Kenapa pakai false?**
- ✅ **Force User Choice**: User harus pilih warna, tidak bisa skip
- ✅ **Prevent Null State**: Mencegah state variable tidak terupdate
- ✅ **Better UX**: Jelas bahwa pilihan wajib dibuat
- ✅ **No Accidental Dismiss**: Tap tidak sengaja tidak close dialog

**Comparison:**

| barrierDismissible | Tap Luar Dialog | Back Button | Use Case |
|--------------------|-----------------|-------------|----------|
| **true** (default) | ✅ Close | ✅ Close | Optional actions |
| **false** | ❌ No effect | ❌ No effect | **Required actions** |

**3. State Update Pattern:**

```dart
// SALAH: setState() sebelum dialog
_showColorDialog(BuildContext context) async {
  setState(() {}); // Rebuild terlalu cepat, warna belum berubah!
  await showDialog(...);
}

// BENAR: setState() setelah dialog
_showColorDialog(BuildContext context) async {
  await showDialog(...); // Tunggu user pilih warna
  setState(() {});       // Baru rebuild dengan warna baru
}
```

**4. Perbedaan dengan Navigator.push (Praktikum 8):**

| Aspek | Navigator.push (P8) | showDialog (P9) |
|-------|---------------------|------------------|
| **Widget** | Full screen baru | Overlay dialog |
| **Animation** | Slide transition | Fade in/out |
| **Barrier** | Tidak ada | Ada (gelap) |
| **Back Stack** | Ditambah ke stack | Tidak di stack |
| **Dismiss** | Back button works | Controlled |
| **Use Case** | Multi-step flow | Quick selection |

**5. Kenapa color di-assign di dalam onPressed?**

```dart
TextButton(
  onPressed: () {
    color = Colors.purple.shade700; // Update state
    Navigator.pop(context, color);   // Close dialog
  },
)
```

- State variable di-update **sebelum** pop
- Saat dialog tertutup, variabel sudah berisi warna baru
- `setState()` setelah await akan rebuild dengan warna baru

**Flow Diagram Detail:**

```
┌─────────────────────────┐
│   NavigationDialog      │
│   (Purple background)   │
│                         │
│  [Change Color Button]  │ ← User klik
└─────────────────────────┘
            ↓
   _showColorDialog() called
            ↓
   await showDialog(...) ← PAUSE
            ↓
┌─────────────────────────┐
│   AlertDialog Overlay   │
│  ┌───────────────────┐  │
│  │ Very important..  │  │
│  │ Choose a color    │  │
│  │                   │  │
│  │ [Purple] [Teal]   │  │ ← User klik Purple
│  │      [Amber]      │  │
│  └───────────────────┘  │
└─────────────────────────┘
            ↓
   color = Colors.purple.shade700
            ↓
   Navigator.pop(context, color)
            ↓
   Dialog closed
            ↓
   await RESUME
            ↓
   setState(() {})
            ↓
┌─────────────────────────┐
│   NavigationDialog      │
│ (🟣 Purple background!) │ ← Warna berubah!
│                         │
│  [Change Color Button]  │
└─────────────────────────┘
```

**Real-World Use Cases:**

1. **Confirmation Dialogs:**
   ```dart
   // Delete confirmation
   await showDialog(
     barrierDismissible: false, // User harus pilih
     builder: (_) => AlertDialog(
       title: Text('Delete Item?'),
       actions: [
         TextButton('Cancel', ...),
         TextButton('Delete', ...),
       ],
     ),
   );
   ```

2. **Input Dialogs:**
   - User settings selection
   - Sort order selection
   - Filter options

3. **Action Sheets:**
   - Save/Delete/Cancel
   - Share options
   - Export formats

4. **Warning Dialogs:**
   - Unsaved changes
   - Network errors
   - Permission requests

**Keuntungan Pattern Ini:**

- ✅ **Modal Context**: User fokus pada pilihan
- ✅ **Clean Code**: async/await lebih readable
- ✅ **Forced Decision**: barrierDismissible: false
- ✅ **No State Complexity**: Simple setState() after dialog
- ✅ **Reusable**: AlertDialog bisa dipanggil dari mana saja
- ✅ **Flexible**: Bisa return value dengan Navigator.pop()

**Perbandingan dengan Praktikum Sebelumnya:**

| Praktikum | Widget | Trigger | Return | Complexity |
|-----------|--------|---------|--------|-----------|
| **P8** | Full Screen | Button | await Navigator.push | Medium |
| **P9** | AlertDialog | Button | await showDialog | **Low** |

**Hasil Praktikum:**

![W11: Soal 17](./screenshots/soal17.gif)

*GIF menunjukkan: (1) Klik "Change Color" → AlertDialog muncul, (2) Klik button Purple/Teal/Amber → Background berubah warna, (3) Tap di luar dialog tidak menutup dialog (barrierDismissible: false)*

**Kesimpulan Praktikum 9:**
- 🎯 **AlertDialog** perfect untuk quick selections & confirmations
- ⏸️ **await showDialog()** membuat code wait hingga user memilih
- 🔒 **barrierDismissible: false** memaksa user membuat pilihan
- 🔄 **setState() after await** memastikan UI update dengan data terbaru
- ✨ Pattern ini **essential** untuk user confirmations & quick inputs
- 📱 Lebih **lightweight** dibanding full screen navigation
- 🎨 Cocok untuk **focused interactions** tanpa context switching
