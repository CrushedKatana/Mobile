# Tugas Praktikum 1: Dasar State dengan Model-View

## 1. Selesaikan langkah-langkah praktikum tersebut, lalu dokumentasikan berupa GIF hasil akhir praktikum beserta penjelasannya di file README.md! Jika Anda menemukan ada yang error atau tidak berjalan dengan baik, silakan diperbaiki.

## 2. Jelaskan maksud dari langkah 4 pada praktikum tersebut! Mengapa dilakukan demikian?

Pada Langkah 4 kita membuat file `data_layer.dart` yang hanya berisi:

```dart
export 'plan.dart';
export 'task.dart';
```

Maksudnya adalah membuat titik tunggal (single export) untuk model-model pada lapisan data. Dengan cara ini ketika bagian lain aplikasi membutuhkan model cukup mengimpor `models/data_layer.dart` daripada mengimpor setiap file model satu per satu. Keuntungannya:

- Mengurangi verbosity pada import (lebih ringkas).
- Memudahkan refactor: kalau kita memindahkan atau menambah model baru, cukup perbarui file ekspor saja.
- Menyediakan "public API" untuk folder `models` sehingga struktur internal dapat diubah tanpa mempengaruhi banyak file.

Secara praktik, ini meningkatkan keterbacaan dan maintainability seiring bertambahnya file model dalam aplikasi.

## 3. Mengapa perlu variabel plan di langkah 6 pada praktikum tersebut? Mengapa dibuat konstanta ?

Variabel `plan` dideklarasikan di dalam state (`_PlanScreenState`) untuk menyimpan state aplikasi — yaitu nama rencana dan daftar tugas saat ini. Contoh deklarasi yang dipakai di praktikum:

```dart
Plan plan = const Plan();
```

Alasan perlu ada variabel `plan`:

- UI (ListView, TextFormField, Checkbox) perlu sumber data yang dapat dibaca dan diubah saat pengguna menambah/ubah/centang tugas. Variabel `plan` adalah sumber tunggal tersebut.
- Karena widget bersifat stateful, perubahan pada `plan` dilakukan di dalam `setState(...)` sehingga Flutter tahu untuk me-render ulang tampilan.

Mengapa digunakan `const Plan()` pada inisialisasinya:

- `const` di sini memakai konstruktor konstanta untuk nilai awal kosong (immutable) sehingga menandakan nilai awal tidak berubah. Ini efektif sebagai nilai default dan sedikit mengoptimalkan pembuatan objek awal.
- Namun perhatikan: variabel `plan` itu sendiri tidak `final` — kita mengganti referensinya setiap ada perubahan (mis. `plan = Plan(...)` di dalam `setState`). Pola ini mengikuti prinsip immutability pada level objek: alih-alih mengubah properti internal sebuah instance, kita membuat instance baru dengan data yang diubah. Keuntungan pola ini:
	- Lebih mudah ditelusuri (no hidden mutations).
	- Mengurangi bug akibat aliasing/mutasi bersama.
	- Kode update menjadi jelas: setiap `setState` mengganti `plan` dengan instance baru.

Contoh update yang digunakan pada praktikum:

```dart
setState(() {
	plan = Plan(
		name: plan.name,
		tasks: List<Task>.from(plan.tasks)..add(const Task()),
	);
});
```

## 4. Lakukan capture hasil dari Langkah 9 berupa GIF, kemudian jelaskan apa yang telah Anda buat!
Untuk Langkah 9 saya membuat antarmuka daftar tugas sederhana (to-do) bernama "Master Plan". Pada GIF hasil capture, tampilkan minimal alur berikut:

- Menekan tombol tambah (FloatingActionButton) untuk menambahkan tugas baru.
- Mengisi teks pada `TextFormField` untuk mengubah deskripsi tugas.
- Menandai/men-uncheck `Checkbox` untuk menandai tugas selesai/belum selesai.
- Scroll daftar ketika sudah banyak item, dan perlihatkan bagaimana keyboard hilang saat melakukan drag (untuk platform iOS behavior keyboard dismiss on drag).

Komponen utama yang dibuat:

