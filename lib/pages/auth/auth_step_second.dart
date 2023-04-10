import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shine_credit/entities/diction_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/pages/auth/widgets/auth_detial_header.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/other_utils.dart';
import 'package:shine_credit/utils/theme_utils.dart';
import 'package:shine_credit/utils/toast_uitls.dart';
import 'package:shine_credit/widgets/my_app_bar.dart';
import 'package:shine_credit/widgets/my_button.dart';
import 'package:shine_credit/widgets/my_card.dart';
import 'package:shine_credit/widgets/selected_item.dart';

class AuthStepSecond extends StatefulWidget {
  const AuthStepSecond({super.key});

  @override
  State<AuthStepSecond> createState() => _AuthStepSecondState();
}

class _AuthStepSecondState extends State<AuthStepSecond> {
  PhoneContact? contact1;
  PhoneContact? contact2;
  DictionModel? relation1;
  DictionModel? relation2;

  List<DictionModel> _relationList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestDic();
    });
  }

  /// 获取联系人关系数字字典
  Future<void> requestDic() async {
    ToastUtils.showLoading();
    try {
      final tmp = await DioUtils.instance.client
          .requestDictData(tenantId: '1', body: {'dictType': 'contact_type'});
      _relationList = tmp.data;
    } finally {
      ToastUtils.cancelToast();
    }
  }

  /// 选择联系人电话
  void selectContact(bool isFirst) {
    Permission.contacts.request().then((PermissionStatus status) {
      if (status.isGranted) {
        FlutterContactPicker.pickPhoneContact().then((PhoneContact contact) {
          setState(() {
            if (isFirst) {
              contact1 = contact;
            } else {
              contact2 = contact;
            }
          });
        });
      } else {
        ToastUtils.show('Please allow the app to access your contact list');
      }
    });
  }

  /// 显示联系人关系弹窗
  void _showPopup(bool isFirst, DictionModel? select) {
    if (_relationList.isEmpty) {
      ToastUtils.show('Please wait for the data to be loaded');
      return;
    }
    showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26), topRight: Radius.circular(26))),
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                  color: context.backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26))),
              child: ListView(
                  children: ListTile.divideTiles(
                      context: context,
                      tiles: _relationList.map((e) {
                        return ListTile(
                          splashColor: Colours.app_main_bg,
                          title: Text(e.label!),
                          selected: select?.value == e.value,
                          onTap: () {
                            setState(() {
                              isFirst ? relation1 = e : relation2 = e;
                            });
                            Navigator.pop(context);
                          },
                        );
                      })).toList()),
            ),
          );
        });
  }

  Future<void> _verify() async {
    if (contact1 == null) {
      ToastUtils.show('Contact 1 phone can not be empty');
      return;
    }
    if (contact2 == null) {
      ToastUtils.show('Contact 2 phone can not be empty');
      return;
    }
    if (relation1 == null) {
      ToastUtils.show('Contact 1 RelationShip can not be empty');
      return;
    }
    if (relation2 == null) {
      ToastUtils.show('Contact 2 RelationShip can not be empty');
      return;
    }

    final params = {
      'contact1': contact1!.fullName,
      'contact1Relation': relation1?.value,
      'contact1Number':
          (contact1?.phoneNumber?.number ?? '').clearSymbolFormat(),
      'contact2': contact2!.fullName,
      'contact2Relation': relation2?.value,
      'contact2Number':
          (contact2?.phoneNumber?.number ?? '').clearSymbolFormat(),
    };

    ToastUtils.showLoading();

    try {
      final result = await DioUtils.instance.client
          .uploadEmergencyContacts(tenantId: '1', body: params);
      if (result.code == 0) {
        if (context.mounted) {
          final isBack = await Navigator.maybePop(context);
          if (!isBack) {
            await SystemNavigator.pop();
          }
        }
      }
    } finally {
      ToastUtils.cancelToast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'Emergency Contacts(2/4)',
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
                SelectContactItem(
                    title: 'Contact 1',
                    phone: contact1?.phoneNumber?.number ?? '',
                    relation: relation1,
                    selectRelation: () => _showPopup(true, relation1),
                    selectContact: () => selectContact(true)),
                Gaps.vGap15,
                SelectContactItem(
                    title: 'Contact 2',
                    phone: contact2?.phoneNumber?.number ?? '',
                    relation: relation2,
                    selectRelation: () => _showPopup(false, relation2),
                    selectContact: () => selectContact(false)),
                const Expanded(child: ColoredBox(color: Colours.bg_gray_)),
                MyDecoratedButton(onPressed: _verify, text: 'Next', radius: 24),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}

class SelectContactItem extends StatelessWidget {
  const SelectContactItem(
      {super.key,
      this.phone,
      required this.title,
      this.relation,
      required this.selectContact,
      required this.selectRelation});

  final String? phone;
  final String title;
  final DictionModel? relation;
  final VoidCallback selectContact;
  final VoidCallback selectRelation;

  @override
  Widget build(BuildContext context) {
    return MyCard(
        radius: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colours.app_main,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text(title,
                  style: const TextStyle(
                      color: Colors.white, fontSize: Dimens.font_sp14)),
            ),
            SelectedItem(
                title: 'Relationship',
                content: relation != null
                    ? relation!.label.nullSafe
                    : 'Selection relation',
                style: TextStyle(
                    color:
                        relation != null ? Colours.text : Colours.text_regular),
                showLine: true,
                onTap: selectRelation),
            SelectedItem(
                title: 'Phone Number',
                content: phone.nullSafe.isNotEmpty ? phone! : 'Selection phone',
                style: TextStyle(
                    color: phone.nullSafe.isNotEmpty
                        ? Colours.text
                        : Colours.text_regular),
                onTap: selectContact),
          ],
        ));
  }
}
