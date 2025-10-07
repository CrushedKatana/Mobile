import 'package:flutter/material.dart';

void main() {
  runApp(const BasicLayoutApp());
}

class BasicLayoutApp extends StatelessWidget {
  const BasicLayoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Basic Layout Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: const Center(
          child: PavlovaCard(),
        ),
      ),
    );
  }
}

class PavlovaCard extends StatelessWidget {
  const PavlovaCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Judul & subtitle
    const titleText = Text(
      'Pavlova',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
    const subTitle = Text(
      'Pavlova is a meringue-based dessert named after the Russian ballerina Anna Pavlova.',
      style: TextStyle(
        fontSize: 16,
        fontFamily: 'Roboto',
      ),
    );

    // Rating (stars + jumlah review)
    final stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        const Icon(Icons.star, color: Colors.black),
        const Icon(Icons.star, color: Colors.black),
      ],
    );
    final ratings = Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          stars,
          const Text(
            '170 Reviews',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );

    // Icon list (3 kolom: Prep, Cook, Feeds)
    const descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 18,
      height: 2,
    );
    final iconList = DefaultTextStyle.merge(
      style: descTextStyle,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: const [
                Icon(Icons.kitchen, color: Colors.green),
                Text('PREP:'),
                Text('25 min'),
              ],
            ),
            Column(
              children: const [
                Icon(Icons.timer, color: Colors.green),
                Text('COOK:'),
                Text('1 hr'),
              ],
            ),
            Column(
              children: const [
                Icon(Icons.restaurant, color: Colors.green),
                Text('FEEDS:'),
                Text('4-6'),
              ],
            ),
          ],
        ),
      ),
    );

    // Kolom kiri yang berisi title, subtitle, ratings, iconList
    final leftColumn = Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleText,
          const SizedBox(height: 8),
          subTitle,
          ratings,
          iconList,
        ],
      ),
    );

    // Gambar (gunakan asset atau network)
    final mainImage = Expanded(
      child: Image.asset(
        'assets/images/pavlova.jpg',
        fit: BoxFit.cover,
      ),
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 40, 0, 30),
      height: 600,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 440, child: leftColumn),
            mainImage,
          ],
        ),
      ),
    );
  }
}

