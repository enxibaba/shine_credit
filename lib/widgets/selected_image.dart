import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shine_credit/utils/other_utils.dart';

import '../res/colors.dart';
import '../utils/device_utils.dart';
import '../utils/image_utils.dart';
import '../utils/theme_utils.dart';
import '../utils/toast_uitls.dart';

class SelectedImage extends StatefulWidget {
  const SelectedImage({
    super.key,
    this.url,
    this.heroTag,
    this.size = 80.0,
  });

  final String? url;
  final String? heroTag;
  final double size;

  @override
  SelectedImageState createState() => SelectedImageState();
}

class SelectedImageState extends State<SelectedImage> {
  final ImagePicker _picker = ImagePicker();
  ImageProvider? _imageProvider;
  XFile? pickedFile;

  Future<void> _getImage() async {
    try {
      pickedFile =
          await _picker.pickImage(source: ImageSource.gallery, maxWidth: 800);
      if (pickedFile != null) {
        _imageProvider = FileImage(File(pickedFile!.path));
      } else {
        _imageProvider = null;
      }
      setState(() {});
    } catch (e) {
      if (e is MissingPluginException) {
        ToastUtils.show('当前平台暂不支持！');
      } else {
        ToastUtils.show('没有权限，无法打开相册！');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorFilter colorFilter = ColorFilter.mode(
        ThemeUtils.isDark(context)
            ? Colours.dark_unselected_item_color
            : Colours.text_gray,
        BlendMode.srcIn);

    Widget image = Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        // 图片圆角展示
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
            image: _imageProvider ??
                ImageUtils.getImageProvider(widget.url,
                    holderImg: 'store/icon_zj'),
            fit: BoxFit.cover,
            colorFilter: _imageProvider == null && widget.url.nullSafe.isEmpty
                ? colorFilter
                : null),
      ),
    );

    if (widget.heroTag != null && !Device.isWeb) {
      image = Hero(tag: widget.heroTag!, child: image);
    }

    return Semantics(
      label: '选择图片',
      hint: '跳转相册选择图片',
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: _getImage,
        child: image,
      ),
    );
  }
}
