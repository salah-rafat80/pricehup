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
        appBar: AppBar(title: const Text('الصفحة الرئيسية')),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.w(6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              size: isLandscape ? SizeConfig.w(18) : SizeConfig.w(25),
                              color: const Color(0xFFD4AF37),
                            ),
                            SizedBox(height: isLandscape ? SizeConfig.h(2) : SizeConfig.h(3)),
                            Text(
                              'مرحباً بك في PriceHup',
                              style: TextStyle(
                                fontSize: SizeConfig.sp(10),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: SizeConfig.h(2)),
                            Text(
                              'تطبيقك المفضل لعرض قوائم الأسعار',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: SizeConfig.sp(10),
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: isLandscape ? SizeConfig.h(4) : SizeConfig.h(6)),
                            SizedBox(
                              width: isLandscape ? constraints.maxWidth * 0.5 : double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.h(2.5),
                                    horizontal: SizeConfig.w(4),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const PriceListScreen(),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.list_alt, size: SizeConfig.w(6)),
                                label: Text(
                                  'قائمة الأسعار',
                                  style: TextStyle(fontSize: SizeConfig.sp(10)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
