## Tugas Praktikum
### 1. Selesaikan Praktikum 1 dan 2, lalu dokumentasikan dan push ke repository Anda berupa screenshot setiap hasil pekerjaan beserta penjelasannya di file README.md! Jika terdapat error atau kode yang tidak dapat berjalan, silakan Anda perbaiki sesuai tujuan aplikasi dibuat!

##### Praktikum 1: Mengambil Foto dengan Kamera di Flutter
![](./img/prak1job8.gif)

##### Praktikum 2: Membuat photo filter carousel
![](./img/prak2job8.gif)

### 2. Gabungkan hasil praktikum 1 dengan hasil praktikum 2 sehingga setelah melakukan pengambilan foto, dapat dibuat filter carouselnya!
![](./img/jawaban2.gif)


### 3. Jelaskan maksud void async pada praktikum 1?
Pada Dart, kata kunci `async` dipasang pada sebuah fungsi untuk menandakan bahwa fungsi tersebut berjalan secara asinkron dan bisa menggunakan `await` di dalamnya untuk menunggu `Future` selesai.

- Jika fungsi dituliskan sebagai `void myFunc() async { ... }`, maka meskipun terlihat bertipe `void`, secara internal fungsi tersebut sebenarnya mengembalikan `Future<void>` — artinya pemanggil bisa menunggu penyelesaiannya (dengan `await`) jika ia memiliki referensi ke `Future` tersebut. Namun untuk API publik biasanya lebih baik menuliskannya eksplisit sebagai `Future<void> myFunc() async { ... }` supaya tipe return jelas.
- Di praktikum 1, `async` digunakan pada handler yang perlu menunggu operasi asinkron, misalnya memanggil `availableCameras()` atau `controller.takePicture()` yang mengembalikan `Future`. Dengan `await` kita menulis kode yang tampak sinkron tetapi tidak memblokir UI thread.
- Singkatnya: `async` memungkinkan penggunaan `await` untuk menunggu operasi asinkron (I/O, kamera, file), dan `void`/`Future<void>` menunjukkan fungsi tidak mengembalikan nilai namun dapat menyelesaikan tugasnya di waktu mendatang.


### 4. Jelaskan fungsi dari anotasi @immutable dan @override ?
Berikut penjelasan singkat kedua anotasi tersebut:

- `@immutable`:
	- Anotasi ini (dari package `meta`) menandakan bahwa sebuah kelas dianggap immutable — semua field instance seharusnya `final` dan tidak berubah setelah konstruktor dijalankan.
	- Pada Flutter, kita sering melihatnya pada widget yang harus bersifat immutable (contoh: `StatelessWidget`), sehingga analyzer dapat memeriksa dan memberi peringatan jika ada field non-final.
	- Manfaat: membantu menangkap bug akibat state yang berubah secara tidak sengaja dan membuat kelas lebih mudah dipahami dan diuji.

- `@override`:
	- Digunakan untuk menandai bahwa suatu method/getter/setter sedang meng-override (menimpa) deklarasi di superclass atau interface.
	- Memberikan manfaat pemeriksaan (analyzer akan memberi peringatan jika tanda ini digunakan tapi tidak benar-benar meng-override apa pun) dan meningkatkan keterbacaan kode.
	- Contoh umum: menuliskan `@override` sebelum `Widget build(BuildContext context)` di widget untuk menunjukkan kita mengimplementasikan method `build` dari superclass.

Kedua anotasi ini tidak mengubah perilaku runtime secara langsung, tetapi membantu analyzer, dokumentasi, dan kualitas kode.

### 5. Kumpulkan link commit repository GitHub Anda kepada dosen yang telah disepakati!
