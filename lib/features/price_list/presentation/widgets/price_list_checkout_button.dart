import 'package:flutter/material.dart';
import '../../../../core/utils/size_config.dart';

class PriceListCheckoutButton extends StatelessWidget {
  final double totalPrice;
  final VoidCallback? onCheckout;

  const PriceListCheckoutButton({
    super.key,
    required this.totalPrice,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.w(4)),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: ElevatedButton(
          onPressed: totalPrice > 0 ? onCheckout : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE81923),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.h(1.5),
            ),
            elevation: 5,
            shadowColor: Colors.black.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBackgroundColor: Colors.grey[300],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart_outlined),
              SizedBox(width: SizeConfig.w(2)),
              Text(
                'إتمام الطلب (${totalPrice.toStringAsFixed(0)} جنيه)',
                style: TextStyle(
                  fontSize: SizeConfig.sp(8),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

