// ignore_for_file: strict_raw_type, prefer_final_locals

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shine_credit/entities/loan_auth_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/router/router.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/state/home.dart';
import 'package:shine_credit/utils/image_utils.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:shine_credit/widgets/future_builder_widget.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';
import 'package:shine_credit/widgets/selected_item.dart';
import 'package:verify_plugin/verify_plugin.dart';

class AuthListPage extends ConsumerStatefulWidget {
  const AuthListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthListPageState();
}

class _AuthListPageState extends ConsumerState<AuthListPage> with RouteAware {
  final _realPlugin = VerifyPlugin();

  late LoanAuthModel _model;

  /// is start auto auth, when user select face auth, and the feace auth result is true,
  /// change this value to true, and auto auth other auth
  bool startAutoAuth = false;

  final GlobalKey<FutureBuilderWidgetState<dynamic>> authListfreshenKey =
      GlobalKey(debugLabel: 'authListfreshenKey');

  @override
  void initState() {
    super.initState();
    _realPlugin.setMethodCallHandler(onInvoke);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _realPlugin.setMethodCallHandler(null);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();

    /// when user back from other page, refresh data
    /// if current status is start auto auth, auto auth other auth
    /// so call autoAuth method is refresh data method
    authListfreshenKey.currentState?.retry();
  }

  Future<void> autoAuth() async {
    if (startAutoAuth) {
      /// wait 300ms, wait page build
      await Future.delayed(const Duration(milliseconds: 300));

      if (context.mounted) {
        if (_model.userCertification?.emergencyContact == false) {
          const LoanAutoStepSecondRoute().push(context);
          return;
        }

        if (_model.userCertification?.bandCard == false) {
          const LoanAutoStepThirdRoute().push(context);
          return;
        }
      }
    }
  }

  Future onInvoke(MethodCall call) async {
    if (call.method == 'detectionResult') {
      final arguments = call.arguments as Map<dynamic, dynamic>;
      final status = arguments['status'];
      if (status == 1) {
        Uint8List encryptResult = arguments['encryptResult'] as Uint8List;
        String? filePath = arguments['file'] as String;

        if (filePath != null && encryptResult != null) {
          final imageBytes = await File(filePath).readAsBytes();
          ToastUtils.showLoading();

          final result = await DioUtils.instance.client
              .liveNessCheckResult(tenantId: '1', body: {
            'b1': encryptResult,
            'b2': imageBytes,
          });

          ToastUtils.cancelToast();

          if (result != null &&
              result.data != null &&
              result.data.result != null &&
              result.data.result!) {
            ToastUtils.show('Matching face success');

            /// when use face auth success:
            /// 1. change face auth status to true
            /// 2. change startAutoAuth to true
            /// 3. start auto auth
            setState(() {
              _model.userCertification?.faceAuthentication = true;
              startAutoAuth = true;
            });

            autoAuth();
          } else {
            ToastUtils.show('Matching face failure');
          }
        }
      } else {
        ToastUtils.show('Matching face failure');
      }
    }
  }

  /// 向服务器License
  Future _checkLicense() async {
    bool auth = _model.userCertification!.authentication;

    if (!auth) {
      ToastUtils.show('Pleace complete authentication first');
      return;
    }

    final status = await Permission.camera.status;
    if (status.isGranted) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      _realPlugin.detection(false);
      return;
    }

    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();
    if (statuses[Permission.camera] == PermissionStatus.granted) {
      _realPlugin.detection(false);
    }
  }

  /// go to lan

  Future<LoanAuthModel?> requestData() async {
    final model = await DioUtils.instance.client.userAuthStatus(tenantId: '1');
    _model = model.data!;
    autoAuth();
    return model.data;
  }

  Future<void> _goLan() async {
    if (_model.userCertification != null &&
        _model.userCertification!.allCertification) {
      final index = ref.read(homeProvider);
      if (index != 0) {
        ref.read(homeProvider.notifier).selectIndex(0);
      }
      final isBack = await Navigator.maybePop(context);
      if (!isBack) {
        await SystemNavigator.pop();
      }
    } else {
      ToastUtils.show('Please complete certification ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'Certification application',
        backgroundColor: Colours.app_main,
      ),
      body: SafeArea(
          child: FutureBuilderWidget(
              key: authListfreshenKey,
              futureFunc: requestData,
              builder: (context, model) {
                return _buildBody(model!);
              })),
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
                      check: loanAuthModel.userCertification!.authentication,
                      onTap: () =>
                          {const LoanAutoStepFirstRoute().push(context)}),
                  Gaps.vGap15,
                  LoanAuthActionItem(
                      image: 'auth/auth_face',
                      title: 'Face Authentication',
                      check:
                          loanAuthModel.userCertification!.faceAuthentication,
                      onTap: _checkLicense),
                  Gaps.vGap15,
                  LoanAuthActionItem(
                      image: 'auth/auth_contact',
                      title: 'Emergency Contact',
                      check: loanAuthModel.userCertification!.emergencyContact,
                      onTap: () =>
                          const LoanAutoStepSecondRoute().push(context)),
                  Gaps.vGap15,
                  LoanAuthActionItem(
                      image: 'auth/auth_bank',
                      title: 'Bank Card',
                      check: loanAuthModel.userCertification!.bandCard,
                      onTap: () =>
                          const LoanAutoStepThirdRoute().push(context)),
                  const Expanded(child: ColoredBox(color: Colours.bg_gray_)),
                  MyDecoratedButton(
                      onPressed: _goLan, text: 'Get loan', radius: 24)
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
      title: title,
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
