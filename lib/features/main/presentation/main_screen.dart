import 'package:flutter/material.dart';
import 'package:pricehup/core/constants/custombottomnav_bar.dart';
import 'package:pricehup/features/price_list/presentation/screens/price_list_screen.dart';
import 'package:pricehup/features/home/presentation/screens/home_screen.dart';
import 'package:pricehup/core/utils/size_config.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // تعريف الصفحات
  final List<Widget> _pages = [
    const HomeScreen(), // Index 0: الرئيسية
    const PriceListScreen(), // Index 1: الأسعار
    const Center(child: Text('طلباتي')), // Index 2: طلباتي
    const Center(child: Text('الإشعارات')), // Index 3: الإشعارات
    const Center(child: Text('الملف')), // Index 4: الملف
  ];

  // دالة لتغيير الاندكس (تستخدم للناف بار وللأزرار العلوية أيضاً)
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getAppBarTitle(int index) {
    if (index == 0) {
      return Image.asset(
        'assets/Image (FAP Logo).png',
        height: 35,
        fit: BoxFit.contain,
      );
    }

    String title = '';
    switch (index) {
      case 1:
        title = 'عروض الأسعار - مصر';
        break;
      case 2:
        title = 'طلباتي';
        break;
      case 3:
        title = 'الإشعارات';
        break;
      case 4:
        title = 'الملف الشخصي';
        break;
    }

    return Text(
      title,
      style: const TextStyle(
        color: Colors.black, // أو اللون المناسب لتصميمك
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: 'Tajawal',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white, // يفضل تثبيت لون الخلفية
          elevation: 0, // إزالة الظل ليبدو التصميم نظيفاً (اختياري)
          // 1. زر الإشعارات (تم ربطه بالتاب رقم 3)
          leading: Stack(
            children: [
              Center(
                child: IconButton(
                  icon: Icon(
                    _selectedIndex == 3
                        ? Icons.notifications
                        : Icons.notifications_outlined,
                    color: _selectedIndex == 3 ? Colors.red : Colors.grey,
                  ),
                  onPressed: () => _onItemTapped(3), // يذهب لتاب الإشعارات
                ),
              ),
              // نقطة التنبيه الحمراء (Badge)
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),

          // 2. اللوجو في المنتصف
          centerTitle: true,
          // 2. اللوجو أو العنوان في المنتصف
          // centerTitle: true,
          title: _getAppBarTitle(_selectedIndex),

          // 3. زر الملف الشخصي (تم ربطه بالتاب رقم 4)
          actions: [
            IconButton(
              icon: Icon(
                _selectedIndex == 4 ? Icons.person : Icons.person_outline,
                color: _selectedIndex == 4 ? Colors.red : Colors.grey,
              ),
              onPressed: () => _onItemTapped(4), // يذهب لتاب الملف
            ),
            const SizedBox(width: 8),
          ],
        ),

        // استخدام IndexedStack للحفاظ على حالة الصفحات عند التنقل
        body: SafeArea(
          child: IndexedStack(index: _selectedIndex, children: _pages),
          // child: Center(child: Text("Testing Main Screen")),
        ),

        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
