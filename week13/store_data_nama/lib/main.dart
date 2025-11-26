import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'model/pizza.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store Data Charel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Store Data Charel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pizza> myPizzas = [];

  Future<List<Pizza>> readJsonFile() async {
    final String response =
        await rootBundle.loadString('assets/pizzalist_broken.json');
    final data = jsonDecode(response);
    List pizzaMapList = data;
    List<Pizza> myPizzas = pizzaMapList.map((pizzaMap) {
      return Pizza.fromJson(pizzaMap);
    }).toList();
    
    String json = convertToJSON(myPizzas);
    print(json);
    return myPizzas;
  }

  String convertToJSON(List<Pizza> pizzas) {
    return jsonEncode(pizzas.map((pizza) => pizza.toJson()).toList());
  }

  @override
  void initState() {
    super.initState();
    readJsonFile().then((value) {
      setState(() {
        myPizzas = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: myPizzas.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(
              myPizzas[index].pizzaName.isNotEmpty
                  ? myPizzas[index].pizzaName
                  : 'No name',
            ),
            subtitle: Text(
              myPizzas[index].description.isNotEmpty
                  ? myPizzas[index].description
                  : 'No description',
            ),
            trailing: Text(
              '\$${myPizzas[index].price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('📸 Ready for Screenshot!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        tooltip: 'Ready for Screenshot',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
