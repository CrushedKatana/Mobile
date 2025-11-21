# stream_charel

Nama: Charel  
NIM: [NIM Anda]  
Kelas: [Kelas Anda]

---

## Praktikum 1: Dart Streams

### Soal 1
**Langkah 2: Buka file main.dart**

- Menambahkan nama panggilan pada title app: "Stream Charel"
- Mengubah warna tema aplikasi menjadi `Colors.deepPurple`

**Screenshot:**
![Screenshot Soal 1](docs/soal1.png)

**Code main.dart:**
```dart
return MaterialApp(
  title: 'Stream Charel',
  theme: ThemeData(
    primarySwatch: Colors.deepPurple,
  ),
  home: const StreamHomePage(),
);
```

---

### Soal 2
**Langkah 4: Tambah variabel colors**

Menambahkan 5 warna lainnya pada variabel `colors` di class `ColorStream`:

**Code stream.dart:**
```dart
final List<Color> colors = [
  Colors.blueGrey,
  Colors.amber,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.teal,
  Colors.red,      // Warna tambahan 1
  Colors.orange,   // Warna tambahan 2
  Colors.pink,     // Warna tambahan 3
  Colors.indigo,   // Warna tambahan 4
  Colors.green,    // Warna tambahan 5
];
```

---

### Soal 3
**Langkah 6: Tambah perintah yield***

**Penjelasan fungsi keyword `yield*`:**

Keyword `yield*` digunakan untuk mendelegasikan atau meneruskan seluruh nilai dari Stream lain. Dalam konteks ini, `yield*` meneruskan semua event/data dari `Stream.periodic` ke Stream yang dikembalikan oleh method `getColors()`.

**Maksud isi perintah kode:**

```dart
yield* Stream.periodic(
  const Duration(seconds: 1), (int t) {
    int index = t % colors.length;
    return colors[index];
});
```

Kode ini membuat Stream yang:
1. Mengemit nilai secara periodik setiap 1 detik (`Duration(seconds: 1)`)
2. Parameter `t` adalah counter yang dimulai dari 0 dan bertambah setiap periodik
3. `t % colors.length` menghitung sisa bagi untuk mendapatkan index yang berputar (0 sampai panjang array colors - 1)
4. Mengembalikan warna dari list `colors` berdasarkan index tersebut
5. Hasilnya adalah Stream yang mengemit warna secara bergantian setiap detik

---

### Soal 4
**Langkah 12: Run**

Aplikasi berhasil dijalankan dan background berubah warna setiap detik.

**Screenshot/GIF:**
![GIF Running App](docs/soal4.gif)

Aplikasi menampilkan perubahan warna background secara otomatis setiap 1 detik dengan warna yang berputar dari list colors.

---

### Soal 5
**Langkah 13: Ganti isi method changeColor()**

**Perbedaan menggunakan `listen` dan `await for`:**

**Menggunakan `listen` (Langkah 13):**
```dart
void changeColor() async {
  colorStream.getColors().listen((eventColor) {
    setState(() {
      bgColor = eventColor;
    });
  });
}
```

**Menggunakan `await for` (Langkah 9):**
```dart
void changeColor() async {
  await for (var eventColor in colorStream.getColors()) {
    setState(() {
      bgColor = eventColor;
    });
  }
}
```

**Perbedaan:**

| Aspek | `listen` | `await for` |
|-------|----------|-------------|
| **Eksekusi** | Non-blocking, method selesai langsung setelah subscribe | Blocking, method akan terus berjalan selama stream aktif |
| **Control** | Lebih fleksibel dengan callback (onDone, onError, cancelOnError) | Lebih sederhana, linear seperti loop biasa |
| **Subscription** | Mengembalikan StreamSubscription yang bisa di-cancel | Tidak ada kontrol langsung terhadap subscription |
| **Use Case** | Cocok untuk multiple listeners atau perlu kontrol subscription | Cocok untuk sequential processing yang sederhana |

Pada praktikum ini, `listen` lebih cocok karena method `changeColor()` dapat selesai dieksekusi dan Stream tetap berjalan di background, sedangkan `await for` akan membuat method terus berjalan dan blocking.

---

## Praktikum 2: Stream controllers dan sinks

### Soal 6
**Langkah 8 dan 10**

**Penjelasan Langkah 8 (initState):**

