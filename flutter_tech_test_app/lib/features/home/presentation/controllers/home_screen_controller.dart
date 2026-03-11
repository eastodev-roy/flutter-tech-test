import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:assignment_app/features/home/data/models/product_model.dart';

class HomeScreenController extends GetxController {
  final Dio _dio = Dio();
  final ScrollController scrollController = ScrollController();

  final RxInt selectedIndex = 0.obs;
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isMoreLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final int _limit = 10;
  int _skip = 0;
  bool _hasMore = true;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> loadProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      _skip = 0;
      _hasMore = true;
      products.clear();
      isLoading.value = true;
    } else {
      if (!_hasMore || isMoreLoading.value) return;
      if (products.isEmpty) {
        isLoading.value = true;
      } else {
        isMoreLoading.value = true;
      }
    }

    errorMessage.value = '';

    try {
      final response = await _dio.get(
        'https://dummyjson.com/products',
        queryParameters: {
          'limit': _limit,
          'skip': _skip,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['products'];
        final total = response.data['total'] as int;

        final newProducts = data.map((e) => Product.fromJson(e)).toList();
        products.addAll(newProducts);

        _skip += _limit;
        if (products.length >= total) {
          _hasMore = false;
        }
      } else {
        errorMessage.value = 'Failed to load products';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      loadProducts();
    }
  }
}
