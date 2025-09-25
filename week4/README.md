# Tugas Praktikum

# 1. Silakan selesaikan Praktikum 1 sampai 5, lalu dokumentasikan berupa screenshot hasil pekerjaan Anda beserta penjelasannya!

## 2. Praktikum 1: Eksperimen Tipe Data List

Selesaikan langkah-langkah praktikum berikut ini menggunakan VS Code atau Code Editor favorit Anda.

### Langkah 1:
Ketik atau salin kode program berikut ke dalam void main().

```dart
var list = [1, 2, 3];
assert(list.length == 3);
assert(list[1] == 2);
print(list.length);
print(list[1]);

list[1] = 1;
assert(list[1] == 1);
print(list[1]);
```
### Langkah 2:
Silakan coba eksekusi (Run) kode pada langkah 1 tersebut. Apa yang terjadi? Jelaskan!

#### Answer

![](./img/1.png)

Penjelasan:

1. print(list.length); → mencetak 3 (panjang list [1, 2, 3])
2. print(list[1]); → mencetak 2 (elemen pada index 1)
3. list[1] = 1; → mengubah elemen index 1 dari 2 menjadi 1
4. print(list[1]); → mencetak 1 (elemen index 1 setelah diubah)
Semua assert statements berjalan tanpa error karena kondisinya benar.


### Langkah 3:
Ubah kode pada langkah 1 menjadi variabel final yang mempunyai index = 5 dengan default value = null. Isilah nama dan NIM Anda pada elemen index ke-1 dan ke-2. Lalu print dan capture hasilnya.

Apa yang terjadi ? Jika terjadi error, silakan perbaiki.

#### Answer

![](./img/2.png)
Penjelasan:

1. final variable: finalList dideklarasikan sebagai final (tidak bisa diubah referensinya)
2. index = 5: List memiliki 5 elemen (index 0-4)
3. default value = null: Semua elemen diinisialisasi dengan null
4. Nama di index 1: "Charellino Kalingga Sadewo"
5. NIM di index 2: "2341720205"
6. String?: Tipe data nullable string untuk mengakomodasi null values

## 3. Praktikum 2: Eksperimen Tipe Data Set
Selesaikan langkah-langkah praktikum berikut ini menggunakan VS Code atau Code Editor favorit Anda.

### Langkah 1:
Ketik atau salin kode program berikut ke dalam fungsi main().

```dart
var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
print(halogens);
```

### Langkah 2:
Silakan coba eksekusi (Run) kode pada langkah 1 tersebut. Apa yang terjadi? Jelaskan! Lalu perbaiki jika terjadi error.

### Answer 
![](./img/4.png)
Deklarasi menggunakan {} dengan elemen langsung akan membuat sebuah Set di Dart.

### Langkah 3:
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.

```dart
var names1 = <String>{};
Set<String> names2 = {}; // This works, too.
var names3 = {}; // Creates a map, not a set.

print(names1);
print(names2);
print(names3);
```

Apa yang terjadi ? Jika terjadi error, silakan perbaiki namun tetap menggunakan ketiga variabel tersebut. Tambahkan elemen nama dan NIM Anda pada kedua variabel Set tersebut dengan dua fungsi berbeda yaitu .add() dan .addAll(). Untuk variabel Map dihapus, nanti kita coba di praktikum selanjutnya.

#### Answer
* var names1 = <String>{}; → Set kosong bertipe String
* Set<String> names2 = {}; → Set kosong bertipe String
* var names3 = {}; → Map kosong, bukan Set!

![](./img/5.png)

Perbaikan & Penambahan
* Hapus penggunaan names3 (Map).
* Tambahkan nama dan NIM ke names1 dan names2 menggunakan .add() dan .addAll().

![](./img/6.png)


## 4. Praktikum 3: Eksperimen Tipe Data Maps
Selesaikan langkah-langkah praktikum berikut ini menggunakan VS Code atau Code Editor favorit Anda.

### Langkah 1:
Ketik atau salin kode program berikut ke dalam fungsi main().

```dart
var gifts = {
  // Key:    Value
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 1
};

var nobleGases = {
  2: 'helium',
  10: 'neon',
  18: 2,
};

print(gifts);
print(nobleGases);
```

### Langkah 2:
Silakan coba eksekusi (Run) kode pada langkah 1 tersebut. Apa yang terjadi? Jelaskan! Lalu perbaiki jika terjadi error.

#### Answer 

![](./img/7.png)

