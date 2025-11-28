# Laporan Praktikum Week 12 - Streams

**Nama:** Charel  
**NIM:** 2341720205 
**Kelas:** 3I

---

## Daftar Isi
- [Praktikum 1: Dart Streams](#praktikum-1-dart-streams)
- [Praktikum 2: Stream Controllers dan Sinks](#praktikum-2-stream-controllers-dan-sinks)
- [Praktikum 3: Injeksi Data ke Streams](#praktikum-3-injeksi-data-ke-streams)
- [Praktikum 4: Subscribe ke Stream Events](#praktikum-4-subscribe-ke-stream-events)
- [Praktikum 5: Multiple Stream Subscriptions](#praktikum-5-multiple-stream-subscriptions)
- [Praktikum 6: StreamBuilder](#praktikum-6-streambuilder)
- [Praktikum 7: BLoC Pattern](#praktikum-7-bloc-pattern)

---

## Praktikum 1: Dart Streams

### Soal 1
**Langkah 2: Buka file main.dart**

- Menambahkan nama panggilan pada title app: "Stream Charel"
- Mengubah warna tema aplikasi menjadi `Colors.deepPurple`

**Code:**
```dart
return MaterialApp(
  title: 'Stream Charel',
  theme: ThemeData(
    primarySwatch: Colors.deepPurple,
  ),
  home: const StreamHomePage(),
);
```

**Screenshot:**

<details>
![Screenshot Soal 1](docs/praktikum1/soal1.png)

</details>

---

### Soal 2
**Langkah 4: Tambah variabel colors**

Menambahkan 5 warna lainnya pada variabel `colors` di class `ColorStream`:

**Code:**
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
1. Mengemit nilai secara periodik setiap 1 detik
2. Parameter `t` adalah counter yang dimulai dari 0 dan bertambah setiap periodik
3. `t % colors.length` menghitung sisa bagi untuk mendapatkan index yang berputar
4. Mengembalikan warna dari list `colors` berdasarkan index tersebut
5. Hasilnya adalah Stream yang mengemit warna secara bergantian setiap detik

---

### Soal 4
**Langkah 12: Run - Background berubah warna setiap detik**

**Screenshot:**

![Screenshot Soal 4](docs/praktikum1/soal4.png)

---

### Soal 5
**Langkah 13: Perbedaan `listen` dan `await for`**

**Perbedaan:**

| Aspek | `listen` | `await for` |
|-------|----------|-------------|
| **Eksekusi** | Non-blocking, method selesai langsung setelah subscribe | Blocking, method akan terus berjalan selama stream aktif |
| **Control** | Lebih fleksibel dengan callback (onDone, onError, cancelOnError) | Lebih sederhana, linear seperti loop biasa |
| **Subscription** | Mengembalikan StreamSubscription yang bisa di-cancel | Tidak ada kontrol langsung terhadap subscription |
| **Use Case** | Cocok untuk multiple listeners atau perlu kontrol subscription | Cocok untuk sequential processing yang sederhana |

**Kesimpulan:** Pada praktikum ini, `listen` lebih cocok karena method dapat selesai dieksekusi dan Stream tetap berjalan di background.

---

## Praktikum 2: Stream Controllers dan Sinks

### Soal 6
**Langkah 8 dan 10: StreamController dan addRandomNumber**

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

**Maksud:** Membuat StreamController, subscribe ke stream, dan update UI setiap ada event baru. Error handling menset nilai -1.

**Penjelasan Langkah 10 (addRandomNumber):**

```dart
void addRandomNumber() {
  Random random = Random();
  int myNum = random.nextInt(10);
  numberStream.addNumberToSink(myNum);
}
```

**Maksud:** Generate angka random 0-9 dan masukkan ke sink stream saat button ditekan.

**Screenshot:**

![Screenshot Soal 6](docs/praktikum2/soal6.png)


---

### Soal 7
**Langkah 13-15: Error Handling**

**Penjelasan:**

**Langkah 13** - Method `addError()`: Menambahkan error ke stream untuk testing.

**Langkah 14** - `onError` handler: Menangani error dengan set `lastNumber = -1`.

**Langkah 15** - Testing error: Comment `addNumberToSink()` dan ganti dengan `addError()` untuk test bahwa error handling berfungsi.

**Kesimpulan:** Kode dikembalikan seperti semula (addError di-comment) untuk lanjut ke praktikum berikutnya.

---

## Praktikum 3: Injeksi Data ke Streams

### Soal 8
**Langkah 1-3: StreamTransformer**

**Penjelasan:**

StreamTransformer digunakan untuk memodifikasi data yang mengalir di stream sebelum sampai ke listener.

```dart
transformer = StreamTransformer<int, int>.fromHandlers(
  handleData: (value, sink) {
    sink.add(value * 10);  // Kalikan 10
  },
  handleError: (error, trace, sink) {
    sink.add(-1);
  },
  handleDone: (sink) => sink.close(),
);
```

**Flow Data:**
```
Random Number (0-9) → Stream → Transformer (×10) → Output (0-90)
```

**Contoh:** Input 5 → Transform → Output 50

**Screenshot:**

![Screenshot Soal 8](docs/praktikum3/soal8.png)


---

## Praktikum 4: Subscribe ke Stream Events

### Soal 9
**Langkah 2, 6, dan 8: StreamSubscription Management**

**Penjelasan Langkah 2 (initState dengan subscription):**

Menyimpan hasil listen ke variabel `subscription` untuk kontrol penuh (cancel, pause, resume). Menambahkan `onDone` handler yang dipanggil saat stream ditutup.

**Penjelasan Langkah 6 (dispose):**

```dart
@override
void dispose() {
  subscription.cancel();  // Mencegah memory leak
  numberStreamController.close();
  super.dispose();
}
```

Best practice untuk cleanup resource saat widget di-dispose.

**Penjelasan Langkah 8 (check stream status):**

```dart
if (!numberStreamController.isClosed) {
  numberStream.addNumberToSink(myNum);
} else {
  setState(() {
    lastNumber = -1;
  });
}
```

Mengecek status stream sebelum add data untuk mencegah error.

**Screenshot:**

![Screenshot Soal 9](docs/praktikum4/soal9.png)


---

## Praktikum 5: Multiple Stream Subscriptions

### Soal 10
**Error pada Multiple Subscriptions**

**Penjelasan Error:**

Ketika mencoba membuat dua subscription pada stream yang sama, muncul error:

```
Bad state: Stream has already been listened to.
```

**Mengapa?**

1. **Single-subscription stream**: Default StreamController hanya bisa memiliki satu listener
2. **Design limitation**: Mencegah race conditions dan memastikan data consistency
3. **Solusi**: Gunakan `.asBroadcastStream()` untuk multiple listeners

---

### Soal 11
**Broadcast Stream - Angka Muncul 2 Kali**

**Penjelasan:**

```dart
Stream stream = numberStreamController.stream.asBroadcastStream();

subscription = stream.transform(transformer).listen((event) {
  setState(() {
    values += '$event - ';  // Tambah pertama
  });
});

subscription2 = stream.transform(transformer).listen((event) {
  setState(() {
    values += '$event - ';  // Tambah kedua
  });
});
```

**Mengapa angka muncul 2x?**

Karena ada 2 listeners aktif. Setiap event diterima oleh KEDUA subscription, sehingga angka ditambahkan 2 kali ke string `values`.

**Contoh:** Random 5 → Transform 50 → values = "50 - 50 - "

**Screenshot:**

![Screenshot Soal 10-11](docs/praktikum5/soal10-11.png)


---

## Praktikum 6: StreamBuilder

### Soal 12
**Langkah 3 dan 7: StreamBuilder Widget**

**Penjelasan Langkah 3 (getNumbers di stream.dart):**

```dart
Stream<int> getNumbers() async* {
  yield* Stream.periodic(const Duration(seconds: 1), (int t) {
    Random random = Random();
    int myNum = random.nextInt(10);
    return myNum;
  });
}
```

**Maksud:**
- `async*`: Generator function yang return Stream
- `yield*`: Meneruskan semua nilai dari Stream.periodic
- `Stream.periodic`: Emit angka random setiap 1 detik
- Membuat stream infinite yang terus generate angka

**Penjelasan Langkah 7 (StreamBuilder):**

```dart
StreamBuilder(
  stream: numberStream,
  initialData: 0,
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      print('Error!');
    }
    if (snapshot.hasData) {
      return Center(
        child: Text(
          snapshot.data.toString(),
          style: const TextStyle(fontSize: 96),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  },
)
```

**Keuntungan StreamBuilder:**
-  Otomatis manage subscription lifecycle
-  Otomatis rebuild UI saat ada data baru
-  Tidak perlu manual setState()
-  Tidak perlu manual dispose()

**Screenshot:**

![Screenshot Soal 12](docs/praktikum6/soal12.png)


---

## Praktikum 7: BLoC Pattern

### Soal 13
**Maksud Praktikum dan Konsep BLoC**

**Maksud Praktikum:**

Praktikum ini mengajarkan implementasi **BLoC (Business Logic Component) Pattern** untuk memisahkan logika bisnis dari UI. BLoC menggunakan Streams untuk mengelola state dan event dalam aplikasi Flutter.

**Letak Konsep Pola BLoC:**

1. **Separation of Concerns** (random_bloc.dart):
   ```dart
   class RandomNumberBloc {
     // Input Stream (Events)
     final _generateRandomController = StreamController<void>();
     Sink<void> get generateRandom => _generateRandomController.sink;
     
     // Output Stream (States)
     final _randomNumberController = StreamController<int>();
     Stream<int> get randomNumber => _randomNumberController.stream;
     
     // Business Logic
     RandomNumberBloc() {
       _generateRandomController.stream.listen((_) {
         final random = Random().nextInt(10);
         _randomNumberController.sink.add(random);
       });
     }
   }
   ```

2. **Event → BLoC → State Flow:**
   ```
   UI Event (Button Click)
         ↓
   Sink Input (generateRandom.add(null))
         ↓
   BLoC Logic (generate random number)
         ↓
   Sink Output (randomNumber stream)
         ↓
   StreamBuilder (Auto rebuild UI)
   ```

3. **UI Layer** (random_screen.dart):
   ```dart
   FloatingActionButton(
     onPressed: () => _bloc.generateRandom.add(null), // Kirim event
     child: const Icon(Icons.refresh),
   )
   
   StreamBuilder<int>(
     stream: _bloc.randomNumber,  // Terima state
     builder: (context, snapshot) {
       return Text('Random Number: ${snapshot.data}');
     },
   )
   ```

**Konsep BLoC:**

| Komponen | Fungsi | Lokasi di Code |
|----------|--------|----------------|
| **Events** | Input dari UI | `generateRandom.add(null)` |
| **Sink** | Channel untuk input | `_generateRandomController.sink` |
| **Business Logic** | Proses data | `listen()` di constructor |
| **Stream** | Channel untuk output | `_randomNumberController.stream` |
| **State** | Output ke UI | `snapshot.data` |

**Keuntungan BLoC Pattern:**
-  **Separation**: UI terpisah dari logic
-  **Testability**: BLoC bisa ditest tanpa UI
-  **Reusability**: BLoC bisa dipakai di berbagai widget
-  **Maintainability**: Kode lebih terstruktur dan mudah dimaintain

**Screenshot:**

![Screenshot Soal 13](docs/praktikum7/soal13.png)