```dart
@override
void initState() {
  super.initState();
  numberStream = NumberStream();
  numberStreamController = numberStream.controller;
  Stream stream = numberStreamController.stream;
  stream.listen((event) {
    setState(() {
      lastNumber = event;
    });
  }).onError((error) {
    setState(() {
      lastNumber = -1;
    });
  });
}
```

**Maksud kode:**
- `numberStream = NumberStream()`: Membuat instance dari NumberStream
- `numberStreamController = numberStream.controller`: Mengambil StreamController dari NumberStream
- `Stream stream = numberStreamController.stream`: Mengambil stream dari controller
- `stream.listen()`: Subscribe/mendengarkan event yang datang dari stream
- Setiap ada event baru, nilai `lastNumber` diupdate dengan `setState()`
- `.onError()`: Menangani error yang terjadi pada stream, jika ada error maka `lastNumber` diset -1

**Penjelasan Langkah 10 (addRandomNumber):**

```dart
void addRandomNumber() {
  Random random = Random();
  int myNum = random.nextInt(10);
  numberStream.addNumberToSink(myNum);
}
```

**Maksud kode:**
- `Random random = Random()`: Membuat instance Random untuk generate angka acak
- `int myNum = random.nextInt(10)`: Generate angka random dari 0-9
- `numberStream.addNumberToSink(myNum)`: Mengirim/memasukkan angka random ke dalam sink stream
- Method ini dipanggil saat button ditekan untuk menambahkan angka baru ke stream

**Screenshot:**
![Screenshot Soal 6](docs/soal6.png)

---

### Soal 7
**Langkah 13-15: Error Handling**

**Penjelasan Langkah 13 (Method addError di stream.dart):**

```dart
addError() {
  controller.sink.addError('error');
}
```

**Maksud kode:**
- Method `addError()` digunakan untuk menambahkan error ke dalam stream
- `controller.sink.addError('error')` mengirim error dengan pesan 'error' ke stream
- Berguna untuk testing error handling pada stream

**Penjelasan Langkah 14 (onError di initState):**

```dart
stream.listen((event) {
  setState(() {
    lastNumber = event;
  });
}).onError((error) {
  setState(() {
    lastNumber = -1;
  });
});
```

**Maksud kode:**
- `.onError()` adalah callback yang akan dijalankan ketika ada error di stream
- Ketika terjadi error, `lastNumber` diset menjadi -1 sebagai indikator error
- Ini memungkinkan aplikasi untuk menangani error dengan graceful tanpa crash

**Penjelasan Langkah 15 (Edit addRandomNumber):**

```dart
void addRandomNumber() {
  Random random = Random();
  int myNum = random.nextInt(10);
  // numberStream.addNumberToSink(myNum);
  numberStream.addError();
}
```

**Maksud kode:**
- Kode `addNumberToSink()` di-comment
- Diganti dengan `addError()` untuk testing error handling
- Saat button ditekan, akan trigger error dan `lastNumber` akan menjadi -1
- Ini membuktikan bahwa error handling berfungsi dengan baik

**Catatan:** Kode telah dikembalikan seperti semula (addError di-comment) agar bisa lanjut ke praktikum 3.

---

## Praktikum 3: Injeksi data ke streams

### Soal 8
**Langkah 1-3: StreamTransformer**

**Penjelasan Langkah 1 (Tambah variabel transformer):**

```dart
late StreamTransformer transformer;
```

**Maksud kode:**
- Mendeklarasikan variabel `transformer` dengan tipe `StreamTransformer`
- `late` berarti variabel akan diinisialisasi nanti sebelum digunakan
- StreamTransformer digunakan untuk memodifikasi/mentransformasi data yang mengalir di stream

**Penjelasan Langkah 2 (Buat StreamTransformer di initState):**

```dart
transformer = StreamTransformer<int, int>.fromHandlers(
  handleData: (value, sink) {
    sink.add(value * 10);
  },
  handleError: (error, trace, sink) {
    sink.add(-1);
  },
  handleDone: (sink) => sink.close(),
);
```

**Maksud kode:**
- `StreamTransformer<int, int>.fromHandlers`: Membuat transformer yang menerima input int dan output int
- `handleData`: Handler untuk memproses data normal
  - `value * 10`: Setiap angka yang masuk dikalikan 10
  - `sink.add()`: Mengirim hasil transformasi ke output stream