* gifts is a Map with String keys and mixed value types (String and int).
* nobleGases is a Map with int keys and mixed value types (String and int).

Penjelasan:
Dart Map dapat berisi value dengan tipe berbeda jika tidak dideklarasikan secara spesifik. Namun, jika Anda ingin menggunakan Map dengan tipe tertentu (misal Map<String, String>), semua value harus bertipe String.

### Langkah 3:
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.

```dart
var mhs1 = Map<String, String>();
gifts['first'] = 'partridge';
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';

var mhs2 = Map<int, String>();
nobleGases[2] = 'helium';
nobleGases[10] = 'neon';
nobleGases[18] = 'argon';
```
Apa yang terjadi ? Jika terjadi error, silakan perbaiki.

Tambahkan elemen nama dan NIM Anda pada tiap variabel di atas (gifts, nobleGases, mhs1, dan mhs2). Dokumentasikan hasilnya dan buat laporannya!

#### Answer

![](./img/8.png)

Penambahan & Perbaikan
* *ar mhs1 = Map<String, String>();
* gifts['fifth'] = 'golden rings'; (ubah value jadi String)
* var mhs2 = Map<int, String>();
* nobleGases[18] = 'argon'; (ubah value jadi String)

Jika ingin Map bertipe khusus, semua value harus bertipe sama.

* Tambahkan nama dan NIM Anda ke semua Map.

## 5. Praktikum 4: Eksperimen Tipe Data List: Spread dan Control-flow Operators
Selesaikan langkah-langkah praktikum berikut ini menggunakan VS Code atau Code Editor favorit Anda.

### Langkah 1:
Ketik atau salin kode program berikut ke dalam fungsi main().

```dart
var list = [1, 2, 3];
var list2 = [0, ...list];
print(list1);
print(list2);
print(list2.length);
```

### Langkah 2:
Silakan coba eksekusi (Run) kode pada langkah 1 tersebut. Apa yang terjadi? Jelaskan! Lalu perbaiki jika terjadi error.

#### Answer
**Masalah:** Terjadi error karena pada baris `print(list1);`, variabel yang benar adalah `list`, bukan `list1`.

![](./img/9.png)

**Penjelasan:**
1. `var list = [1, 2, 3];` → Membuat list dengan 3 elemen
2. `var list2 = [0, ...list];` → Menggunakan **spread operator** (`...`) untuk menyebarkan semua elemen dari `list` ke dalam `list2`
3. `print(list);` → Mencetak list asli: `[1, 2, 3]`
4. `print(list2);` → Mencetak list baru: `[0, 1, 2, 3]`
5. `print(list2.length);` → Mencetak panjang list2: `4`

**Spread operator (`...`)** memungkinkan kita untuk menyebarkan (spread) elemen-elemen dari satu collection ke dalam collection lain.

### Langkah 3:
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.

```dart 
list1 = [1, 2, null];
print(list1);
var list3 = [0, ...?list1];
print(list3.length);
```

Apa yang terjadi ? Jika terjadi error, silakan perbaiki.

Tambahkan variabel list berisi NIM Anda menggunakan Spread Operators. Dokumentasikan hasilnya dan buat laporannya!

#### Answer

![](./img/9.png)

**Penjelasan:**
1. `List<int?> list1 = [1, 2, null];` → Membuat list yang dapat berisi nilai null
2. `var list3 = [0, ...list1];` → Menggunakan spread operator biasa (`...`) karena list1 tidak null
3. **Null-aware spread operator** (`...?`) digunakan ketika collection-nya mungkin null, bukan elemen di dalamnya

**Kode yang ditambahkan:**
```dart
var nim = ['2', '3', '4', '1', '7', '2', '0', '2', '0', '5'];
var listWithNIM = [0, ...nim, 99];
print("List dengan NIM: $listWithNIM");
```

**Manfaat Spread Operator:**
- Menggabungkan beberapa list dengan mudah
- Membuat copy list dengan elemen tambahan
- Syntax yang lebih bersih dibanding `addAll()`

### Langkah 4:
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.
```dart
var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
print(nav);
```
Apa yang terjadi ? Jika terjadi error, silakan perbaiki. Tunjukkan hasilnya jika variabel promoActive ketika true dan false.

#### Answer
**Masalah:** Variabel `promoActive` belum dideklarasikan.

![](./img/10.png)

