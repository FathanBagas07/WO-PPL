import 'package:flutter/material.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Klien')),
      body: const Center(
        child: Text('Halaman Klien'),
      ),
    );
  }
}