- `Plan` (model): menyimpan `name` dan `tasks` (List<Task>).
- `Task` (model): menyimpan `description` (String) dan `complete` (bool).
- `PlanScreen` (view): StatefulWidget yang menampilkan `ListView.builder` berisi `ListTile` untuk setiap tugas, `TextFormField` untuk edit deskripsi, dan `Checkbox` untuk menandai selesai.
- `FloatingActionButton` menambahkan `Task` baru ke `plan.tasks`.
- `ScrollController` yang ditambahkan untuk menghapus fokus (menyembunyikan keyboard) saat pengguna melakukan scroll.

Hal-hal yang perlu dicapture di GIF (saran urutan):

1. Tampilan awal aplikasi (kosong atau dengan beberapa tugas jika sudah ditambahkan).
2. Tekan tombol tambah → sebuah entry/field baru muncul.
3. Ketik deskripsi tugas baru, lalu tap di luar atau scroll untuk melihat keyboard menghilang.
4. Tandai tugas selesai dengan checkbox — perhatikan perubahan state.
5. Tambahkan beberapa tugas sehingga muncul scroll bar dan scroll ke bawah; tunjukkan bahwa keyboard dismiss berfungsi saat drag (iOS).

Cara menyimpan dan memasukkan GIF ke README (Windows):

- Rekomendasi alat: ScreenToGif (Windows) — rekam area emulator atau perangkat. Simpan sebagai `praktikum1.gif`.
- Alternatif: rekam video menggunakan emulator Android (ADB: `adb shell screenrecord`) lalu konversi ke GIF dengan `ffmpeg`.

Penempatan file dan penyematan ke `README.md`:

1. Letakkan GIF di folder repo, misalnya `assets/praktikum1.gif` atau `media/praktikum1.gif`.
2. Tambahkan baris Markdown di README untuk menampilkan GIF:

```markdown
![Demo Master Plan](assets/praktikum1.gif)
```

Catatan teknis singkat tentang apa yang Anda lihat saat menjalankan aplikasi:

- Menambah tugas: pada `onPressed` FAB, kode membuat instance `Plan` baru dengan `tasks: List<Task>.from(plan.tasks)..add(const Task())`. Ini membuat instance `Task` baru (kosong) dan menambahkan ke daftar.
- Mengedit deskripsi: `TextFormField` memanggil `onChanged` yang mengganti instance pada index tertentu dengan `Task(description: text, complete: task.complete)`, lalu `setState` sehingga UI terupdate.
- Toggle complete: sama pola immutability — mengganti elemen list dengan instance `Task` baru dengan properti `complete` diubah.

## 5. Apa kegunaan method pada Langkah 11 dan 13 dalam lifecyle state ?

## 6. Kumpulkan laporan praktikum Anda berupa link commit atau repository GitHub ke dosen yang telah disepakati !


# Tugas Praktikum 2: InheritedWidget

## 1. Selesaikan langkah-langkah praktikum tersebut, lalu dokumentasikan berupa GIF hasil akhir praktikum beserta penjelasannya di file README.md! Jika Anda menemukan ada yang error atau tidak berjalan dengan baik, silakan diperbaiki sesuai dengan tujuan aplikasi tersebut dibuat.

## 2. Jelaskan mana yang dimaksud InheritedWidget pada langkah 1 tersebut! Mengapa yang digunakan InheritedNotifier?

## 3. Jelaskan maksud dari method di langkah 3 pada praktikum tersebut! Mengapa dilakukan demikian?

## 4. Lakukan capture hasil dari Langkah 9 berupa GIF, kemudian jelaskan apa yang telah Anda buat!

## 5. Kumpulkan laporan praktikum Anda berupa link commit atau repository GitHub ke dosen yang telah disepakati !



# Tugas Praktikum 3: State di Multiple Screens

## 1. Selesaikan langkah-langkah praktikum tersebut, lalu dokumentasikan berupa GIF hasil akhir praktikum beserta penjelasannya di file README.md! Jika Anda menemukan ada yang error atau tidak berjalan dengan baik, silakan diperbaiki sesuai dengan tujuan aplikasi tersebut dibuat.

## 2. Berdasarkan Praktikum 3 yang telah Anda lakukan, jelaskan maksud dari gambar diagram berikut ini!

## 3. Lakukan capture hasil dari Langkah 14 berupa GIF, kemudian jelaskan apa yang telah Anda buat!

## 4. Kumpulkan laporan praktikum Anda berupa link commit atau repository GitHub ke dosen yang telah disepakati !

