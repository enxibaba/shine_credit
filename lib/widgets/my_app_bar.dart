import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shine_credit/widgets/load_image.dart';
import '../res/colors.dart';
import '../res/dimens.dart';
import '../res/gaps.dart';
import '../utils/theme_utils.dart';
import 'my_button.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {super.key,
      this.backgroundColor,
      this.title = '',
      this.centerTitle = '',
      this.actionName = '',
      this.backImg = 'ic_back_black',
      this.backImgColor,
      this.actionWidget,
      this.onPressed,
      this.isBack = true});

  final Color? backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final Color? backImgColor;
  final String actionName;
  final VoidCallback? onPressed;
  final Widget? actionWidget;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = backgroundColor ?? context.backgroundColor;

    final SystemUiOverlayStyle overlayStyle =
        ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    final Widget action = actionWidget != null
        ? Positioned(
            right: 0.0,
            child: actionWidget!,
          )
        : actionName.isNotEmpty
            ? Positioned(
                right: 0.0,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    buttonTheme: const ButtonThemeData(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      minWidth: 60.0,
                    ),
                  ),
                  child: MyButton(
                    key: const Key('actionName'),
                    fontSize: Dimens.font_sp14,
                    minWidth: null,
                    text: actionName,
                    textColor:
                        context.isDark ? Colours.dark_text : Colours.text,
                    backgroundColor: Colors.transparent,
                    onPressed: onPressed,
                  ),
                ),
              )
            : Gaps.empty;

    final Widget back = isBack
        ? IconButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              final isBack = await Navigator.maybePop(context);
              if (!isBack) {
                await SystemNavigator.pop();
              }
            },
            tooltip: 'Back',
            padding: const EdgeInsets.all(12.0),
            icon: LoadAssetImage(backImg),
          )
        : Gaps.empty;

    final Widget titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment:
            centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
        child: Text(
          title.isEmpty ? centerTitle : title,
          style: const TextStyle(
            fontSize: Dimens.font_sp16,
            color: Colors.white,
          ),
        ),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Material(
        color: bgColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              titleWidget,
              back,
              action,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