- `handleError`: Handler untuk menangani error
  - Jika ada error, kirim nilai -1
- `handleDone`: Handler ketika stream selesai
  - Menutup sink

**Penjelasan Langkah 3 (Edit initState dengan transform):**

```dart
stream.transform(transformer).listen((event) {
  setState(() {
    lastNumber = event;
  });
}).onError((error) {
  setState(() {
    lastNumber = -1;
  });
});
```

**Maksud kode:**
- `stream.transform(transformer)`: Menerapkan transformer ke stream
- Data dari stream akan melewati transformer sebelum sampai ke listener
- Flow: Random Number (0-9) → Stream → **Transformer (×10)** → Listener → UI
- Hasilnya: Angka yang ditampilkan adalah 0, 10, 20, 30, 40, 50, 60, 70, 80, atau 90

**Contoh alur:**
1. User klik button
2. Generate random number, misal: 5
3. Masuk ke stream → transformer mengalikan 10 → hasil: 50
4. Listener menerima 50 → setState() → UI menampilkan **50**

**Screenshot:**
![Screenshot Soal 8](docs/soal8.png)

---

## Praktikum 4: Subscribe ke stream events

### Soal 9
**Langkah 2, 6, dan 8**

**Penjelasan Langkah 2 (Edit initState):**

```dart
@override
void initState() {
  super.initState();
  numberStream = NumberStream();
  numberStreamController = numberStream.controller;
  Stream stream = numberStreamController.stream;
  
  transformer = StreamTransformer<int, int>.fromHandlers(
    handleData: (value, sink) {
      sink.add(value * 10);
    },
    handleError: (error, trace, sink) {
      sink.add(-1);
    },
    handleDone: (sink) => sink.close(),
  );
  
  subscription = stream.transform(transformer).listen((event) {
    setState(() {
      lastNumber = event;
    });
  });
  
  subscription.onError((error) {
    setState(() {
      lastNumber = -1;
    });
  });
  
  subscription.onDone(() {
    print('OnDone was called');
  });
}
```

**Maksud kode:**
- **`subscription = stream.transform(transformer).listen(...)`**: Menyimpan hasil listen ke variabel subscription bertipe `StreamSubscription`. Ini memungkinkan kita untuk mengontrol subscription (pause, resume, cancel).
- **`subscription.onError(...)`**: Mendaftarkan error handler pada subscription. Berbeda dengan sebelumnya yang menggunakan chaining `.onError()`, sekarang dipanggil sebagai method terpisah dari subscription object.
- **`subscription.onDone(...)`**: Mendaftarkan callback yang akan dipanggil ketika stream selesai/ditutup. Menampilkan pesan "OnDone was called" di console saat stream ditutup.
- Dengan pola ini, kita memiliki kontrol penuh terhadap subscription untuk melakukan operasi seperti cancel, pause, atau resume.

**Penjelasan Langkah 6 (Edit dispose):**

```dart
@override
void dispose() {
  subscription.cancel();
  numberStreamController.close();
  super.dispose();
}

void stopStream() {
  numberStreamController.close();
}
```

**Maksud kode:**
- **`subscription.cancel()`**: Membatalkan subscription sebelum widget di-dispose. Ini adalah best practice untuk mencegah memory leak.
- **`numberStreamController.close()`**: Menutup stream controller untuk membersihkan resource.
- **`stopStream()`**: Method baru untuk menutup stream controller secara manual ketika user menekan tombol "Stop Subscription".
- Pattern ini memastikan tidak ada listener yang masih berjalan setelah widget dihapus, mencegah error dan memory leak.

**Penjelasan Langkah 8 (Edit addRandomNumber):**

```dart
void addRandomNumber() {
  Random random = Random();
  int myNum = random.nextInt(10);
  if (!numberStreamController.isClosed) {
    numberStream.addNumberToSink(myNum);
  } else {
    setState(() {
      lastNumber = -1;
    });
  }
}
```

**Maksud kode:**
- **`if (!numberStreamController.isClosed)`**: Mengecek apakah stream controller masih terbuka sebelum menambahkan data.
- Jika stream masih terbuka: tambahkan angka random ke sink seperti biasa.
- Jika stream sudah ditutup: set `lastNumber` menjadi -1 sebagai indikator bahwa stream sudah tidak aktif.
- Ini mencegah error saat mencoba menambahkan data ke stream yang sudah ditutup.
- Best practice untuk menangani state management pada stream yang bisa ditutup secara dinamis.

