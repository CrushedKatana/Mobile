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

![](./IMG/job%209%201.gif)

## 5. Apa kegunaan method pada Langkah 11 dan 13 dalam lifecyle state ?

**Langkah 11 - Method `initState()`:**

Method `initState()` dipanggil sekali saat widget pertama kali dibuat dan dimasukkan ke dalam widget tree. Pada praktikum ini, `initState()` digunakan untuk:

```dart
@override
void initState() {
  super.initState();
  scrollController = ScrollController()
    ..addListener(() {
      FocusScope.of(context).requestFocus(FocusNode());
    });
}
```

Kegunaan:
- Menginisialisasi `ScrollController` yang akan digunakan untuk mengontrol `ListView`.
- Menambahkan listener pada `ScrollController` yang akan memanggil `FocusScope.of(context).requestFocus(FocusNode())` setiap kali terjadi event scroll.
- Fungsi listener ini membuat keyboard otomatis disembunyikan ketika user melakukan scroll, meningkatkan UX terutama pada iOS.
- `initState()` adalah tempat yang tepat untuk inisialisasi objek yang memerlukan `BuildContext` atau resource yang perlu di-setup sebelum widget di-render.

**Langkah 13 - Method `dispose()`:**

Method `dispose()` dipanggil saat widget dihapus secara permanen dari widget tree. Pada praktikum ini, `dispose()` digunakan untuk:

```dart
@override
void dispose() {
  scrollController.dispose();
  super.dispose();
}
```

Kegunaan:
- Membersihkan resource yang digunakan oleh widget, khususnya `ScrollController`.
- Mencegah memory leak dengan memastikan objek yang memiliki listener atau resource native (seperti controller) di-dispose dengan benar.
- `dispose()` dipanggil sebelum widget benar-benar dihapus, memberi kesempatan untuk cleanup.
- Penting untuk selalu memanggil `dispose()` pada controller, animation, stream subscription, dll untuk menghindari memory leak.

Lifecycle state secara singkat:
1. `initState()` → setup/inisialisasi
2. `build()` → render UI (bisa dipanggil berulang kali)
3. `dispose()` → cleanup/pembersihan

## 6. Kumpulkan laporan praktikum Anda berupa link commit atau repository GitHub ke dosen yang telah disepakati !


# Tugas Praktikum 2: InheritedWidget

## 1. Selesaikan langkah-langkah praktikum tersebut, lalu dokumentasikan berupa GIF hasil akhir praktikum beserta penjelasannya di file README.md! Jika Anda menemukan ada yang error atau tidak berjalan dengan baik, silakan diperbaiki sesuai dengan tujuan aplikasi tersebut dibuat.

## 2. Jelaskan mana yang dimaksud InheritedWidget pada langkah 1 tersebut! Mengapa yang digunakan InheritedNotifier?

Pada Langkah 1, yang dimaksud `InheritedWidget` adalah class `PlanProvider` yang extends `InheritedNotifier<ValueNotifier<Plan>>`:

```dart
class PlanProvider extends InheritedNotifier<ValueNotifier<Plan>> {
  const PlanProvider({super.key, required Widget child, required
   ValueNotifier<Plan> notifier})
  : super(child: child, notifier: notifier);

  static ValueNotifier<Plan> of(BuildContext context) {
   return context.
    dependOnInheritedWidgetOfExactType<PlanProvider>()!.notifier!;
  }
}
```

**Mengapa menggunakan `InheritedNotifier` bukan `InheritedWidget` biasa?**

1. **Automatic Rebuild**: `InheritedNotifier` secara otomatis akan memberi tahu widget-widget turunannya untuk rebuild ketika `ValueNotifier` berubah. Dengan `InheritedWidget` biasa, kita harus implement logika `updateShouldNotify()` secara manual.

2. **Integration dengan Listenable**: `InheritedNotifier` dirancang khusus untuk bekerja dengan objek yang implements `Listenable` (seperti `ValueNotifier`, `ChangeNotifier`). Ini membuat pattern reaktif lebih mudah diimplementasikan.

