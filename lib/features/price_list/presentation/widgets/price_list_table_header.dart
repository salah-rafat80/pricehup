import 'package:flutter/material.dart';
import 'package:pricehup/core/utils/size_config.dart';

class PriceListTableHeader extends StatelessWidget {
  const PriceListTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.h(1),
        horizontal: SizeConfig.w(1),
      ),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'الاتجاه',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: SizeConfig.sp(5),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1976D2),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(width: 1, height: 20, color: Colors.grey[300]),
          Expanded(
            flex: 5,
            child: Text(
              'صنف',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: SizeConfig.sp(6),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1976D2),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(width: 1, height: 20, color: Colors.grey[300]),
          Expanded(
            flex: 2,
            child: Text(
              'السعر',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: SizeConfig.sp(6),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1976D2),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(width: 1, height: 20, color: Colors.grey[300]),
          Expanded(
            flex: 2,
            child: Text(
              'الكمية',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: SizeConfig.sp(6),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1976D2),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