**Penjelasan:**
1. **Collection If** memungkinkan kita menambahkan elemen secara kondisional ke dalam collection
2. Ketika `promoActive = true` → elemen 'Outlet' ditambahkan
3. Ketika `promoActive = false` → elemen 'Outlet' tidak ditambahkan

**Kode yang diperbaiki:**
```dart
void testPromoActive(bool promoActive) {
  var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  print("Promo Active ($promoActive): $nav");
}
```

**Manfaat Collection If:**
- Membuat collection dinamis berdasarkan kondisi
- Syntax lebih bersih dibanding menggunakan `add()` dengan if-else
- Dapat digunakan dalam list literals

### Langkah 5:
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.
```dart 
var nav2 = ['Home', 'Furniture', 'Plants', if (login case 'Manager') 'Inventory'];
print(nav2);
```
Apa yang terjadi ? Jika terjadi error, silakan perbaiki. Tunjukkan hasilnya jika variabel login mempunyai kondisi lain.

#### Answer

![](./img/11.png)

**Penjelasan:**
1. **Collection If with Pattern Matching** menggunakan `case` untuk mencocokkan nilai spesifik
2. Hanya ketika `login` bernilai `'Manager'`, elemen 'Inventory' akan ditambahkan
3. Untuk nilai lain ('Employee', 'Admin'), elemen tidak ditambahkan

**Kode yang diperbaiki:**
```dart
void testLogin(String login) {
  var nav = ['Home', 'Furniture', 'Plants', if (login case 'Manager') 'Inventory'];
  print("Login sebagai $login: $nav");
}
```

**Perbedaan dengan Langkah 4:**
- Langkah 4: menggunakan boolean condition
- Langkah 5: menggunakan pattern matching dengan `case`

### Langkah 6:
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.

```dart
var listOfInts = [1, 2, 3];
var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
assert(listOfStrings[1] == '#1');
print(listOfStrings);
```
Apa yang terjadi ? Jika terjadi error, silakan perbaiki. Jelaskan manfaat Collection For dan dokumentasikan hasilnya.

#### Answer

![](./img/12.png)

**Penjelasan:**
1. **Collection For** memungkinkan kita menggunakan loop `for` di dalam collection literals
2. `for (var i in listOfInts) '#$i'` → untuk setiap elemen di `listOfInts`, buat string `'#$i'`
3. Hasilnya: `['#0', '#1', '#2', '#3']` (dimulai dari '#0' yang sudah ada, lalu '#1', '#2', '#3')

**Kode tambahan dengan NIM:**
```dart
var nimDigits = [2, 3, 4, 1, 7, 2, 0, 2, 0, 5];
var formattedNim = ['NIM:', for (var digit in nimDigits) 'D$digit'];
print("Formatted NIM: $formattedNim");
```

**Manfaat Collection For:**
1. **Syntax yang lebih bersih** dibanding menggunakan `map()` atau loop terpisah
2. **Inline transformation** - mengubah data sambil membuat collection
3. **Readable code** - mudah dibaca dan dipahami
4. **Performance** - lebih efisien karena tidak perlu membuat collection intermediate

**Contoh Penggunaan Collection For:**
- Transformasi data secara langsung
- Membuat list dari range angka
- Formatting data untuk display
- Filter dan transform dalam satu operasi


## 6. Praktikum 5: Eksperimen Tipe Data Records

### Langkah 1:
Ketik atau salin kode program berikut ke dalam fungsi main().

```dart
var record = ('first', a: 2, b: true, 'last');
print(record)
```

### Langkah 2:
Silakan coba eksekusi (Run) kode pada langkah 1 tersebut. Apa yang terjadi? Jelaskan! Lalu perbaiki jika terjadi error.

#### Answer
**Masalah:** Terjadi error karena kurang semicolon (;) pada baris `print(record)`

![](./img/14.png)

**Penjelasan:**
1. **Records** adalah tipe data baru di Dart yang memungkinkan pengelompokan beberapa nilai dengan tipe berbeda
2. `var record = ('first', a: 2, b: true, 'last');` → Membuat record dengan:
   - **Positional fields**: `'first'` (index 0) dan `'last'` (index 1) 
   - **Named fields**: `a: 2` dan `b: true`
3. Records sangat berguna untuk **mengembalikan multiple values** dari function
4. **Sintaks:** `(value1, value2, namedField: value, ...)`

### Langkah 3:
Tambahkan kode program berikut di luar scope void main(), lalu coba eksekusi (Run) kode Anda.

