import 'package:flutter/material.dart';
import '../../../../core/utils/size_config.dart';

class PriceListSummaryBar extends StatelessWidget {
  final int selectedItemsCount;
  final double totalPrice;

  const PriceListSummaryBar({
    super.key,
    required this.selectedItemsCount,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.h(0.5),
        horizontal: SizeConfig.w(4),
      ),
      color: const Color(0xFFFFF0F0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$selectedItemsCount صنف محدد',
              style: TextStyle(
                fontSize: SizeConfig.sp(7),
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
                fontFamily: 'Tajawal',
              ),
            ),
            Text(
              '${totalPrice.toStringAsFixed(0)} جنيه',
              style: TextStyle(
                fontSize: SizeConfig.sp(8),
                fontWeight: FontWeight.bold,
                color: const Color(0xFFE81923),
                fontFamily: 'Tajawal',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

