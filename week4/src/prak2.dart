void main(List<String> args) {
  var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
  print(halogens);

  // Langkah 3
  var names1 = <String>{};
  Set<String> names2 = {}; // This works, too.
  var names3 = {}; // Creates a map, not a set.

  names1.add('Charellino Kalingga Sadewo');
  names1.add('2341720205');

  names2.addAll(['Charellino Kalingga Sadewo', '2341720205']);

  print(names1);
  print(names2);
}