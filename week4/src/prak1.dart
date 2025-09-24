void main(List<String> args) {

    // Langkah 1: Kode original
    var list = [1, 2, 3];
    assert(list.length == 3);
    assert(list[1] == 2);
    print(list.length);
    print(list[1]);

    list[1] = 1;
    assert(list[1] == 1);
    print(list[1]);

    // Langkah 3: Modifikasi kode
    print("\n");
    final List<String?> finalList = List.filled(5, null);
    
    finalList[1] = "Charellino Kalingga Sadewo"; 
    finalList[2] = "2341720205"; 
    
    print("Length: ${finalList.length}");
    print("Index 0: ${finalList[0]}");
    print("Index 1: ${finalList[1]}");
    print("Index 2: ${finalList[2]}");
    print("Index 3: ${finalList[3]}");
    print("Index 4: ${finalList[4]}");
    print("Full list: $finalList");
}
