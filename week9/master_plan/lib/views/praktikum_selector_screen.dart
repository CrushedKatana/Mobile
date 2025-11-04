import 'package:flutter/material.dart';
import 'plan_screen_praktikum1.dart';
import 'plan_screen_praktikum2.dart';
import 'plan_creator_screen.dart';

class PraktikumSelectorScreen extends StatelessWidget {
  const PraktikumSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Master Plan - Charel'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.checklist,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                'Pilih Praktikum',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              _buildPraktikumButton(
                context,
                'Praktikum 1',
                'Dasar State dengan Model-View',
                Colors.purple,
                Icons.numbers_outlined,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PlanScreenPraktikum1(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildPraktikumButton(
                context,
                'Praktikum 2',
                'InheritedWidget dan InheritedNotifier',
                Colors.orange,
                Icons.account_tree,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PlanScreenPraktikum2(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildPraktikumButton(
                context,
                'Praktikum 3',
                'State di Multiple Screens',
                Colors.blue,
                Icons.dashboard,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PlanCreatorScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPraktikumButton(
    BuildContext context,
    String title,
    String subtitle,
    Color color,
    IconData icon,
    VoidCallback onTap,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withAlpha(25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 32,
                    color: color,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
