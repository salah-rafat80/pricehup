import '../entities/category.dart';
import '../repositories/category_repository.dart';

/// Use case for getting all categories
class GetCategories {
  final CategoryRepository repository;

  GetCategories(this.repository);

  /// Execute the use case
  Future<List<Category>> call() async {
    return await repository.getCategories();
  }
}

