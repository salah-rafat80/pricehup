import 'package:dartz/dartz.dart';
import 'package:pricehup/core/error/failures.dart';
import 'package:pricehup/features/price_list/domain/entities/category.dart';
import 'package:pricehup/features/price_list/domain/entities/product_item.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<ProductItem>>> getPriceListDetails(
    int priceListId,
  );
}
