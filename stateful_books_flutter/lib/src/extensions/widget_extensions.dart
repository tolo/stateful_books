import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Center center({double? widthFactor, double? heightFactor}) => Center(widthFactor: widthFactor, heightFactor: heightFactor, child: this);

  Padding padding({EdgeInsetsGeometry? padding, double? all, double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0}) {
    if (padding == null && all != null) {
      padding = EdgeInsets.all(all);
    }
    return Padding(padding: padding ?? EdgeInsets.only(left: left, top: top, right: right, bottom: bottom), child: this);
  }

  Padding paddingTRB(double left, double top, double right, double bottom) {
    return Padding(padding: EdgeInsets.fromLTRB(left, top, right, bottom), child: this);
  }

  Padding paddingSymmetric({double vertical = 0, double horizontal = 0}) {
    return Padding(padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal), child: this);
  }
}
