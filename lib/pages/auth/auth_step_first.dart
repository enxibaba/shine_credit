import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shine_credit/entities/person_auth_model.dart';
import 'package:shine_credit/main.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/pages/auth/widgets/auth_detial_header.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/router/routes.dart';
import 'package:shine_credit/utils/app_utils.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:shine_credit/widgets/load_image.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';
import 'package:shine_credit/widgets/selected_image.dart';

enum AuthUploadType {
  IdCardFront('auth/upload_front_bg', 'Front', 'AAD_CARD_FRONT'),
  IdCardBack('auth/upload_back_bg', 'Back', 'AAD_CARD_BACK'),
  BankCardFront('auth/upload_front_bg', 'Pan', 'PAN');

  const AuthUploadType(this.path, this.tipsText, this.imageKey);

  final String path;
  final String tipsText;
  final String imageKey;
}

class AuthStepFirst extends StatefulWidget {
  const AuthStepFirst({super.key});

  @override
  State<AuthStepFirst> createState() => _AuthStepFirstState();
}

class _AuthStepFirstState extends State<AuthStepFirst> {
  final Map<String, String> _imageFiles = {
    'AAD_CARD_FRONT': '',
    'AAD_CARD_BACK': '',
    'PAN': ''
  };

  final _tips = '''
1.Ensure that all the documents uploaded are Clear and not blurred
2.incomplete infoRmation may prevent you from passing thecetification successfully
  ''';

  var _idCardFrontKey = UniqueKey();
  var _idCardBackKey = UniqueKey();
  var _bankCardFrontKey = UniqueKey();

  Future<void> _ocrImageInfo() async {
    ToastUtils.showLoading();

    final List<Map<String, String>> dataList = [];

    for (final key in _imageFiles.keys) {
      if (_imageFiles[key]!.isEmpty) {
        ToastUtils.show('Please upload all the documents');
        return;
      } else {
        dataList.add({'imageType': key, 'url': _imageFiles[key]!});
      }
    }

    try {
      final data = await DioUtils.instance.client
          .ocrImagesInfo(body: {'reqDataList': dataList}, tenantId: '1');
      ToastUtils.cancelToast();
      if (data.code == 0 && data.data != null) {
        goToDetial(data.data!);
      } else {
        // PAN卡
        // (1002002104, "Pan card 验证失败");
        // (1003002102, "pan卡号识别为空，识别错误");
        // 1002002103, "姓名识别为空，识别错误"

        // Id卡反面
        // (1002002105, "Aadhaar card 反面检验失败")
        // id卡正面
        // (1002002105, "Aadhaar card 正面检验失败");
        // (1002002106, "身份证号识别为空，识别错误");
        // (1002002108, "姓名识别为空，识别错误");
        // (1002002107, "生日识别为空，识别错误");

        switch (data.code) {
          case 1002002110:
          case 1003002102:
          case 1002002103:
          case 1002002104:

            /// AuthUploadType.BankCardFront error
            setState(() {
              _imageFiles[AuthUploadType.BankCardFront.imageKey] = '';
              _bankCardFrontKey = UniqueKey();
            });

            break;

          case 1002002105:

            /// AuthUploadType.IdCardBack error
            setState(() {
              _imageFiles[AuthUploadType.IdCardBack.imageKey] = '';
              _idCardBackKey = UniqueKey();
            });
            break;

          case 1002002106:
          case 1002002108:
          case 1002002107:

            /// AuthUploadType.IdCardFront error
            setState(() {
              _imageFiles[AuthUploadType.IdCardFront.imageKey] = '';
              _idCardFrontKey = UniqueKey();
            });
            break;
        }
      }
    } catch (e) {
     AppUtils.log.e(e);
    }
  }

  void goToDetial(PersonAuthModel model) {
    LoanAutoStepFirstDetailRoute($extra: model).pushReplacement(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'Identification(1/4)',
        backgroundColor: Colours.app_main,
      ),
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const AuthDetailHeader(),
                Gaps.vGap15,
                MyCard(
                    child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 80,
                        child: Text(
                          'Aadhaar',
                          style: TextStyle(
                              fontSize: Dimens.font_sp15, color: Colours.text),
                        ),
                      ),
                      AuthUploadImage(
                          key: _idCardFrontKey,
                          uploadType: AuthUploadType.IdCardFront,
                          urlCallBack: (url) => {
                                _imageFiles[
                                    AuthUploadType.IdCardFront.imageKey] = url,
                              }),
                      Gaps.hGap15,
                      AuthUploadImage(
                          key: _idCardBackKey,
                          uploadType: AuthUploadType.IdCardBack,
                          urlCallBack: (url) => {
                                _imageFiles[
                                    AuthUploadType.IdCardBack.imageKey] = url,
                              })
                    ],
                  ),
                )),
                Gaps.vGap15,
                MyCard(
                    child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 80,
                        child: Text(
                          'Pan',
                          style: TextStyle(
                              fontSize: Dimens.font_sp15, color: Colours.text),
                        ),
                      ),
                      AuthUploadImage(
                          key: _bankCardFrontKey,
                          uploadType: AuthUploadType.BankCardFront,
                          urlCallBack: (url) => {
                                _imageFiles[AuthUploadType
                                    .BankCardFront.imageKey] = url,
                              })
                    ],
                  ),
                )),
                Gaps.vGap24,
                Text(
                  _tips,
                  style: const TextStyle(
                      color: Colours.text_regular, fontSize: Dimens.font_sp14),
                ),
                const Expanded(child: ColoredBox(color: Colours.bg_gray_)),
                MyDecoratedButton(
                    onPressed: _ocrImageInfo, text: 'Continue', radius: 24),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}

class AuthUploadImage extends StatelessWidget {
  const AuthUploadImage({
    super.key,
    required this.uploadType,
    required this.urlCallBack,
  });

  final GenericTypesCallback<String> urlCallBack;
  final AuthUploadType uploadType;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SelectedImage(
        source: ImageSource.gallery,
        filePathCallback: urlCallBack,
        child: SizedBox(
          width: 103,
          height: 65,
          child: Stack(
            alignment: Alignment.center,
            children: [
              LoadAssetImage(uploadType.path),
              Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colours.button_disabled,
                  ),
                  child: const LoadAssetImage(
                    'auth/upload_camera',
                    width: 30,
                    height: 30,
                  )),
            ],
          ),
        ),
      ),
      Gaps.vGap10,
      Text(uploadType.tipsText,
          style: const TextStyle(
              color: Colours.app_main,
              fontSize: Dimens.font_sp12,
              fontWeight: FontWeight.bold))
    ]);
  }
}
