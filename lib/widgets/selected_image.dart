import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shine_credit/net/http_utils.dart';
import 'package:shine_credit/utils/other_utils.dart';

import '../utils/device_utils.dart';
import '../utils/image_utils.dart';
import '../utils/toast_uitls.dart';

class SelectedImage extends StatefulWidget {
  const SelectedImage({
    super.key,
    this.url,
    this.size = const Size(103, 65),
    this.heroTag,
    this.child,
    this.source,
    this.filePathCallback,
  });

  final String? url;
  final String? heroTag;
  final Widget? child;
  final ImageSource? source;
  final Size size;
  final GenericTypesCallback<String>? filePathCallback;

  @override
  SelectedImageState createState() => SelectedImageState();
}

class SelectedImageState extends State<SelectedImage> {
  final ImagePicker _picker = ImagePicker();
  ImageProvider? _imageProvider;
  XFile? pickedFile;

  Future<void> _getImage() async {
    try {
      pickedFile = await _picker.pickImage(
          source: widget.source ?? ImageSource.gallery,
          maxWidth: 1920,
          maxHeight: 1080,
          imageQuality: 90);
      if (pickedFile != null) {
        setState(() {
          _imageProvider = FileImage(File(pickedFile!.path));
        });

        /// 如过有回调，则上传图片
        if (widget.filePathCallback != null) {
          _uploadImage(pickedFile!);
        }
      }
    } catch (e) {
      if (e is MissingPluginException) {
        ToastUtils.show('当前平台暂不支持！');
      } else {
        ToastUtils.show(
            '没有权限，无法打开${widget.source == ImageSource.camera ? '相机' : '相册'}！');
      }
    }
  }

  Future<void> _uploadImage(XFile file) async {
    ToastUtils.showLoading(msg: 'uploading...');
    final image = File(file.path);
    try {
      final data = await DioUtils.instance.client
          .uploadFileAuth(path: 'images/kyc/', file: image);
      if (data.data != null) {
        ToastUtils.show('upload success');
        if (widget.filePathCallback != null) {
          widget.filePathCallback!(data.data.fileUrl.nullSafe);
        }
      } else {
        ToastUtils.cancelToast();
        if (widget.filePathCallback != null) {
          widget.filePathCallback!('');
        }
      }
    } catch (e) {
      ToastUtils.cancelToast();
      if (widget.filePathCallback != null) {
        widget.filePathCallback!('');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final ColorFilter colorFilter = ColorFilter.mode(
    //     ThemeUtils.isDark(context)
    //         ? Colours.dark_unselected_item_color
    //         : Colours.text_gray,
    //     BlendMode.srcIn);

    final bool hasImage =
        widget.url.nullSafe.isNotEmpty || _imageProvider != null;

    Widget image = Container(
      width: widget.size.width,
      height: widget.size.height,
      decoration: hasImage
          ? BoxDecoration(
              // 图片圆角展示
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                  image: _imageProvider ??
                      ImageUtils.getImageProvider(widget.url,
                          holderImg: 'store/icon_zj'),
                  fit: BoxFit.cover)
              // colorFilter:
              //     _imageProvider == null && widget.url.nullSafe.isEmpty
              //         ? colorFilter
              //         : null),
              )
          : null,
      child: hasImage ? null : widget.child,
    );

    if (widget.heroTag != null && !Device.isWeb) {
      image = Hero(tag: widget.heroTag!, child: image);
    }

    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: _getImage,
      child: image,
    );
  }
}
