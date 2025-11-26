# store_data_nama

Praktikum Week 13 - Konversi Dart Model ke JSON

## Identitas
- **Nama**: Nama (ganti dengan nama Anda)
- **NIM**: NIM Anda
- **Kelas**: Kelas Anda

## Praktikum 1: Konversi Dart model ke JSON

### Soal 1
**Pertanyaan**: Tambahkan nama panggilan Anda pada title app sebagai identitas hasil pekerjaan Anda. Gantilah warna tema aplikasi sesuai kesukaan Anda.

**Jawaban**:
- Saya telah menambahkan nama "Nama" pada title aplikasi
- Mengubah warna tema dari `Colors.deepPurple` menjadi `Colors.teal`
- Perubahan dilakukan di file `main.dart` pada class `MyApp`:
  ```dart
  return MaterialApp(
    title: 'Store Data Nama',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      useMaterial3: true,
    ),
    home: const MyHomePage(title: 'Store Data Nama'),
  );
  ```

**Commit**: W13: Jawaban Soal 1

---

### Soal 2
**Pertanyaan**: Masukkan hasil capture layar ke laporan praktikum Anda.

**Jawaban**:
Pada langkah ini, aplikasi berhasil membaca file `pizzalist.json` dan menampilkan isi JSON sebagai string dalam ListView. 

**Hasil yang ditampilkan**:
- JSON berhasil dibaca dari file `assets/pizzalist.json`
- Data ditampilkan sebagai string mentah dalam aplikasi
- Method `readJsonFile()` menggunakan `rootBundle.loadString()` untuk membaca file
- Data JSON ditampilkan menggunakan widget `ListView` dengan `Text(pizzaString)`

**Screenshot**: _(Jalankan aplikasi pada tahap ini untuk mendapatkan screenshot)_

**Commit**: W13: Jawaban Soal 2

---

### Soal 3
**Pertanyaan**: Masukkan hasil capture layar ke laporan praktikum Anda.

**Jawaban**:
Pada langkah ini, aplikasi berhasil mengkonversi data JSON menjadi objek Dart (List<Pizza>) dan menampilkannya dalam ListView yang lebih terstruktur.

**Implementasi yang dilakukan**:
1. **Membuat class Pizza** (`lib/model/pizza.dart`) dengan:
   - Properties: id, pizzaName, description, price, imageUrl
   - Constructor `fromJson()` untuk deserialization (JSON → Object)
   - Method `toJson()` untuk serialization (Object → JSON)

2. **Update main.dart**:
   - Mengubah variabel state dari `String pizzaString` menjadi `List<Pizza> myPizzas`
   - Method `readJsonFile()` sekarang mengembalikan `Future<List<Pizza>>`
   - Menggunakan `jsonDecode()` untuk parse JSON string
   - Mengonversi Map menjadi objek Pizza dengan `Pizza.fromJson()`
   - Menampilkan data menggunakan `ListView.builder`

3. **Serialization ke JSON**:
   - Menambahkan method `convertToJSON()` yang menggunakan `jsonEncode()`
   - Mencetak hasil konversi kembali ke JSON di console
   - Output JSON di Debug Console menunjukkan objek berhasil dikonversi

**Hasil yang ditampilkan**:
- ListView menampilkan 5 pizza dengan format terstruktur
- Setiap item menampilkan:
  - **Title**: Nama pizza (pizzaName)
  - **Subtitle**: Deskripsi pizza (description)
- Data JSON berhasil di-decode menjadi List objek Pizza
- Objek Pizza berhasil di-encode kembali menjadi JSON string (terlihat di Debug Console)

**Screenshot**: _(Jalankan aplikasi untuk mendapatkan screenshot ListView dengan data pizza)_

**Output Console**:
```json
[{"id":1,"pizzaName":"Margherita","description":"Pizza with tomato, fresh mozzarella and basil","price":8.75,"imageUrl":"images/margherita.png"},{"id":2,"pizzaName":"Marinara","description":"Pizza with tomato, garlic and oregano","price":7.5,"imageUrl":"images/marinara.png"},{"id":3,"pizzaName":"Napoli","description":"Pizza with tomato, garlic and anchovies","price":9.5,"imageUrl":"images/marinara.png"},{"id":4,"pizzaName":"Carciofi","description":"Pizza with tomato, fresh mozzarella and artichokes","price":8.8,"imageUrl":"images/marinara.png"},{"id":5,"pizzaName":"Bufala","description":"Pizza with tomato, buffalo mozzarella and basil","price":12.5,"imageUrl":"images/marinara.png"}]
```

**Commit**: W13: Jawaban Soal 3

---

## Kesimpulan

Praktikum ini berhasil mendemonstrasikan:
1. **Deserialization**: Konversi JSON → Dart Object menggunakan `fromJson()`
2. **Serialization**: Konversi Dart Object → JSON menggunakan `toJson()`
3. **Penggunaan `dart:convert`**: Untuk `jsonDecode()` dan `jsonEncode()`
4. **Async programming**: Menggunakan `Future`, `async/await`, dan `.then()`
5. **State management**: Update state dengan data dari async operation
6. **ListView.builder**: Menampilkan list data secara efisien

## Struktur Project

```
lib/
├── main.dart           # Main application dengan MyApp dan MyHomePage
└── model/
    └── pizza.dart      # Model class Pizza dengan fromJson() dan toJson()

assets/
└── pizzalist.json      # Data JSON untuk list pizza
```

## Cara Menjalankan

1. Clone repository
2. Masuk ke direktori project:
   ```bash
   cd week13/store_data_nama
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Jalankan aplikasi:
   ```bash
   flutter run
   ```

## Dependencies

- Flutter SDK
- dart:convert (built-in)
- flutter/services.dart (untuk rootBundle)

