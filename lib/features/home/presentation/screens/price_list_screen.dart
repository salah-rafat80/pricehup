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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('قائمة الأسعار')),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (homeState.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (homeState.error != null) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.w(6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: isLandscape
                                  ? SizeConfig.w(8)
                                  : SizeConfig.w(14),
                              color: Colors.red,
                            ),
                            SizedBox(height: SizeConfig.h(2)),
                            Text(
                              homeState.error!,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: SizeConfig.sp(4.5)),
                            ),
                            SizedBox(height: SizeConfig.h(2)),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.h(2),
                                  horizontal: SizeConfig.w(6),
                                ),
                              ),
                              onPressed: () => ref
                                  .read(homeViewModelProvider.notifier)
                                  .loadCategories(),
                              child: Text(
                                'إعادة المحاولة',
                                style: TextStyle(fontSize: SizeConfig.sp(4.5)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              if (homeState.categories.isEmpty) {
                return Center(
                  child: Text(
                    'لا توجد فئات متاحة',
                    style: TextStyle(fontSize: SizeConfig.sp(5)),
                  ),
                );
              }

              // استخدم ListView دائمًا بدل GridView
              return ListView.separated(
                padding: EdgeInsets.all(SizeConfig.w(6)),
                itemCount: homeState.categories.length,
                separatorBuilder: (_, __) => SizedBox(height: SizeConfig.h(2)),
                itemBuilder: (context, index) {
                  final category = homeState.categories[index];
                  return _buildCategoryCard(
                    context,
                    category,
                    isLandscape,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, category, bool isLandscape) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.w(5),
          vertical: isLandscape ? SizeConfig.h(1.5) : SizeConfig.h(2.5),
        ),
        leading: Container(
          padding: EdgeInsets.all(SizeConfig.w(3)),
          decoration: BoxDecoration(

            color: const Color(0xFFD4AF37).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(SizeConfig.w(3)),
          ),
          child: Icon(
            Icons.picture_as_pdf,
            color: const Color(0xFFD4AF37),
            size: isLandscape ? SizeConfig.w(6) : SizeConfig.w(8),
          ),
        ),
        title: Text(
          category.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.sp(10),
          ),
        ),
        subtitle: Text(
          'اضغط لعرض الأسعار',
          style: TextStyle(fontSize: SizeConfig.sp(7)),
        ),
        trailing: Icon(Icons.arrow_back_ios, size: SizeConfig.w(5)),
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
      ),
    );
  }
}
