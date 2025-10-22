import '../../domain/entities/category.dart';

/// Abstract data source for category local operations
abstract class CategoryLocalDataSource {
  Future<List<Category>> getCategories();
}

/// Implementation of category local data source
/// Provides fake data for demo purposes with real PDF URL
class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  @override
  Future<List<Category>> getCategories() async {
    // Simulate slight delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Using the original PDF URL from ebel-kliniken.com
    const pdfUrl = 'https://fapautoapps.com/jri/report?_repName=DBS/ar/PLAN_PRICE_LIST&_repFormat=pdf&_dataSource=erp&P_ID=2';

    return const [
      Category(
        id: '1',
        name: 'كشف شهر مايو 2025',
        pdfAssetPath: pdfUrl,
      ),
      Category(
        id: '2',
        name: 'كشف شهر إبريل 2025',
        pdfAssetPath: pdfUrl,
      ),
      Category(
        id: '3',
        name: 'كشف شهر مارس 2025',
        pdfAssetPath: pdfUrl,
      ),
      Category(
        id: '4',
        name: 'كشف شهر يناير 2025',
        pdfAssetPath: pdfUrl,
      ),
      Category(
        id: '5',
        name: 'كشف شهر يناير 2025',
        pdfAssetPath: pdfUrl,
      ),
    ];
  }
}