3. **Cleaner Code**: Dengan `ValueNotifier`, kita bisa langsung mengubah nilai dengan `notifier.value = newValue` dan semua widget yang listening akan otomatis rebuild, tanpa perlu manage listener secara manual.

4. **Better Performance**: `InheritedNotifier` hanya akan rebuild widget yang benar-benar depend pada notifier tersebut, bukan seluruh subtree.

Jadi, `InheritedNotifier` adalah pilihan yang lebih praktis dan efisien untuk state management yang reaktif dibanding `InheritedWidget` biasa.

## 3. Jelaskan maksud dari method di langkah 3 pada praktikum tersebut! Mengapa dilakukan demikian?

Pada Langkah 3, dua method getter ditambahkan ke class `Plan`:

```dart
int get completedCount => tasks
  .where((task) => task.complete)
  .length;

String get completenessMessage =>
  '$completedCount out of ${tasks.length} tasks';
```

**Maksud dan Kegunaan:**

1. **`completedCount` getter**:
   - Menghitung jumlah tugas yang sudah selesai (complete = true)
   - Menggunakan method `where()` untuk memfilter hanya task yang complete
   - Mengembalikan panjang (length) dari hasil filter tersebut

2. **`completenessMessage` getter**:
   - Membuat string informatif yang menampilkan progress: "X out of Y tasks"
   - Menggunakan `completedCount` yang sudah dihitung di atas
   - Memberikan informasi yang user-friendly tentang berapa banyak tugas yang telah diselesaikan

**Mengapa dilakukan demikian?**

1. **Separation of Concerns**: Logika perhitungan diletakkan di model (Plan) bukan di UI. Ini membuat kode lebih terorganisir dan mudah di-maintain.

2. **Reusability**: Getter ini bisa digunakan di berbagai tempat dalam aplikasi tanpa duplikasi kode perhitungan.

3. **Computed Property**: Nilai dihitung secara dinamis berdasarkan state saat ini, sehingga selalu up-to-date tanpa perlu manual update.

4. **Encapsulation**: Detail implementasi bagaimana menghitung task yang selesai disembunyikan dari luar. UI hanya perlu memanggil getter tanpa tahu cara kerjanya.

5. **Maintainability**: Jika logika perhitungan perlu diubah (misal menambah kriteria lain), cukup edit di satu tempat (model) tanpa menyentuh UI.

Contoh penggunaan di UI (Langkah 9):
```dart
SafeArea(child: Text(plan.completenessMessage))
```

Dengan pendekatan ini, UI tetap bersih dan fokus pada presentasi, sementara logika bisnis ada di model.

## 4. Lakukan capture hasil dari Langkah 9 berupa GIF, kemudian jelaskan apa yang telah Anda buat!
![](./IMG/job%209%202.gif)

## 5. Kumpulkan laporan praktikum Anda berupa link commit atau repository GitHub ke dosen yang telah disepakati !



# Tugas Praktikum 3: State di Multiple Screens

## 1. Selesaikan langkah-langkah praktikum tersebut, lalu dokumentasikan berupa GIF hasil akhir praktikum beserta penjelasannya di file README.md! Jika Anda menemukan ada yang error atau tidak berjalan dengan baik, silakan diperbaiki sesuai dengan tujuan aplikasi tersebut dibuat.

## 2. Berdasarkan Praktikum 3 yang telah Anda lakukan, jelaskan maksud dari gambar diagram berikut ini!

![](./IMG/image.png)

Diagram tersebut menjelaskan proses navigasi dan perubahan widget tree dalam aplikasi Flutter. Yang awalnya pohon Widget Awal (Blok Biru) ke Aksi "Navigator Push"

## 3. Lakukan capture hasil dari Langkah 14 berupa GIF, kemudian jelaskan apa yang telah Anda buat!
![](./IMG/job%209%203.gif)

## 4. Kumpulkan laporan praktikum Anda berupa link commit atau repository GitHub ke dosen yang telah disepakati !


