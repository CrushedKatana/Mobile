import 'package:flutter/material.dart';
import '../models/item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Item> items = [
      Item(
        name: 'Plushie 1 - hoshino',
        price: 55000,
        imagePath: 'assets/images/hoshino.gif',
        stock: 12,
        rating: 4.8,
      ),
      Item(
        name: 'Plushie 2 - koharu',
        price: 60000,
        imagePath: 'assets/images/koharu.gif',
        stock: 8,
        rating: 4.6,
      ),
      Item(
        name: 'Plushie 3 - niha',
        price: 75000,
        imagePath: 'assets/images/serika.gif',
        stock: 10,
        rating: 4.9,
      ),
      Item(
        name: 'Plushie 4 - tsurugi',
        price: 50000,
        imagePath: 'assets/images/tsurugi.gif',
        stock: 15,
        rating: 4.5,
      ),
      Item(
        name: 'Plushie 5 - niha',
        price: 65000,
        imagePath: 'assets/images/niha.jpeg',
        stock: 9,
        rating: 4.7,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('NIHAHAHA SHOP'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // dua kolom
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            // make cards a bit taller to accommodate increased spacing
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/item', arguments: item);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: item.name,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Image.asset(
                          item.imagePath,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text('Rp ${item.price}'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        Text(item.rating.toString()),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Stok: ${item.stock}'),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Nama: Charel Kalingga S | NIM: 2341720205',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
