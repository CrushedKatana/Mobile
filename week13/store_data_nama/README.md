# store_data_nama

Praktikum Week 13 - Konversi Dart Model ke JSON

## Identitas
- **Nama**: Charel
- **NIM**: NIM Anda
- **Kelas**: Kelas Anda

## Praktikum 1: Konversi Dart model ke JSON

### Soal 1
**Pertanyaan**: Tambahkan nama panggilan Anda pada title app sebagai identitas hasil pekerjaan Anda. Gantilah warna tema aplikasi sesuai kesukaan Anda.

**Jawaban**:
- Saya telah menambahkan nama "Charel" pada title aplikasi
- Mengubah warna tema dari `Colors.deepPurple` menjadi `Colors.teal`
- Menambahkan FloatingActionButton dengan icon kamera untuk memudahkan proses screenshot
- Perubahan dilakukan di file `main.dart` pada class `MyApp`:
  ```dart
  return MaterialApp(
    title: 'Store Data Charel',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      useMaterial3: true,
    ),
    home: const MyHomePage(title: 'Store Data Charel'),
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

---

## Praktikum 2: Handle kompatibilitas data JSON

### Soal 4
**Pertanyaan**: Capture hasil running aplikasi Anda, kemudian impor ke laporan praktikum Anda!

**Jawaban**:
Pada Praktikum 2, aplikasi telah ditingkatkan untuk menangani data JSON yang tidak konsisten atau "rusak" dengan baik.

**Masalah yang Ditangani**:

1. **Tipe Data Tidak Konsisten**:
   - ID bisa berupa String (`"1"`) atau int (`1`)
   - Price bisa berupa String (`"7.50"`) atau double (`7.50`)

2. **Nilai Null atau Missing Field**:
   - Beberapa field mungkin null (seperti `pizzaName`, `description`, `imageUrl`)
   - Beberapa field mungkin tidak ada dalam JSON

3. **Tipe Data Salah**:
   - pizzaName bisa berupa number (12345) padahal seharusnya String

**Implementasi Solusi**:

**1. Update Pizza.fromJson() dengan Error Handling**:
```dart
factory Pizza.fromJson(Map<String, dynamic> json) {
  return Pizza(
    id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
    pizzaName: (json['pizzaName'] ?? 'No name').toString(),
    description: (json['description'] ?? '').toString(),
    price: double.tryParse(json['price']?.toString() ?? '0') ?? 0,
    imageUrl: (json['imageUrl'] ?? '').toString(),
  );
}
```

**Penjelasan**:
- **`int.tryParse()`**: Mencoba parsing String ke int, return null jika gagal
- **`double.tryParse()`**: Mencoba parsing String ke double, return null jika gagal
- **`?.toString()`**: Safe navigation operator, konversi ke String jika tidak null
- **`?? defaultValue`**: Null coalescing, berikan nilai default jika null
- **`toString()`**: Pastikan semua nilai String benar-benar String

**2. Update ListView dengan Ternary Operator**:
```dart
ListView.builder(
  itemCount: myPizzas.length,
  itemBuilder: (context, index) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('${index + 1}'),
      ),
      title: Text(
        myPizzas[index].pizzaName.isNotEmpty
            ? myPizzas[index].pizzaName
            : 'No name',
      ),
      subtitle: Text(
        myPizzas[index].description.isNotEmpty
            ? myPizzas[index].description
            : 'No description',
      ),
      trailing: Text(
        '\$${myPizzas[index].price.toStringAsFixed(2)}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  },
)
```

**Penjelasan**:
- Menggunakan **ternary operator** (`condition ? true : false`) untuk menampilkan nilai default
- Jika `pizzaName` kosong → tampilkan "No name"
- Jika `description` kosong → tampilkan "No description"
- Price selalu ditampilkan dengan format 2 desimal

**3. Data JSON yang Tidak Konsisten (pizzalist_broken.json)**:
```json
[
  { 
    "id": "1",              // String instead of int
    "pizzaName": "Margherita",
    "description": "Pizza with tomato, fresh mozzarella and basil",
    "price": 8.75,
    "imageUrl": "images/margherita.png"
  },
  { 
    "id": 2,
    "pizzaName": "Marinara",
    "price": "7.50",        // String instead of double
    "imageUrl": "images/marinara.png"
    // Missing description
  },
  { 
    "id": "3",
    "pizzaName": null,      // Null value
    "description": "Pizza with tomato, garlic and anchovies",
    "price": 9.50
    // Missing imageUrl
  },
  { 
    "id": 4,
    "description": "Pizza with tomato, fresh mozzarella and artichokes",
    "price": "8.80",
    "imageUrl": "images/marinara.png"
    // Missing pizzaName
  },
  { 
    "id": "5",
    "pizzaName": 12345,     // Number instead of String
    "description": null,    // Null value
    "price": "12.50",
    "imageUrl": null        // Null value
  }
]
```

**Hasil yang ditampilkan**:
- Aplikasi berjalan tanpa error meskipun data tidak konsisten
- Semua field yang null atau missing ditangani dengan graceful degradation
- UI menampilkan nilai default yang user-friendly:
  - "No name" untuk pizzaName yang null/missing
  - "No description" untuk description yang null/missing
  - "\$0.00" untuk price yang gagal di-parse
- FloatingActionButton dengan icon kamera memudahkan proses screenshot

**Screenshot**: _(Klik tombol kamera untuk memudahkan screenshot)_

**Output Console** (JSON Serialization):
Aplikasi masih bisa mengkonversi kembali objek Pizza ke JSON string dengan benar:
```json
[{"id":1,"pizzaName":"Margherita","description":"Pizza with tomato, fresh mozzarella and basil","price":8.75,"imageUrl":"images/margherita.png"},{"id":2,"pizzaName":"Marinara","description":"No description","price":7.5,"imageUrl":"images/marinara.png"},{"id":3,"pizzaName":"No name","description":"Pizza with tomato, garlic and anchovies","price":9.5,"imageUrl":""},{"id":4,"pizzaName":"No name","description":"Pizza with tomato, fresh mozzarella and artichokes","price":8.8,"imageUrl":"images/marinara.png"},{"id":5,"pizzaName":"12345","description":"","price":12.5,"imageUrl":""}]
```

**Commit**: W13: Jawaban Soal 4

---

## Praktikum 3: Menangani error JSON

### Soal 5
**Pertanyaan**: Jelaskan maksud kode lebih safe dan maintainable!

**Jawaban**:

Pada Praktikum 3, kita menggunakan **konstanta** untuk mengganti string literals kunci JSON. Ini membuat kode lebih **safe** dan **maintainable**.

#### **Implementasi Konstanta untuk Kunci JSON**:

**Sebelum (menggunakan string literals)**:
```dart
factory Pizza.fromJson(Map<String, dynamic> json) {
  return Pizza(
    id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
    pizzaName: (json['pizzaName'] ?? 'No name').toString(),
    description: (json['description'] ?? '').toString(),
    // ... dst
  );
}

