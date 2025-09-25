void main(List<String> args) {
  print("=== Langkah 1 & 2: Spread Operator ===");
  var list = [1, 2, 3];
  var list2 = [0, ...list];
  print(list);  // Diperbaiki dari list1 ke list
  print(list2);
  print("Length: ${list2.length}");

  print("\n=== Langkah 3: Null-aware Spread Operator ===");
  List<int?> list1 = [1, 2, null];
  print(list1);
  var list3 = [0, ...list1];  // Menggunakan ... karena list1 tidak null
  print("Length: ${list3.length}");
  
  // Tambahan: List berisi NIM menggunakan Spread Operators
  var nim = ['2', '3', '4', '1', '7', '2', '0', '2', '0', '5'];
  var listWithNIM = [0, ...nim, 99];
  print("List dengan NIM: $listWithNIM");

  print("\n=== Langkah 4: Collection If ===");
  testPromoActive(true);
  testPromoActive(false);

  print("\n=== Langkah 5: Collection If with Pattern Matching ===");
  testLogin('Manager');
  testLogin('Employee');
  testLogin('Admin');

  print("\n=== Langkah 6: Collection For ===");
  var listOfInts = [1, 2, 3];
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  assert(listOfStrings[1] == '#1');
  print("Collection For result: $listOfStrings");
  
  // Contoh tambahan dengan NIM
  var nimDigits = [2, 3, 4, 1, 7, 2, 0, 2, 0, 5];
  var formattedNim = ['NIM:', for (var digit in nimDigits) 'D$digit'];
  print("Formatted NIM: $formattedNim");
}

void testPromoActive(bool promoActive) {
  var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  print("Promo Active ($promoActive): $nav");
}

void testLogin(String login) {
  var nav = ['Home', 'Furniture', 'Plants', if (login case 'Manager') 'Inventory'];
  print("Login sebagai $login: $nav");
}