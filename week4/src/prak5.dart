// Langkah 3: Fungsi tukar di luar scope main()
(int, int) tukar((int, int) record) {
  var (a, b) = record;
  return (b, a);
}

void main(List<String> args) {
  print("=== Langkah 1 & 2: Basic Records ===");
  // Langkah 1: Basic record declaration
  var record = ('first', a: 2, b: true, 'last');
  print(record); // Diperbaiki: menambahkan semicolon

  print("\n=== Langkah 3: Function dengan Records ===");
  // Menggunakan fungsi tukar()
  var originalRecord = (10, 20);
  print("Record sebelum ditukar: $originalRecord");
  
  var swappedRecord = tukar(originalRecord);
  print("Record setelah ditukar: $swappedRecord");

  print("\n=== Langkah 4: Record Type Annotation ===");
  // Record type annotation in a variable declaration:
  (String, int) mahasiswa;
  
  // Inisialisasi dengan nama dan NIM
  mahasiswa = ('Charellino Kalingga Sadewo', 2341720205);
  print("Mahasiswa: $mahasiswa");
  print("Nama: ${mahasiswa.$1}");
  print("NIM: ${mahasiswa.$2}");

  print("\n=== Langkah 5: Record Field Access ===");
  // Menggunakan nama dan NIM pada record
  var mahasiswa2 = ('Charellino Kalingga Sadewo', a: 2341720205, b: true, 'Teknik Informatik');

  print("Accessing record fields:");
  print(mahasiswa2.$1); // Prints nama
  print(mahasiswa2.a);   // Prints NIM
  print(mahasiswa2.b);   // Prints true
  print(mahasiswa2.$2);  // Prints jurusan
  
  print("\nComplete record: $mahasiswa2");
}
