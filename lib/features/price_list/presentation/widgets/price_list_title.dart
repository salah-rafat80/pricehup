import 'package:flutter/material.dart';
import 'package:pricehup/core/utils/size_config.dart';

class PriceListTitle extends StatelessWidget {
  const PriceListTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'اختر الكشف الشهري المطلوب',
      style: TextStyle(
        fontSize: SizeConfig.sp(9),
        fontWeight: FontWeight.w500,
        color: Colors.grey[600],
        fontFamily: 'Tajawal',
      ),
    );
  }
}