Map<String, dynamic> toJson() {
  return {
    'id': id,
    'pizzaName': pizzaName,
    'description': description,
    // ... dst
  };
}
```

**Sesudah (menggunakan konstanta)**:
```dart
// Konstanta di luar class Pizza
const String keyId = 'id';
const String keyPizzaName = 'pizzaName';
const String keyDescription = 'description';
const String keyPrice = 'price';
const String keyImageUrl = 'imageUrl';

class Pizza {
  // ...
  
  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: int.tryParse(json[keyId]?.toString() ?? '0') ?? 0,
      pizzaName: (json[keyPizzaName] ?? 'No name').toString(),
      description: (json[keyDescription] ?? '').toString(),
      price: double.tryParse(json[keyPrice]?.toString() ?? '0') ?? 0,
      imageUrl: (json[keyImageUrl] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      keyId: id,
      keyPizzaName: pizzaName,
      keyDescription: description,
      keyPrice: price,
      keyImageUrl: imageUrl,
    };
  }
}
```

#### **Mengapa Lebih SAFE (Aman)?**

1. **Compile-time Error Detection**:
   - **String literals**: Jika salah ketik `'pizzaName'` menjadi `'pizaName'` → tidak ada error saat compile, error baru muncul saat runtime
   - **Konstanta**: Jika salah ketik `keyPizzaName` menjadi `keyPizaName` → **compile error** langsung muncul (undefined variable)

2. **Typo Prevention (Mencegah Kesalahan Ketik)**:
   ```dart
   // BAHAYA - Tidak ada error meskipun salah ketik!
   json['pizzaName']  // Benar ✓
   json['pizaName']   // Salah ketik, tapi tidak ada compile error! ✗
   
   // AMAN - Langsung error jika salah ketik
   json[keyPizzaName]  // Benar ✓
   json[keyPizaName]   // Compile error: Undefined name 'keyPizaName' ✓
   ```

3. **IDE Support & Auto-complete**:
   - Dengan konstanta, IDE akan memberikan **auto-complete** dan **IntelliSense**
   - Mengurangi kemungkinan typo karena bisa memilih dari dropdown suggestion

4. **Type Safety**:
   - Konstanta memastikan kunci yang digunakan konsisten di seluruh aplikasi
   - Jika salah, error terdeteksi saat development, bukan saat production

#### **Mengapa Lebih MAINTAINABLE (Mudah Dipelihara)?**

1. **Single Source of Truth**:
   - Jika nama kunci di API berubah dari `'pizzaName'` → `'name'`
   -  **String literals**: Harus cari dan ganti di **semua tempat** (fromJson, toJson, dan tempat lain)
   -  **Konstanta**: Cukup ubah **1 tempat** saja:
   ```dart
   const String keyPizzaName = 'name';  // Ubah di sini saja!
   ```

2. **Easy Refactoring**:
   - Dengan konstanta, IDE bisa **Find All References**
   - Gampang track dimana saja konstanta digunakan
   - Refactoring lebih aman karena semua penggunaan terdeteksi

3. **Consistency (Konsistensi)**:
   - Semua developer di team menggunakan konstanta yang sama
   - Tidak ada variasi penamaan seperti `'pizzaName'`, `'pizza_name'`, `'PizzaName'`
   - Standarisasi kode lebih terjaga

4. **Reusability**:
   - Konstanta bisa digunakan di berbagai tempat (fromJson, toJson, validation, dll)
   - DRY principle: Don't Repeat Yourself

5. **Documentation & Readability**:
   - Konstanta berfungsi sebagai dokumentasi kunci JSON yang digunakan
   - Mudah melihat semua kunci JSON yang tersedia hanya dengan melihat deklarasi konstanta
   - Code lebih self-documenting

#### **Contoh Skenario Real-World**:

**Scenario 1: API Change**
```dart
// API berubah dari 'pizzaName' ke 'name'

