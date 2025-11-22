import 'package:flutter/material.dart';

extension SupperEdgeInsets on num {
  /// EdgeInsets
  EdgeInsets get edgeHorizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get edgeVertical => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get edgeTop => EdgeInsets.only(top: toDouble());
  EdgeInsets get edgeBottom => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get edgeLeft => EdgeInsets.only(left: toDouble());
  EdgeInsets get edgeRight => EdgeInsets.only(right: toDouble());

  /// BorderRadius
  BorderRadius get radiusEx => BorderRadius.circular(toDouble());
  BorderRadius get radiusTopEx => BorderRadius.only(
    topLeft: Radius.circular(toDouble()),
    topRight: Radius.circular(toDouble()),
  );
}
