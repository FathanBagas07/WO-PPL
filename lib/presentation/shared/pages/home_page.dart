import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WOrganice'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Pilih Peran Pengguna'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/admin'),
              child: const Text('Admin WO'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/client'),
              child: const Text('Klien'),
            ),
          ],
        ),
      ),
    );
  }
}