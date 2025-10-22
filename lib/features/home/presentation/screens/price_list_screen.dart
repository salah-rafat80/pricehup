import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/size_config.dart';
import '../providers/home_providers.dart';
import 'pdf_viewer_screen.dart';

/// Price list screen showing all categories
class PriceListScreen extends ConsumerWidget {
  const PriceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    final homeState = ref.watch(homeViewModelProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('قائمة الأسعار')),
        body: SafeArea(
          child: Column(
            children: [
              // Title at the top
              Padding(
                padding: EdgeInsets.all(SizeConfig.w(4)),
                child: Text(
                  'انتظر الكشف الشهري المطلوب',
                  style: TextStyle(
                    fontSize: SizeConfig.sp(9),
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ),

              // List of monthly reports
              Expanded(
                child: homeState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : homeState.error != null
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(SizeConfig.w(6)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: SizeConfig.w(14),
                                    color: Colors.red,
                                  ),
                                  SizedBox(height: SizeConfig.h(2)),
                                  Text(
                                    homeState.error!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: SizeConfig.sp(8)),
                                  ),
                                  SizedBox(height: SizeConfig.h(2)),
                                  ElevatedButton(
                                    onPressed: () => ref
                                        .read(homeViewModelProvider.notifier)
                                        .loadCategories(),
                                    child: Text('إعادة المحاولة'),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.w(4),
                              vertical: SizeConfig.h(1),
                            ),
                            itemCount: homeState.categories.length,
                            separatorBuilder: (_, __) =>
                                SizedBox(height: SizeConfig.h(2)),
                            itemBuilder: (context, index) {
                              final category = homeState.categories[index];
                              return _buildMonthlyReportCard(context, category);
                            },
                          ),
              ),

              // Bottom notice
              Container(
                margin: EdgeInsets.all(SizeConfig.w(4)),
                padding: EdgeInsets.all(SizeConfig.w(4)),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue[700],
                      size: SizeConfig.w(5),
                    ),
                    SizedBox(width: SizeConfig.w(2)),
                    Text(
                      'يتم تحديث قوائم الأسعار شهرياً',
                      style: TextStyle(
                        fontSize: SizeConfig.sp(8),
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthlyReportCard(BuildContext context, category) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PdfViewerScreen(
              title: category.name,
              pdfAssetPath: category.pdfAssetPath,
            ),
          ),
        );
      },
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
            // PDF Icon with red background
            Container(
              padding: EdgeInsets.all(SizeConfig.w(3)),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.picture_as_pdf,
                color: Colors.red[600],
                size: SizeConfig.w(8),
              ),
            ),
            SizedBox(width: SizeConfig.w(3)),

            // Title and subtitle
            Expanded(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: SizeConfig.sp(9),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: SizeConfig.h(0.5)),
                  Text(
                    'صفحة متاح ${_getPageCount(category.name)}',
                    style: TextStyle(
                      fontSize: SizeConfig.sp(7),
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),

            // Arrow icon
            Icon(
              Icons.arrow_back_ios,
              size: SizeConfig.w(4),
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to simulate page counts (you can replace with actual data)
  String _getPageCount(String categoryName) {
    // This is just a placeholder - replace with actual page counts from your data
    final counts = {
      'كشف شهر مايو 2025': '145',
      'كشف شهر إبريل 2025': '142',
      'كشف شهر مارس 2025': '138',
      'كشف شهر فبراير 2025': '135',
      'كشف شهر يناير 2025': '130',
    };
    return counts[categoryName] ?? '100';
  }
}
