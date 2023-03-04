import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/res/styles.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';

class RepayMentPage extends ConsumerStatefulWidget {
  const RepayMentPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RepayMentPageState();
}

class _RepayMentPageState extends ConsumerState<RepayMentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'Repayment details',
        backgroundColor: Colours.app_main,
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const LoadAssetImage(
          'home/repayment_empty',
          width: 100,
          height: 100,
        ),
        Gaps.vGap15,
        const Text(
          'NO borrowing record',
          style: TextStyles.textBold24,
        ),
        Gaps.vGap24,
        MyDecoratedButton(
            minWidth: 200, onPressed: () => {}, text: 'Get loan', radius: 24)
      ])),
    );
  }
}
