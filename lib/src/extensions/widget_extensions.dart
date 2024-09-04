import 'package:flutter/widgets.dart';

extension WidgetExtensions on Widget {
  Padding padded(
      {double? all,
      double? left,
      double? top,
      double? right,
      double? bottom,
      double? horizontal,
      double? vertical}) {
    if (all != null) {
      return Padding(padding: EdgeInsets.all(all), child: this);
    } else {
      return Padding(
          padding: EdgeInsets.fromLTRB(
              (left ?? horizontal) ?? 0,
              (top ?? vertical) ?? 0,
              (right ?? horizontal) ?? 0,
              (bottom ?? vertical) ?? 0),
          child: this);
    }
  }

  Center centered({double? widthFactor, double? heightFactor}) =>
      Center(widthFactor: widthFactor, heightFactor: heightFactor, child: this);
}
