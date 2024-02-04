//ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// App text style.
enum AppTextStyle {
  regular12(TextStyle(fontSize: 12, height: 1.33)),
  regular14(TextStyle(fontSize: 14, height: 1.40)),
  regular16(TextStyle(fontSize: 16, height: 1.24)),

  medium11(TextStyle(fontSize: 11, height: 1.18, fontWeight: FontWeight.w500)),
  medium14(TextStyle(fontSize: 14, height: 1.40, fontWeight: FontWeight.w500)),
  medium16(TextStyle(fontSize: 16, height: 1.24, fontWeight: FontWeight.w500)),

  semiBold17(TextStyle(fontSize: 17, height: 1.29, fontWeight: FontWeight.w600)),

  bold14(TextStyle(fontSize: 14, height: 1.40, fontWeight: FontWeight.w700)),
  bold16(TextStyle(fontSize: 16, height: 1.24, fontWeight: FontWeight.w700)),
  bold19(TextStyle(fontSize: 19, height: 1.37, fontWeight: FontWeight.w700));

  final TextStyle value;

  const AppTextStyle(this.value);
}
