void main(List<String> args) {
  String nama = "Charellino Kalingga Sadewo";
  String nim = "2341720205";

  for (int i = 0; i <= 201; i++) {
    bool isPrime = false;

    if (i > 1) {
      isPrime = true; 
      for (int j = 2; j <= i / 2; j++) {
        
        if (i % j == 0) {
          isPrime = false;
          break; 
        }
      }
    }

    if (isPrime) {
      print("----------------------------");
      print("Bilangan prima ditemukan : $i");
      print("Nama : $nama");
      print("NIM : $nim");
      print("----------------------------");
    } else {
      print("Bukan Prima: $i");
    }
  }
}