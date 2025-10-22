import 'package:flutter/material.dart';
import '../../../../core/utils/size_config.dart';
import 'price_list_screen.dart';

/// Home screen - main dashboard
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: Stack(
            children: [
              Center(
                child: IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    // TODO: Navigate to notifications
                  },
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          title: Image.asset(
            'assets/Image (FAP Logo).png',
            height: 40,
            fit: BoxFit.contain,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () {
                // TODO: Navigate to profile
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(SizeConfig.w(4)),
                  child: Text(
                    'الإجراءات السريعة',
                    style: TextStyle(
                      fontSize: SizeConfig.sp(9),
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.h(2)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(4)),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        context: context,
                        title: 'عروض الاسعار',
                        icon: Icons.description_outlined,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PriceListScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: SizeConfig.h(2)),
                      _buildMenuItem(
                        context: context,
                        title: 'طلباتي ومواقيتي',
                        icon: Icons.description_outlined,
                        onTap: () {
                          // TODO: Navigate to orders and appointments
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.w(4)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: SizeConfig.w(8),
              color: Colors.grey[700],
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.sp(9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.w(8)),
          ],
        ),
      ),
    );
  }
}
