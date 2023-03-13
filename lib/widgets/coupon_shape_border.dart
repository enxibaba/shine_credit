// ignore_for_file: avoid_field_initializers_in_const_classes

import 'dart:math';

import 'package:flutter/material.dart';

class CouponShapeBorder extends ShapeBorder {
  const CouponShapeBorder({
    this.circleSize = 12,
    this.topMargin = 65,
    this.dashColor = const Color(0xFFEEEEEE),
    this.radiusBorder = 0,
  });
  final double circleSize;
  final double topMargin;
  final Color dashColor;
  final double dashWidth = 6;
  final double dashGap = 12;
  final double dashLinePadding = 6;
  final double radiusBorder;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();

    if (radiusBorder == 0) {
      path.addRect(rect);
    } else {
      path.addRRect(BorderRadius.circular(radiusBorder)
          .resolve(textDirection)
          .toRRect(rect));
    }
    _formHoldLeft(path, rect);
    _formHoldRight(path, rect);
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  void _formHoldLeft(Path path, Rect rect) {
    path.addArc(
        Rect.fromCenter(
          center: Offset(0, topMargin),
          width: circleSize,
          height: circleSize,
        ),
        pi * 3 / 2,
        pi);
  }

  void _formHoldRight(Path path, Rect rect) {
    path.addArc(
        Rect.fromCenter(
          center: Offset(rect.width, topMargin),
          width: circleSize,
          height: circleSize,
        ),
        pi / 2,
        pi);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..color = dashColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    _drawDashLine(
        canvas,
        Offset(circleSize / 2 + dashLinePadding, topMargin),
        Offset(rect.width - circleSize / 2 - dashLinePadding, topMargin),
        paint);
  }

  void _drawDashLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    double currentLength = start.dx;
    while (currentLength <= end.dx) {
      Offset lineStart = Offset(currentLength, start.dy);
      Offset lineEnd = Offset(currentLength + dashWidth, start.dy);
      canvas.drawLine(lineStart, lineEnd, paint);
      currentLength += dashGap;
    }
  }

  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    throw UnimplementedError();
  }

  @override
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();
}
