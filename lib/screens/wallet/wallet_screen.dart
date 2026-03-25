import 'package:flutter/material.dart';
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('المحفظة')), body: const Center(child: Text('رصيد المحفظة')));
}
