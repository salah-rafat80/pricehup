import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricehup/core/utils/size_config.dart';
import 'package:pricehup/core/widgets/common_widgets.dart';
import 'package:pricehup/injection_container.dart';
import 'package:pricehup/features/price_list/domain/entities/product_item.dart';
import 'package:pricehup/features/price_list/presentation/cubit/price_list_details_cubit.dart';
import 'package:pricehup/features/price_list/presentation/widgets/product_item_card.dart';
import 'package:pricehup/features/price_list/presentation/widgets/price_list_details_header.dart';
import 'package:pricehup/features/price_list/presentation/widgets/price_list_summary_bar.dart';
import 'package:pricehup/features/price_list/presentation/widgets/price_list_table_header.dart';
import 'package:pricehup/features/price_list/presentation/widgets/price_list_checkout_button.dart';

class PriceListDetailsScreen extends StatefulWidget {
  final String title;
  final int priceListId;

  const PriceListDetailsScreen({
    super.key,
    required this.title,
    required this.priceListId,
  });

  @override
  State<PriceListDetailsScreen> createState() => _PriceListDetailsScreenState();
}

class _PriceListDetailsScreenState extends State<PriceListDetailsScreen> {
  final Map<int, int> _selectedQuantities = {};
  List<ProductItem> _allItems = [];
  List<ProductItem> _filteredItems = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      final trimmedQuery = query.trim();
      if (trimmedQuery.isEmpty) {
        _filteredItems = _allItems;
      } else {
        _filteredItems = _allItems.where((item) {
          final searchLower = trimmedQuery.toLowerCase();
          return item.nameAr.toLowerCase().contains(searchLower) ||
              item.itemCode.toLowerCase().contains(searchLower) ||
              (item.itemSide?.toLowerCase().contains(searchLower) ?? false) ||
              item.nameEn.toLowerCase().contains(searchLower);
        }).toList();
      }
    });
  }

  double get _totalPrice {
    double total = 0;
    _selectedQuantities.forEach((itemId, qty) {
      final item = _allItems.firstWhere((element) => element.id == itemId);
      total += item.price * qty;
    });
    return total;
  }

  int get _selectedItemsCount {
    return _selectedQuantities.length;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocProvider(
      create: (context) =>
          sl<PriceListDetailsCubit>()..loadPriceListDetails(widget.priceListId),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: Column(
              children: [
                PriceListDetailsHeader(
                  title: widget.title,
                  onBack: () => Navigator.pop(context),
                  searchController: _searchController,
                  onSearchChanged: _filterItems,
                ),
                PriceListSummaryBar(
                  selectedItemsCount: _selectedItemsCount,
                  totalPrice: _totalPrice,
                ),
                const PriceListTableHeader(),

                // 3. Product List
                Expanded(
                  child: Stack(
                    children: [
                      BlocConsumer<
                        PriceListDetailsCubit,
                        PriceListDetailsState
                      >(
                        listener: (context, state) {
                          if (state is PriceListDetailsLoaded) {
                            setState(() {
                              _allItems = state.items;
                              _filteredItems = state.items;
                            });
                          }
                        },
                        builder: (context, state) {
                          if (state is PriceListDetailsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is PriceListDetailsError) {
                            return Center(
                              child: CustomErrorWidget(
                                message: state.message,
                                onRetry: () {
                                  context
                                      .read<PriceListDetailsCubit>()
                                      .loadPriceListDetails(widget.priceListId);
                                },
                              ),
                            );
                          } else if (state is PriceListDetailsLoaded) {
                            if (_filteredItems.isEmpty) {
                              return Center(
                                child: Text(
                                  'لا توجد أصناف',
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: SizeConfig.sp(9),
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }
                            return ListView.separated(
                              padding: EdgeInsets.only(
                                bottom: SizeConfig.h(
                                  10,
                                ), // Space for bottom bar
                              ),
                              itemCount: _filteredItems.length,
                              separatorBuilder: (_, __) =>
                                  Divider(height: 0.5, color: Colors.grey[300]),
                              itemBuilder: (context, index) {
                                final item = _filteredItems[index];
                                return ProductItemCard(
                                  name: item.nameAr,
                                  code: item.itemCode,
                                  direction: item.itemSide,
                                  price: item.price,
                                  minQty: item.minQty,
                                  onQuantityChanged: (qty) {
                                    setState(() {
                                      if (qty > 0) {
                                        _selectedQuantities[item.id] = qty;
                                      } else {
                                        _selectedQuantities.remove(item.id);
                                      }
                                    });
                                  },
                                );
                              },
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      PriceListCheckoutButton(
                        totalPrice: _totalPrice,
                        onCheckout: () {

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
}
