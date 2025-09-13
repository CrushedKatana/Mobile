void main(List<String> args) {
  // for (int index = 10; index < 27; index++) {
  //   print(index);
  // } 
  for (int index = 10; index < 27; index++) {
    if (index == 21) {
      break;
    } 
    else if (index % 2 != 0) {
      continue;
    }
    print(index); 
  }
}