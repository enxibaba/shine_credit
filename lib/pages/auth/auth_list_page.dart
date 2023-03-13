import 'package:flutter/material.dart';
import 'package:shine_credit/entities/loan_auth_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';
import 'package:shine_credit/widgets/selected_item.dart';
import 'package:shine_credit/widgets/state_layout.dart';

class AuthListPage extends StatefulWidget {
  const AuthListPage({super.key});

  @override
  State<AuthListPage> createState() => _AuthListPageState();
}

class _AuthListPageState extends State<AuthListPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<LoanAuthModel?> requestData() async {
    final model = await DioUtils.instance.client.userAuthStatus(tenantId: '1');
    return model.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'Certification application',
        backgroundColor: Colours.app_main,
      ),
      body: SafeArea(
          child: FutureBuilder(
        builder:
            (BuildContext context, AsyncSnapshot<LoanAuthModel?> snapshot) {
          if (snapshot.hasData) {
            return _buildBody(snapshot.data!);
          } else {
            return StateLayout(
                type:
                    snapshot.hasError ? StateType.network : StateType.loading);
          }
        },
        future: requestData(),
      )),
    );
  }

  Widget _buildBody(LoanAuthModel loanAuthModel) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoanAuthHeader(
                      mount: loanAuthModel.loanAmount.nullSafe,
                      tenure: loanAuthModel.tenure.nullSafe,
                      apr: loanAuthModel.apr.nullSafe),
                  Gaps.vGap10,
                  LoanAuthActionItem(
                      image: 'auth/auth_idcard',
                      title: 'Authentication',
                      check: loanAuthModel.userCertification!.authentication!,
                      onTap: () =>
                          {const LoanAutoStepFirstRoute().push(context)}),
                  Gaps.vGap15,
                  LoanAuthActionItem(
                      image: 'auth/auth_face',
                      title: 'Face Authentication',
                      check:
                          loanAuthModel.userCertification!.faceAuthentication!,
                      onTap: () => {}),
                  Gaps.vGap15,
                  LoanAuthActionItem(
                      image: 'auth/auth_contact',
                      title: 'Emergency Contact',
                      check: loanAuthModel.userCertification!.emergencyContact!,
                      onTap: () => {}),
                  Gaps.vGap15,
                  LoanAuthActionItem(
                      image: 'auth/auth_bank',
                      title: 'Bank Card',
                      check: loanAuthModel.userCertification!.emergencyContact!,
                      onTap: () => {}),
                  const Expanded(child: ColoredBox(color: Colours.bg_gray_)),
                  MyDecoratedButton(
                      onPressed: () => {}, text: 'Get loan', radius: 24)
                ]),
          ),
        )
      ],
    );
  }
}

class LoanAuthHeader extends StatelessWidget {
  const LoanAuthHeader({
    super.key,
    required this.mount,
    required this.tenure,
    required this.apr,
  });

  final String mount;

  final String tenure;

  final String apr;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 340 / 91.5,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: ImageUtils.getAssetImage('auth/auth_header_bg',
                  format: ImageFormat.webp)),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          LoanHeaderItem(title: 'loan amount', subTitle: '₹$mount'),
          const ColoredBox(
              color: Colours.bg_gray_, child: SizedBox(width: 0.5, height: 45)),
          LoanHeaderItem(title: 'Tenure', subTitle: tenure),
          const ColoredBox(
              color: Colours.bg_gray_, child: SizedBox(width: 0.5, height: 45)),
          LoanHeaderItem(title: 'APR', subTitle: apr),
        ]),
      ),
    );
  }
}

class LoanAuthActionItem extends StatelessWidget {
  const LoanAuthActionItem({
    super.key,
    required this.image,
    required this.title,
    required this.check,
    this.onTap,
  });

  final String image;
  final String title;
  final bool check;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: SelectedItem(
      leading: LoadAssetImage(image, width: 25, height: 25),
      title: 'Face Authentication',
      trailing: LoadAssetImage(check ? 'checked_icon' : 'un_check_icon',
          width: 18, height: 18),
      onTap: check ? null : onTap,
    ));
  }
}

class LoanHeaderItem extends StatelessWidget {
  const LoanHeaderItem({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
        Gaps.vGap10,
        Text(
          subTitle,
          style: const TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
