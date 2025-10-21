import '../entities/category.dart';

/// Abstract repository for category operations
abstract class CategoryRepository {
  /// Get all available categories
  Future<List<Category>> getCategories();
}