```dart
(int, int) tukar((int, int) record) {
  var (a, b) = record;
  return (b, a);
}
```

Apa yang terjadi ? Jika terjadi error, silakan perbaiki. Gunakan fungsi tukar() di dalam main() sehingga tampak jelas proses pertukaran value field di dalam Records.

#### Answer

![](./img/15.png)

**Penjelasan:**
1. **Function dengan Record parameter**: `(int, int) tukar((int, int) record)`
   - Parameter: menerima record dengan 2 int
   - Return type: mengembalikan record dengan 2 int
2. **Destructuring**: `var (a, b) = record;` → memecah record ke variabel terpisah
3. **Pattern matching**: Dart secara otomatis assign nilai record ke variabel a dan b
4. Fungsi `tukar()` berhasil menukar posisi dua nilai dalam record

**Kode yang digunakan:**
```dart
var originalRecord = (10, 20);
var swappedRecord = tukar(originalRecord);
```

**Manfaat Records untuk Functions:**
- **Multiple return values** tanpa perlu membuat class khusus
- **Type safety** dengan strong typing
- **Destructuring** untuk mengakses nilai individual

### Langkah 4:
Tambahkan kode program berikut di dalam scope void main(), lalu coba eksekusi (Run) kode Anda.

```dart
// Record type annotation in a variable declaration:
(String, int) mahasiswa;
print(mahasiswa);
```

Apa yang terjadi ? Jika terjadi error, silakan perbaiki. Inisialisasi field nama dan NIM Anda pada variabel record mahasiswa di atas. Dokumentasikan hasilnya dan buat laporannya!

#### Answer
**Masalah:** Variabel `mahasiswa` dideklarasikan tapi tidak diinisialisasi, sehingga error saat di-print.

![](./img/16.png)

**Penjelasan:**
1. **Record Type Annotation**: `(String, int) mahasiswa;` → mendeklarasikan tipe record secara eksplisit
2. **Inisialisasi**: `mahasiswa = ('Charellino Kalingga Sadewo', 2341720205);`
3. **Field Access**: 
   - `mahasiswa.$1` → mengakses field pertama (nama)
   - `mahasiswa.$2` → mengakses field kedua (NIM)

**Kode yang diperbaiki:**
```dart
(String, int) mahasiswa;
mahasiswa = ('Charellino Kalingga Sadewo', 2341720205);
print("Mahasiswa: $mahasiswa");
print("Nama: ${mahasiswa.$1}");
print("NIM: ${mahasiswa.$2}");
```

**Keunggulan Record Type Annotation:**
- **Explicit typing** untuk code clarity
- **Compile-time type checking**
- **IDE support** dengan better autocomplete

### Langkah 5:
Tambahkan kode program berikut di dalam scope void main(), lalu coba eksekusi (Run) kode Anda.
```dart
var mahasiswa2 = ('first', a: 2, b: true, 'last');

print(mahasiswa2.$1); // Prints 'first'
print(mahasiswa2.a); // Prints 2
print(mahasiswa2.b); // Prints true
print(mahasiswa2.$2); // Prints 'last'
```
Apa yang terjadi ? Jika terjadi error, silakan perbaiki. Gantilah salah satu isi record dengan nama dan NIM Anda, lalu dokumentasikan hasilnya dan buat laporannya!

#### Answer

![](./img/17.png)

**Penjelasan:**
1. **Mixed Record**: kombinasi positional dan named fields
2. **Field Access Methods**:
   - **Positional fields**: `$1`, `$2`, `$3`, ... (berdasarkan urutan)
   - **Named fields**: `.a`, `.b`, `.c`, ... (berdasarkan nama)

**Kode yang dimodifikasi:**
```dart
var mahasiswa2 = ('Charellino Kalingga Sadewo', a: 2341720205, b: true, 'Teknik Informatik');

print(mahasiswa2.$1); // Prints nama
print(mahasiswa2.a);  // Prints NIM  
print(mahasiswa2.b);  // Prints true
print(mahasiswa2.$2); // Prints jurusan
```

**Keunggulan Records:**

1. **Lightweight**: Tidak perlu membuat class untuk data sederhana
2. **Immutable**: Nilai tidak bisa diubah setelah dibuat
3. **Type Safety**: Strong typing dengan compile-time checking
4. **Pattern Matching**: Mendukung destructuring dan pattern matching
5. **Multiple Return**: Ideal untuk function yang return multiple values

