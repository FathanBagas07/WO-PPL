import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin WO')),
      body: const Center(
        child: Text('Halaman Admin WO'),
      ),
    );
  }
}