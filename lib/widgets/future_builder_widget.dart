// 用FlutterBuilder封装一个Widget, Widget 有如下要求
//   1、支持提供一个 loadingBuilder 用于显示加载中的状态, 如果没有提供则使用默认的 CircularProgressIndicator
//   2、支持传入一个 futureFunc 用于获取数据
//   3、支持提供一个 errorBuilder 用于显示加载失败的状态, 如果没有提供则使用默认的 Text(snapshot.error.toString())， 和一个 Retry 按钮用于重新请求网络数据
//   4、支持提供一个 emptyBuilder 用于显示数据为空的状态, 如果没有提供则使用默认的 Text('No Data')
//   4、支持提供一个 dispose 用于销毁状态

import 'package:flutter/material.dart';

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
  _FutureBuilderWidgetState<T> createState() => _FutureBuilderWidgetState<T>();
}

class _FutureBuilderWidgetState<T> extends State<FutureBuilderWidget<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.futureFunc();
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
              const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return widget.errorBuilder?.call(context, snapshot.error!, _retry) ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.error.toString()),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _retry,
                    child: const Text('Retry'),
                  ),
                ],
              );
        } else if (!snapshot.hasData) {
          return widget.emptyBuilder?.call(context) ?? const Text('No Data');
        } else {
          return widget.builder(context, snapshot.data as T);
        }
      },
    );
  }

  void _retry() {
    setState(() {
      _future = widget.futureFunc();
    });
  }
}
