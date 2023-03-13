import 'package:flutter/material.dart';
import 'package:shine_credit/res/colors.dart';
import 'package:shine_credit/res/styles.dart';
import 'package:shine_credit/utils/other_utils.dart';

class HeaderBar extends StatefulWidget {
  const HeaderBar({super.key, required this.callback});

  final GenericTypesCallback<bool> callback;

  @override
  State<HeaderBar> createState() => _HeaderBarState();
}

class _HeaderBarState extends State<HeaderBar> {
  bool _isLogin = true;

  late var width = MediaQuery.of(context).size.width;

  void _changeLogin(bool islogin) {
    if (_isLogin != islogin) {
      setState(() {
        _isLogin = islogin;
        widget.callback(islogin);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 50,
          ),
          Positioned(
            width: width,
            top: -16,
            child: Container(
              height: 25,
              decoration: const BoxDecoration(
                  color: Colours.text_disabled,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
            ),
          ),
          Positioned(
            width: width,
            bottom: -16,
            child: Container(
              height: 25,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
            ),
          ),
          Positioned(
            top: -16,
            child: SizedBox(
              // clipBehavior: Clip.hardEdge,
              width: width,
              height: 50,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _changeLogin(true),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: _isLogin
                              ? const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16)))
                              : const BoxDecoration(
                                  color: Colours.text_disabled,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16))),
                          child: TextButton(
                            onPressed: () => _changeLogin(true),
                            style: ButtonStyle(overlayColor:
                                MaterialStateProperty.resolveWith((states) {
                              return Colors.white.withOpacity(0.12);
                            })),
                            child: Center(
                              child: Text('Log In',
                                  style: TextStyles.textBold18.copyWith(
                                      color: _isLogin
                                          ? Colours.text
                                          : Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _changeLogin(false),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: _isLogin
                              ? const BoxDecoration(
                                  color: Colours.text_disabled,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomLeft: Radius.circular(16)))
                              : const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      topLeft: Radius.circular(16))),
                          child: TextButton(
                            onPressed: () => _changeLogin(false),
                            style: ButtonStyle(overlayColor:
                                MaterialStateProperty.resolveWith((states) {
                              return Colors.white.withOpacity(0.12);
                            })),
                            child: Center(
                              child: Text('Sign Up',
                                  style: TextStyles.textBold18.copyWith(
                                      color: _isLogin
                                          ? Colors.white
                                          : Colours.text)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: _isLogin ? (width / 4.0 - 15) : (width / 4.0 * 3 - 15),
            bottom: 12,
            child: Container(
                decoration: const ShapeDecoration(
                  shape: StadiumBorder(),
                  color: Colours.app_main,
                ),
                child: const SizedBox(width: 30, height: 4)),
          )
        ],
      ),
    );
  }
}
