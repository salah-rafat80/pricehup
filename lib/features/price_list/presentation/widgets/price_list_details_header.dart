import 'package:flutter/material.dart';
import 'package:pricehup/core/utils/size_config.dart';

class PriceListDetailsHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  const PriceListDetailsHeader({
    super.key,
    required this.title,
    required this.onBack,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(SizeConfig.w(2)),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBack),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SizeConfig.sp(7),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(4)),
            height: SizeConfig.h(5),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'ابحث في الاسم، الكود، الاتجاه...',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: SizeConfig.sp(7),
                  fontFamily: 'Tajawal',
                ),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey[500]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
