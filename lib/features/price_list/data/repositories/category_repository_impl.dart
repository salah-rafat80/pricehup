import 'package:dartz/dartz.dart';
import 'package:pricehup/core/error/failures.dart';
import 'package:pricehup/features/price_list/data/datasources/price_list_remote_data_source.dart';
import 'package:pricehup/features/price_list/domain/entities/category.dart';
import 'package:pricehup/features/price_list/domain/entities/product_item.dart';
import 'package:pricehup/features/price_list/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final PriceListRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final priceListModels = await remoteDataSource.getPriceLists();
      final categories = priceListModels
          .map(
            (model) => Category(
              id: model.id,
              name: model.nameAr ?? '',
              pdfAssetPath: '', // Assuming no PDF path in new API
              message: model.messageAr ?? '',
              startDate: model.startDate ?? '',
              endDate: model.endDate ?? '',
              pageCount: 0,
            ),
          )
          .toList();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductItem>>> getPriceListDetails(
    int priceListId,
  ) async {
    try {
      final productModels = await remoteDataSource.getPriceListDetails(
        priceListId,
      );
      return Right(productModels);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