// Dengan String Literals (SUSAH):
// Harus cari di 10+ file, ganti manual satu-satu
json['pizzaName'] → json['name']  // Di fromJson
'pizzaName': name → 'name': name  // Di toJson
// Risk: Ketinggalan 1 tempat → BUG!

// Dengan Konstanta (MUDAH):
const String keyPizzaName = 'name';  // Ubah 1 baris, semua terupdate!
```

**Scenario 2: Code Review**
```dart
// Reviewer mudah catch error:

// String Literals - Susah detect typo:
json['description']  // Benar
json['descriptin']   // Typo! Tapi sulit dilihat saat code review

// Konstanta - Error jelas terlihat:
json[keyDescription]  // Benar
json[keyDescriptin]   // IDE langsung merah, reviewer langsung tahu error
```

#### **Perbandingan Impact**:

| Aspek | String Literals | Konstanta |
|-------|----------------|-----------||
| **Compile-time Error** | Tidak ada | Ada |
| **IDE Auto-complete** | Tidak ada | Ada |
| **Find & Replace** | Manual, risky | Otomatis, safe |
| **Typo Detection** | Runtime error | Compile error |
| **Refactoring** | Sulit | Mudah |
| **Team Consistency** | Bervariasi | Konsisten |
| **Maintenance Time** | Lama | Cepat |

#### **Best Practice**:
- Gunakan konstanta untuk semua kunci JSON
- Deklarasikan konstanta di satu tempat (top of file atau separate constants file)
- Gunakan naming convention yang jelas (contoh: `key` prefix)
- Group related constants together

**Screenshot**: _(Klik tombol kamera untuk screenshot - aplikasi tetap berjalan normal, tidak ada perubahan visual)_

**Commit**: W13: Jawaban Soal 5

---

## Praktikum 4: SharedPreferences

### Soal 6
**Pertanyaan**: Capture hasil praktikum Anda berupa GIF dan lampirkan di README.

**Jawaban**:

Pada Praktikum 4, kita mengimplementasikan **SharedPreferences** untuk menyimpan data sederhana secara persisten (data tetap ada meskipun aplikasi ditutup).

#### **Implementasi SharedPreferences**:

**1. Tambah Dependency**:
```yaml
dependencies:
  shared_preferences: ^2.5.3
