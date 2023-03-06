import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoanAuthPage extends ConsumerStatefulWidget {
  const LoanAuthPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoanAuthPageState();
}

class _LoanAuthPageState extends ConsumerState<LoanAuthPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('LoanAuthPage'),
    ));
  }
}