**Alur Kerja:**
1. User klik "New Random Number" → generate angka → cek stream status → update UI
2. User klik "Stop Subscription" → close stream → trigger onDone callback → print message
3. User klik "New Random Number" lagi → stream closed → tampilkan -1

**Screenshot:**
![Screenshot Soal 9](docs/soal9.png)

---

## Praktikum 5: Multiple stream subscriptions

### Soal 10
**Langkah 1-3: Error pada multiple subscriptions**

**Penjelasan Error:**

Ketika kita mencoba membuat dua subscription pada stream yang sama:

```dart
subscription = stream.transform(transformer).listen((event) {
  setState(() {
    lastNumber = event;
  });
});

subscription2 = stream.transform(transformer).listen((event) {
  setState(() {
    values += '$event - ';
  });
});
```

Akan muncul error:

```
Bad state: Stream has already been listened to.
```

**Mengapa error ini terjadi?**

1. **Single-subscription stream**: Secara default, StreamController membuat single-subscription stream yang hanya bisa memiliki satu listener/subscriber pada satu waktu.

2. **Pembatasan design**: Ini adalah pembatasan desain dari Dart streams untuk mencegah race conditions dan memastikan data consistency.

3. **Subscription pertama**: Ketika `subscription` dibuat, stream sudah di-listen.

4. **Subscription kedua**: Saat mencoba membuat `subscription2`, stream mendeteksi sudah ada listener sebelumnya dan throw error.

**Solusi:** Menggunakan broadcast stream yang mendukung multiple listeners.

---

### Soal 11
**Langkah 4-6: Broadcast Stream**

**Penjelasan mengapa angka bertambah dua kali:**

**Kode setelah menggunakan broadcast stream:**

```dart
Stream stream = numberStreamController.stream.asBroadcastStream();

subscription = stream.transform(transformer).listen((event) {
  setState(() {
    lastNumber = event;
    values += '$event - ';
  });
});

subscription2 = stream.transform(transformer).listen((event) {
  setState(() {
    values += '$event - ';
  });
});
```

**Mengapa angka muncul 2 kali?**

1. **Broadcast Stream**: Method `.asBroadcastStream()` mengubah single-subscription stream menjadi broadcast stream yang mendukung multiple listeners.

2. **Dua Subscriptions Aktif**:
   - `subscription`: Menambahkan nilai ke `values` (pertama kali)
   - `subscription2`: Menambahkan nilai yang sama ke `values` (kedua kali)

3. **Kedua listener dipanggil**: Ketika satu event (angka) dikirim ke stream, SEMUA listener yang terdaftar akan menerima event yang sama.

4. **Alur eksekusi**:
   ```
   Button Click → Generate Random (misal: 5)
        ↓
   Add to Sink → Stream emit value
        ↓
   Transform (5 × 10 = 50)
        ↓
   ├─ Subscription 1 → values += '50 - '  (values = "50 - ")
   └─ Subscription 2 → values += '50 - '  (values = "50 - 50 - ")
   ```

5. **Hasil akhir**: Setiap kali button diklik, angka yang sama ditambahkan 2 kali ke string `values` karena ada 2 listeners.

**Contoh Output:**
- Klik 1: Random 3 → Transform 30 → values = "30 - 30 - "
- Klik 2: Random 7 → Transform 70 → values = "30 - 30 - 70 - 70 - "
- Klik 3: Random 2 → Transform 20 → values = "30 - 30 - 70 - 70 - 20 - 20 - "

**Screenshot:**
![Screenshot Soal 10 dan 11](docs/soal10-11.png)

---

## Praktikum 6: StreamBuilder

**Catatan:** Praktikum 6 dikerjakan di project terpisah: `streambuilder_charel`

Lihat dokumentasi lengkap di: [streambuilder_charel/README.md](../streambuilder_charel/README.md)

**Konsep StreamBuilder:**
- Widget untuk listen stream secara deklaratif
- Otomatis rebuild UI saat ada data baru
- Tidak perlu manual subscription management
- Handle lifecycle secara otomatis

---

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

