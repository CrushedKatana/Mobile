import 'package:flutter/material.dart';
import '../models/item.dart';
import 'item_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Langkah 5: Data model
    final List<Item> items = [
      Item(name: 'Apel', price: 5000),
      Item(name: 'Jeruk', price: 7000),
      Item(name: 'Mangga', price: 8000),
      Item(name: 'Pisang', price: 4000),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Belanja'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            child: InkWell(
              onTap: () {
                // Langkah 7: Navigasi ke ItemPage dan kirim data
                Navigator.pushNamed(
                  context,
                  '/item',
                  arguments: item,
                );
              },
              child: ListTile(
                title: Text(item.name),
                subtitle: Text('Rp ${item.price}'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
    );
  }
}