```

**2. Import Package**:
```dart
import 'package:shared_preferences/shared_preferences.dart';
```

**3. Deklarasi Variabel Counter**:
```dart
class _MyHomePageState extends State<MyHomePage> {
  List<Pizza> myPizzas = [];
  int appCounter = 0;  // Counter untuk tracking berapa kali app dibuka
  // ...
}
```

**4. Method readAndWritePreference()**:
```dart
Future<void> readAndWritePreference() async {
  // Dapatkan instance SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Baca nilai dari storage, default 0 jika belum ada
  appCounter = prefs.getInt('appCounter') ?? 0;
  
  // Increment counter
  appCounter++;
  
  // Simpan nilai baru ke storage
  await prefs.setInt('appCounter', appCounter);
  
  // Update UI
  setState(() {
    appCounter = appCounter;
  });
}
```

**5. Method deletePreference()**:
```dart
Future<void> deletePreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Hapus semua data di SharedPreferences
  await prefs.clear();
  
  // Reset counter di UI
  setState(() {
    appCounter = 0;
  });
}
```

**6. Panggil di initState()**:
```dart
@override
void initState() {
  super.initState();
  readAndWritePreference();  // Baca dan update counter saat app dibuka
  readJsonFile().then((value) {
    setState(() {
      myPizzas = value;
    });
  });
}
```

**7. Update UI**:
```dart
body: Column(
  children: [
    Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.teal.shade50,
      child: Column(
        children: [
          Text(
            'You have opened the app $appCounter times',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: deletePreference,
            child: const Text('Reset counter'),
          ),
        ],
      ),
    ),
    Expanded(
      child: ListView.builder(...),  // Pizza list
    ),
  ],
),
```

#### **Cara Kerja SharedPreferences**:

1. **Persistent Storage**:
   - Data disimpan di device storage (bukan memory)
   - Data tetap ada meskipun aplikasi ditutup atau di-restart
   - Data akan hilang jika aplikasi di-uninstall

2. **Key-Value Storage**:
   - Data disimpan dalam format key-value pairs
   - Key: `'appCounter'` (String)
   - Value: `appCounter` (int)

3. **Async Operations**:
   - Semua operasi SharedPreferences adalah asynchronous
   - Harus menggunakan `await` untuk mendapatkan hasil
   - Method harus ditandai dengan `async`

4. **Type-Specific Methods**:
   - `setInt()`, `getInt()` untuk integer
   - `setString()`, `getString()` untuk string
   - `setBool()`, `getBool()` untuk boolean
   - `setDouble()`, `getDouble()` untuk double
   - `setStringList()`, `getStringList()` untuk list of strings

#### **Skenario Penggunaan**:

**Pertama kali app dibuka**:
```
1. readAndWritePreference() dipanggil
2. prefs.getInt('appCounter') returns null (belum ada data)
3. Dengan ?? 0, appCounter = 0
4. appCounter++ → appCounter = 1
5. prefs.setInt('appCounter', 1) → simpan ke storage
6. UI menampilkan: "You have opened the app 1 times"
```

**Kedua kali app dibuka**:
```
1. readAndWritePreference() dipanggil
2. prefs.getInt('appCounter') returns 1 (dari storage)
3. appCounter = 1
4. appCounter++ → appCounter = 2
5. prefs.setInt('appCounter', 2) → update storage
6. UI menampilkan: "You have opened the app 2 times"
```

**Saat tombol Reset ditekan**:
```
1. deletePreference() dipanggil
2. prefs.clear() → hapus semua data
3. appCounter = 0
4. UI menampilkan: "You have opened the app 0 times"
5. Next time app dibuka, counter mulai dari 1 lagi
```

#### **Hasil yang Ditampilkan**:

**UI Components**:
1. **Counter Display**: 
   - Box dengan background teal menampilkan counter
   - Format: "You have opened the app X times"
   
2. **Reset Button**:
   - Tombol merah untuk reset counter
   - Memanggil `deletePreference()` saat diklik
   
3. **Pizza List**:
   - ListView tetap menampilkan data pizza di bawah counter
   - Data pizza tidak terpengaruh oleh reset counter

**Testing Steps**:
1. Run aplikasi pertama kali → Counter = 1
2. Close dan run lagi → Counter = 2
3. Close dan run lagi → Counter = 3
4. Tekan "Reset counter" → Counter = 0
5. Close dan run lagi → Counter = 1 (mulai dari awal)

#### **Keuntungan SharedPreferences**:

1. **Simple & Easy**: API yang mudah digunakan untuk simple data
2. **Persistent**: Data tidak hilang saat app ditutup
3. **Fast**: Read/write operation sangat cepat
4. **No Setup Required**: Tidak perlu database setup
5. **Cross-Platform**: Bekerja di Android, iOS, Web, Desktop

#### **Limitations & Best Practices**:

**Limitations**:
- Hanya untuk data sederhana (primitives & string list)
- Tidak cocok untuk data besar atau kompleks
- Tidak encrypted by default
- Tidak untuk sensitive data (password, token, dll)

**Best Practices**:
- Gunakan untuk settings, preferences, small flags
- Jangan simpan data sensitif
- Untuk data kompleks, gunakan database (SQLite, Hive, dll)
- Untuk secure data, gunakan flutter_secure_storage
- Gunakan konstanta untuk keys (seperti di Praktikum 3)

**Screenshot/GIF**: (Jalankan aplikasi, buka beberapa kali untuk melihat counter increment, lalu tekan Reset)

**Commit**: W13: Jawaban Soal 6

---

## Praktikum 5: Akses filesystem dengan path_provider

### Soal 7
**Pertanyaan**: Capture hasil praktikum Anda dan lampirkan di README.

**Jawaban**:

Pada Praktikum 5, kita mengimplementasikan **path_provider** untuk mengakses direktori sistem file pada perangkat. Package ini memungkinkan kita mendapatkan path ke direktori documents dan temporary.

#### **Implementasi path_provider**:

**1. Tambah Dependency**:
```yaml
dependencies:
  path_provider: ^2.1.5
