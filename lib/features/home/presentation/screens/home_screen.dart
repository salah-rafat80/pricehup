import 'package:flutter/material.dart';
import 'package:pricehup/core/utils/size_config.dart';

/// Home screen - main dashboard
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(SizeConfig.w(4)),
            child: Text(
              "🥰اعتبرها صفحه حلوه🥰",
              style: TextStyle(
                fontSize: SizeConfig.sp(9),
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
                fontFamily: 'Tajawal',
              ),
            ),
          ),
          SizedBox(height: SizeConfig.h(2)),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(4)),
          //   child: Column(
          //     children: [
          //       _buildMenuItem(
          //         context: context,
          //         title: 'عروض الاسعار',
          //         icon: Icons.description_outlined,
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (_) => const PriceListScreen(),
          //             ),
          //           );
          //         },
          //       ),
          //       SizedBox(height: SizeConfig.h(2)),
          //       _buildMenuItem(
          //         context: context,
          //         title: 'طلباتي ومواقيتي',
          //         icon: Icons.description_outlined,
          //         onTap: () {
          //
          //         },
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  // Widget _buildMenuItem({
  //   required BuildContext context,
  //   required String title,
  //   required IconData icon,
  //   required VoidCallback onTap,
  // }) {
  //   return InkWell(
  //     onTap: onTap,
  //     borderRadius: BorderRadius.circular(12),
  //     child: Container(
  //       padding: EdgeInsets.all(SizeConfig.w(4)),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(12),
  //         border: Border.all(color: Colors.grey[300]!),
  //       ),
  //       child: Row(
  //         children: [
  //           Icon(icon, size: SizeConfig.w(8), color: Colors.grey[700]),
  //           Expanded(
  //             child: Text(
  //               title,
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 fontSize: SizeConfig.sp(9),
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //           SizedBox(width: SizeConfig.w(8)),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
