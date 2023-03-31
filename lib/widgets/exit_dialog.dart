import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/res/styles.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/state/auth.dart';
import 'package:shine_credit/widgets/base_dialog.dart';

class ExitDialog extends ConsumerStatefulWidget {
  const ExitDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExitDialogState();
}

class _ExitDialogState extends ConsumerState<ExitDialog> {
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Warning',
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text('You Should login in', style: TextStyles.textSize16),
      ),
      onPressed: () async {
        await ref.watch(authNotifierProvider.notifier).logout();
        if (context.mounted) {
          const LoginRoute().go(context);
        }
      },
    );
  }
}
