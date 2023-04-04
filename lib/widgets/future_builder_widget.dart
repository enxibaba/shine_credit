// 用FlutterBuilder封装一个Widget, Widget 有如下要求
//   1、支持提供一个 loadingBuilder 用于显示加载中的状态, 如果没有提供则使用默认的 CircularProgressIndicator
//   2、支持传入一个 futureFunc 用于获取数据
//   3、支持提供一个 errorBuilder 用于显示加载失败的状态, 如果没有提供则使用默认的 Text(snapshot.error.toString())， 和一个 Retry 按钮用于重新请求网络数据
//   4、支持提供一个 emptyBuilder 用于显示数据为空的状态, 如果没有提供则使用默认的 Text('No Data')
//   4、支持提供一个 dispose 用于销毁状态

import 'package:flutter/cupertino.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/dimens.dart';
import 'package:shine_credit/res/gaps.dart';
import 'package:shine_credit/utils/app_utils.dart';
import 'package:shine_credit/widgets/my_button.dart';

class FutureBuilderWidget<T> extends StatefulWidget {
  const FutureBuilderWidget({
    super.key,
    required this.futureFunc,
    required this.builder,
    this.loadingBuilder,
    this.errorBuilder,
    this.emptyBuilder,
    this.dispose,
  });
  final Future<T> Function() futureFunc;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, Object error, Function() retry)?
      errorBuilder;
  final Widget Function(BuildContext context)? emptyBuilder;
  final void Function()? dispose;

  @override
  FutureBuilderWidgetState<T> createState() => FutureBuilderWidgetState<T>();
}

class FutureBuilderWidgetState<T> extends State<FutureBuilderWidget<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.futureFunc().catchError(_handleError);
  }

  @override
  void dispose() {
    widget.dispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingBuilder?.call(context) ??
              Container(
                alignment: Alignment.center,
                color: Colours.bg_gray_,
                child: Column(
                  children: const [
                    Spacer(),
                    Gaps.vGap16,
                    CupertinoActivityIndicator(radius: 24.0),
                    Gaps.vGap16,
                    Text('Please wait a moment...',
                        style: TextStyle(
                            fontSize: Dimens.font_sp16,
                            color: Colours.text_gray)),
                    Spacer()
                  ],
                ),
              );
        } else if (snapshot.hasError) {
          return Center(
            child: widget.errorBuilder?.call(context, snapshot.error!, retry) ??
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gaps.vGap16,
                    const Text('Some Error, Please Retry',
                        style: TextStyle(fontSize: 16)),
                    Gaps.vGap16,
                    MyDecoratedButton(
                      radius: 24,
                      minWidth: 100,
                      onPressed: retry,
                      text: 'Retry',
                    ),
                  ],
                ),
          );
        } else if (!snapshot.hasData) {
          if (widget.emptyBuilder == null) {
            return Center(
              child:
                  widget.errorBuilder?.call(context, snapshot.error!, retry) ??
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gaps.vGap16,
                          const Text('Some Error, Please Retry',
                              style: TextStyle(fontSize: 16)),
                          Gaps.vGap16,
                          MyDecoratedButton(
                            radius: 24,
                            minWidth: 100,
                            onPressed: retry,
                            text: 'Retry',
                          ),
                        ],
                      ),
            );
          }
          return widget.emptyBuilder!.call(context);
        } else {
          return widget.builder(context, snapshot.data as T);
        }
      },
    );
  }

  void retry() {
    setState(() {
      _future = widget.futureFunc().catchError(_handleError);
    });
  }

  void _handleError(e) {
    AppUtils.log.e('Error: $e');
  }
}
