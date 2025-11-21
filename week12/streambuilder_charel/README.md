# streambuilder_charel

Nama: Charel  
NIM: [NIM Anda]  
Kelas: [Kelas Anda]

---

## Praktikum 6: StreamBuilder

### Soal 12
**Langkah 3 dan 7**

**Penjelasan Langkah 3 (Method getNumbers di stream.dart):**

```dart
class NumberStream {
  Stream<int> getNumbers() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int t) {
      Random random = Random();
      int myNum = random.nextInt(10);
      return myNum;
    });
  }
}
```

**Maksud kode:**

1. **`Stream<int> getNumbers() async*`**: 
   - Method yang mengembalikan Stream of integers
   - `async*` menandakan ini adalah generator function yang menghasilkan stream
   - Berbeda dengan `async` biasa yang return Future, `async*` return Stream

2. **`yield* Stream.periodic(...)`**:
   - `yield*` mendelegasikan/meneruskan semua nilai dari stream lain
   - Mengirimkan setiap nilai yang dihasilkan `Stream.periodic` ke stream output

3. **`Stream.periodic(const Duration(seconds: 1), ...)`**:
   - Membuat stream yang emit event secara periodik setiap 1 detik
   - Parameter kedua adalah callback function yang dipanggil setiap interval

4. **`(int t) { ... }`**:
   - `t` adalah tick counter yang dimulai dari 0 dan increment setiap detik
   - Tidak digunakan dalam kode ini, tapi tetap ada sebagai parameter

5. **`Random().nextInt(10)`**:
   - Generate angka random antara 0-9
   - Angka ini yang akan di-emit ke stream setiap detik

**Ringkasan**: Method ini membuat stream yang secara otomatis mengeluarkan angka random (0-9) setiap 1 detik tanpa henti.

---

**Penjelasan Langkah 7 (StreamBuilder di main.dart):**

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Stream Charel'),
    ),
    body: StreamBuilder(
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
    ),
  );
}
```

**Maksud kode:**

1. **`StreamBuilder`**:
   - Widget khusus Flutter untuk listen ke stream dan rebuild UI otomatis
   - Setiap kali stream emit data baru, builder function dipanggil ulang
   - Tidak perlu manual `setState()`, StreamBuilder handle itu secara otomatis

2. **`stream: numberStream`**:
   - Menghubungkan StreamBuilder dengan stream yang akan di-listen
   - Dalam hal ini, stream yang menghasilkan random numbers setiap detik

3. **`initialData: 0`**:
   - Data awal yang ditampilkan sebelum stream emit nilai pertama
   - Berguna untuk menghindari tampilan kosong di awal

4. **`builder: (context, snapshot) { ... }`**:
   - Function yang dipanggil setiap ada data baru dari stream
   - `snapshot` berisi state terkini dari stream (data, error, connection state)

5. **`snapshot.hasError`**:
   - Mengecek apakah ada error pada stream
   - Jika ada, print "Error!" ke console

6. **`snapshot.hasData`**:
   - Mengecek apakah snapshot memiliki data
   - Return true jika stream sudah emit data

7. **`snapshot.data.toString()`**:
   - Mengambil data dari snapshot dan convert ke string
   - Data ini adalah angka random yang di-emit stream

8. **`SizedBox.shrink()`**:
   - Widget dengan size 0x0, digunakan sebagai placeholder
   - Ditampilkan jika belum ada data (seharusnya tidak terjadi karena ada initialData)

**Ringkasan**: StreamBuilder otomatis listen ke stream dan rebuild UI setiap detik dengan angka random baru, tanpa perlu manual setState() atau subscription management.

**Keuntungan StreamBuilder:**
- ✅ Otomatis manage subscription lifecycle
- ✅ Otomatis rebuild UI saat ada data baru
- ✅ Handle error dan loading state dengan mudah
- ✅ Tidak perlu manual `dispose()` subscription
- ✅ Kode lebih clean dan deklaratif

**Screenshot:**
![Screenshot Soal 12](docs/soal12.png)

---

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
