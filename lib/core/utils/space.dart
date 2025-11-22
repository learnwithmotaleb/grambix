import 'package:flutter/material.dart';
import 'dimensions.dart';

class Space {
  static SizeHeightModel height = SizeHeightModel(
    btnInputTitleAndBox:
        SizedBox(height: Dimensions.spaceBetweenInputTitleAndBox),
    betweenInputBox: SizedBox(height: Dimensions.spaceBetweenInputBox),
    v5: SizedBox(height: Dimensions.heightSize * 0.5),
    v10: SizedBox(height: Dimensions.heightSize),
    v15: SizedBox(height: Dimensions.heightSize * 1.5),
    v20: SizedBox(height: Dimensions.heightSize * 2),
    v25: SizedBox(height: Dimensions.heightSize * 2.5),
    v30: SizedBox(height: Dimensions.heightSize * 3),
    v40: SizedBox(height: Dimensions.heightSize * 4),
  );

  static SizeWidthModel width = SizeWidthModel(
    v5: SizedBox(width: Dimensions.widthSize * 0.5),
    v10: SizedBox(width: Dimensions.widthSize),
    v15: SizedBox(width: Dimensions.widthSize * 1.5),
    v20: SizedBox(width: Dimensions.widthSize * 2),
    v25: SizedBox(width: Dimensions.widthSize * 2.5),
    v30: SizedBox(width: Dimensions.widthSize * 3),
    v40: SizedBox(width: Dimensions.widthSize * 4),
  );
}

class SizeHeightModel {
  final SizedBox btnInputTitleAndBox;
  final SizedBox betweenInputBox;
  final SizedBox v5;
  final SizedBox v10;
  final SizedBox v15;
  final SizedBox v20;
  final SizedBox v25;
  final SizedBox v30;
  final SizedBox v40;

  SizedBox add(double value) => SizedBox(height: value);

  SizeHeightModel({
    required this.btnInputTitleAndBox,
    required this.betweenInputBox,
    required this.v5,
    required this.v10,
    required this.v15,
    required this.v20,
    required this.v25,
    required this.v30,
    required this.v40,
  });
}

class SizeWidthModel {
  final SizedBox v5;
  final SizedBox v10;
  final SizedBox v15;
  final SizedBox v20;
  final SizedBox v25;
  final SizedBox v30;
  final SizedBox v40;

  SizedBox add(double value) => SizedBox(width: value);

  SizeWidthModel({
    required this.v5,
    required this.v10,
    required this.v15,
    required this.v20,
    required this.v25,
    required this.v30,
    required this.v40,
  });
}

MainAxisAlignment mainStart = MainAxisAlignment.start;
MainAxisAlignment mainCenter = MainAxisAlignment.center;
MainAxisAlignment mainEnd = MainAxisAlignment.end;
MainAxisAlignment mainSpaceBet = MainAxisAlignment.spaceBetween;
MainAxisSize mainMax = MainAxisSize.max;
MainAxisSize mainMin = MainAxisSize.min;
CrossAxisAlignment crossStart = CrossAxisAlignment.start;
CrossAxisAlignment crossCenter = CrossAxisAlignment.center;
CrossAxisAlignment crossEnd = CrossAxisAlignment.end;
CrossAxisAlignment crossStretch = CrossAxisAlignment.stretch;

// Floating Action Button Location
FloatingActionButtonLocation centerDocked =
    FloatingActionButtonLocation.centerDocked;
FloatingActionButtonLocation centerFloat =
    FloatingActionButtonLocation.centerFloat;