**Use Cases Records:**
- **Coordinate systems**: `(double x, double y)`
- **API responses**: `(bool success, String message, data: dynamic)`
- **Database queries**: `(int id, String name, email: String)`
- **Mathematical operations**: `(double result, bool overflow)`

# 2. Jelaskan yang dimaksud Functions dalam bahasa Dart!
Functions dalam bahasa Dart adalah sekumpulan instruksi yang dikelompokkan untuk menjalankan tugas tertentu dan dapat dipanggil berulang kali. Fungsi memudahkan pengorganisasian kode, meningkatkan keterbacaan, serta memungkinkan reuse kode. Dalam Dart, fungsi dapat didefinisikan dengan kata kunci `void` atau tipe data lain sesuai nilai yang dikembalikan. Contoh:
```dart
void sapa() {
  print('Halo, dunia!');
}
```
# 3. Jelaskan jenis-jenis parameter di Functions beserta contoh sintaksnya!
Jenis-jenis parameter pada Functions di Dart:
1. **Positional Parameter**: Parameter yang urutannya harus sesuai saat pemanggilan fungsi.
   ```dart
   void tambah(int a, int b) {
     print(a + b);
   }
   tambah(2, 3); // Output: 5
   ```
2. **Optional Positional Parameter**: Parameter yang bersifat opsional dan ditulis dalam tanda kurung siku `[]`.
   ```dart
   void sapa([String? nama]) {
     print('Halo, ${nama ?? 'Anonim'}');
   }
   sapa(); // Output: Halo, Anonim
   sapa('Budi'); // Output: Halo, Budi
   ```
3. **Named Parameter**: Parameter yang dipanggil berdasarkan nama dan ditulis dalam kurung kurawal `{}`.
   ```dart
   void biodata({required String nama, int? umur}) {
     print('Nama: $nama, Umur: ${umur ?? '-'}');
   }
   biodata(nama: 'Andi', umur: 20);
   biodata(nama: 'Siti');
   ```
# 4. Jelaskan maksud Functions sebagai first-class objects beserta contoh sintaknya!
Functions sebagai first-class objects berarti fungsi di Dart dapat diperlakukan seperti data lain, yaitu dapat disimpan dalam variabel, dikirim sebagai parameter, dan dikembalikan dari fungsi lain. Contoh:
```dart
void cetakPesan() {
  print('Ini fungsi sebagai objek');
}

void jalankanFungsi(void Function() fungsi) {
  fungsi();
}

void main() {
  var f = cetakPesan;
  jalankanFungsi(f); // Output: Ini fungsi sebagai objek
}
```
# 5. Apa itu Anonymous Functions? Jelaskan dan berikan contohnya!
Anonymous Functions adalah fungsi tanpa nama yang biasanya digunakan sebagai parameter atau untuk operasi sederhana. Anonymous function sering disebut juga lambda atau closure. Contoh:
```dart
var angka = [1, 2, 3];
angka.forEach((item) {
  print('Angka: $item');
});
```
# 6. Jelaskan perbedaan Lexical scope dan Lexical closures! Berikan contohnya!
**Lexical scope** adalah aturan penentuan variabel berdasarkan lokasi penulisan kode pada saat kompilasi. Variabel hanya dapat diakses pada area (scope) di mana variabel tersebut dideklarasikan.

**Lexical closure** adalah fungsi yang dapat mengakses variabel dari scope di luar dirinya, meskipun scope tersebut sudah selesai dieksekusi.

Contoh Lexical Scope:
```dart
void main() {
  int x = 10;
  void tampilX() {
    print(x); // x dapat diakses karena berada dalam scope main
  }
  tampilX();
}
```
Contoh Lexical Closure:
```dart
Function buatCounter() {
  int hitung = 0;
  return () {
    hitung++;
    print(hitung);
  };
}

void main() {
  var counter = buatCounter();
  counter(); // Output: 1
  counter(); // Output: 2
}
```
# 7. Jelaskan dengan contoh cara membuat return multiple value di Functions!
Untuk mengembalikan lebih dari satu nilai dari sebuah fungsi di Dart, dapat menggunakan tipe data Record (sejak Dart 3) atau Map/List. Contoh menggunakan Record:
```dart
(int, String) getData() {
  int nim = 2341720205;
  String nama = 'Charellino Kalingga Sadewo';
  return (nim, nama);
}

void main() {
  var hasil = getData();
  print('NIM: ${hasil.$1}, Nama: ${hasil.$2}');
}
```