```

**2. Import Package**:
```dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';
```

**3. Deklarasi Variabel untuk Menyimpan Paths**:
```dart
class _MyHomePageState extends State<MyHomePage> {
  List<Pizza> myPizzas = [];
  int appCounter = 0;
  String documentsPath = '';  // Path ke documents directory
  String tempPath = '';       // Path ke temporary directory
  // ...
}
```

**4. Method getPaths()**:
```dart
Future<void> getPaths() async {
  // Dapatkan directory documents
  final Directory documentsDir = await getApplicationDocumentsDirectory();
  
  // Dapatkan directory temporary
  final Directory tempDir = await getTemporaryDirectory();
  
  // Update state dengan path yang didapat
  setState(() {
    documentsPath = documentsDir.path;
    tempPath = tempDir.path;
  });
}
```

**5. Panggil di initState()**:
```dart
@override
void initState() {
  super.initState();
  readAndWritePreference();
  getPaths();  // Panggil untuk mendapatkan paths
  readJsonFile().then((value) {
    setState(() {
      myPizzas = value;
    });
  });
}
```

**6. Update UI untuk Menampilkan Paths**:
```dart
Container(
  padding: const EdgeInsets.all(16.0),
  color: Colors.blue.shade50,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'File System Paths:',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 120,
            child: Text(
              'Documents:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(documentsPath, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 120,
            child: Text(
              'Temporary:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(tempPath, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ],
  ),
),
```

#### **Penjelasan Direktori**:

**1. Documents Directory (`getApplicationDocumentsDirectory()`)**:
- **Purpose**: Untuk menyimpan file yang dibuat oleh user atau app
- **Persistence**: Data persisten, tidak akan dihapus oleh sistem
- **Backup**: Di-backup saat user backup device
- **Accessibility**: Hanya accessible oleh aplikasi ini
- **Use Cases**:
  - User documents
  - Database files
  - Downloaded files
  - User-generated content

**Platform-specific paths**:
- Android: `/data/user/0/com.example.app/app_flutter`
- iOS: `<Application_Home>/Documents`
- Windows: `C:\Users\<username>\AppData\Roaming\<app_name>`
- macOS: `~/Library/Containers/<app_name>/Data/Documents`

**2. Temporary Directory (`getTemporaryDirectory()`)**:
- **Purpose**: Untuk menyimpan file temporary/cache
- **Persistence**: Bisa dihapus kapan saja oleh sistem
- **Backup**: Tidak di-backup
- **Accessibility**: Hanya accessible oleh aplikasi ini
- **Use Cases**:
  - Cache files
  - Temporary downloads
  - Image thumbnails
  - Processing temporary files

**Platform-specific paths**:
- Android: `/data/user/0/com.example.app/cache`
- iOS: `<Application_Home>/Library/Caches`
- Windows: `C:\Users\<username>\AppData\Local\Temp\<app_name>`
- macOS: `~/Library/Caches/<app_name>`

#### **Direktori Lain yang Tersedia**:

```dart
// External storage (Android only)
Directory? externalDir = await getExternalStorageDirectory();

// Support directory untuk app files
Directory supportDir = await getApplicationSupportDirectory();

// Downloads directory
Directory? downloadsDir = await getDownloadsDirectory();
```

#### **Cara Kerja path_provider**:

1. **Platform Detection**:
   - Package secara otomatis mendeteksi platform (Android, iOS, Web, Desktop)
   - Mengembalikan path yang sesuai dengan platform

2. **Async Operation**:
   - Semua method adalah asynchronous
   - Perlu menggunakan `await` atau `.then()`
   - Method harus ditandai dengan `async`

3. **Directory Object**:
   - Mengembalikan objek `Directory` dari `dart:io`
   - Bisa akses property `.path` untuk mendapat String path
   - Bisa operasi file/directory langsung

#### **Contoh Penggunaan dalam Real App**:

**Menyimpan File ke Documents**:
```dart
Future<void> writeFile(String content) async {
  final Directory documentsDir = await getApplicationDocumentsDirectory();
  final File file = File('${documentsDir.path}/myfile.txt');
  await file.writeAsString(content);
}
```

**Membaca File dari Documents**:
```dart
Future<String> readFile() async {
  final Directory documentsDir = await getApplicationDocumentsDirectory();
  final File file = File('${documentsDir.path}/myfile.txt');
  return await file.readAsString();
}
```

**Clear Cache (Temporary Directory)**:
```dart
Future<void> clearCache() async {
  final Directory tempDir = await getTemporaryDirectory();
  if (tempDir.existsSync()) {
    tempDir.deleteSync(recursive: true);
  }
}
```

#### **Hasil yang Ditampilkan**:

**UI Components**:
1. **Counter Section** (Teal background):
   - Menampilkan SharedPreferences counter
   - Button reset counter

2. **File System Paths Section** (Blue background):
   - Label "File System Paths:"
   - Documents path dengan label "Documents:"
   - Temporary path dengan label "Temporary:"
   - Path ditampilkan dalam font kecil agar muat

3. **Pizza List Section**:
   - ListView dengan data pizza
   - Tidak terpengaruh oleh path_provider

**Example Output Paths**:
```
Documents: /data/user/0/com.example.store_data_nama/app_flutter
Temporary: /data/user/0/com.example.store_data_nama/cache
```

#### **Best Practices**:

1. **Pilih Directory yang Tepat**:
   - Documents: untuk data penting user
   - Temporary: untuk cache yang bisa dihapus
   - Application Support: untuk app data internal

2. **Error Handling**:
   - Selalu handle kemungkinan error saat akses file system
   - Check apakah directory exists sebelum operasi

3. **Clean Up**:
   - Periodic cleanup temporary directory
   - Jangan simpan data besar di temp directory

4. **Permissions**:
   - Android: Tidak perlu permission untuk app-specific directories
   - External storage perlu permission di AndroidManifest.xml

5. **Testing**:
   - Test di berbagai platform (Android, iOS, dll)
   - Pastikan path sesuai dengan platform

**Screenshot**: (Jalankan aplikasi untuk melihat paths yang ditampilkan sesuai platform Anda)

**Commit**: W13: Jawaban Soal 7

---

## Kesimpulan

### Praktikum 1 - Deserialization & Serialization:
1. **Deserialization**: Konversi JSON → Dart Object menggunakan `fromJson()`
2. **Serialization**: Konversi Dart Object → JSON menggunakan `toJson()`
3. **Penggunaan `dart:convert`**: Untuk `jsonDecode()` dan `jsonEncode()`
4. **Async programming**: Menggunakan `Future`, `async/await`, dan `.then()`
5. **State management**: Update state dengan data dari async operation
6. **ListView.builder**: Menampilkan list data secara efisien

### Praktikum 2 - Error Handling & Data Validation:
1. **Type Safety**: Menggunakan `tryParse()` untuk konversi tipe data yang aman
2. **Null Safety**: Menggunakan null coalescing operator (`??`) untuk handle null values
3. **Safe Navigation**: Menggunakan `?.` operator untuk akses property yang mungkin null
4. **Type Conversion**: Menggunakan `toString()` untuk memastikan tipe data String
5. **User-Friendly UI**: Menggunakan ternary operator untuk tampilan yang lebih baik
6. **Graceful Degradation**: Aplikasi tetap berjalan meskipun data tidak sempurna

### Praktikum 3 - JSON Error Prevention dengan Konstanta:
1. **String Constants**: Menggunakan konstanta untuk kunci JSON menggantikan string literals
2. **Compile-time Safety**: Error typo terdeteksi saat compile, bukan runtime
3. **Single Source of Truth**: Perubahan kunci JSON hanya perlu dilakukan di satu tempat
4. **IDE Support**: Auto-complete dan IntelliSense untuk mengurangi error
5. **Easy Maintenance**: Refactoring lebih mudah dan aman
6. **Code Consistency**: Standarisasi penamaan kunci JSON di seluruh aplikasi

### Praktikum 4 - Persistent Storage dengan SharedPreferences:
1. **Simple Data Persistence**: Menyimpan data sederhana yang persisten
2. **Key-Value Storage**: Format penyimpanan yang simple dan efisien
3. **Async Operations**: Operasi asynchronous untuk read/write data
4. **Type-Specific Methods**: Method khusus untuk setiap tipe data
5. **Cross-Platform**: Bekerja di semua platform Flutter
6. **Easy Implementation**: API yang sederhana dan mudah digunakan

### Praktikum 5 - File System Access dengan path_provider:
1. **Platform-Independent Paths**: Mendapatkan path sistem yang sesuai dengan platform
2. **Documents Directory**: Akses ke direktori untuk menyimpan file permanen user
3. **Temporary Directory**: Akses ke direktori untuk cache dan file temporary
4. **Async File Operations**: Operasi asynchronous untuk akses file system
5. **Cross-Platform Support**: Bekerja di Android, iOS, Web, Windows, macOS, Linux
6. **Directory Object**: Objek Directory untuk operasi file/folder lanjutan

**Best Practices yang Dipelajari**:
- Selalu validasi data dari sumber eksternal (API, file JSON)
- Berikan nilai default yang meaningful untuk data yang hilang atau invalid
- Gunakan type-safe parsing methods seperti `tryParse()`
- Tampilkan pesan yang user-friendly, bukan "null" di UI
- Test aplikasi dengan data yang tidak sempurna untuk memastikan robustness
- Gunakan konstanta untuk semua string literals kunci JSON
- Single Source of Truth untuk maintainability
- Manfaatkan IDE auto-complete untuk mengurangi typo
- Gunakan SharedPreferences untuk data sederhana yang perlu persisten
- Jangan simpan data sensitif di SharedPreferences
- Gunakan async/await untuk operasi I/O dan storage
- Pilih direktori yang tepat sesuai dengan jenis data (Documents vs Temporary)
- Selalu handle error saat akses file system
- Clean up temporary files secara berkala

## Struktur Project

```
lib/
├── main.dart           # Main application dengan error handling, SharedPreferences, dan path_provider
└── model/
    └── pizza.dart      # Pizza model dengan robust fromJson() dan toJson()

assets/
├── pizzalist.json          # Data JSON normal
└── pizzalist_broken.json   # Data JSON tidak konsisten untuk testing
```

