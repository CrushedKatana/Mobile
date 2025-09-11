void main() {
  String? alamat;
  alamat = null;
  print("Alamat saat ini: $alamat");

  if (alamat != null) {
    print("Panjang alamat: ${alamat.length}");
  } else {
    print("Alamat tidak diketahui.");
  }
}