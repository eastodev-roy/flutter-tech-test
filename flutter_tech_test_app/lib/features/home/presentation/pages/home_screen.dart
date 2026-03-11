import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:assignment_app/features/home/presentation/controllers/home_screen_controller.dart';
import 'package:assignment_app/features/home/presentation/widgets/custom_bottom_navbar.dart';
import 'package:assignment_app/features/home/data/models/product_model.dart';
import 'package:assignment_app/features/posts/presentation/widgets/posts_view.dart';
import 'package:assignment_app/features/home/presentation/widgets/settings_view.dart';
import 'package:assignment_app/core/services/theme_service.dart';
import 'package:assignment_app/core/constants/app_route.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final index = controller.selectedIndex.value;
          String title = 'Home';
          if (index == 1) title = 'Posts';
          if (index == 2) title = 'Settings';
          return Text(
            title,
            style: Get.textTheme.headlineMedium?.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          );
        }),
        actions: [
          IconButton(
            icon: Icon(
              Get.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: Get.theme.colorScheme.primary,
            ),
            onPressed: () => Get.find<ThemeService>().switchTheme(),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            final index = controller.selectedIndex.value;
            if (index != 0) return const SizedBox.shrink();

            return _buildSearchBar(
              hintText: 'Search products...',
              onChanged: (val) {
                controller.searchQuery.value = val;
              },
            );
          }),
          Expanded(
            child: Obx(() {
              if (controller.selectedIndex.value == 0) {
                return _buildStorefrontBody();
              } else if (controller.selectedIndex.value == 1) {
                return const PostsView();
              } else {
                return const SettingsView();
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => CustomBottomNavbar(
          selectedIndex: controller.selectedIndex.value,
          onItemSelected: (index) {
            controller.changeTabIndex(index);
            // Optional: reset search when changing tabs
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar({
    required String hintText,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.r, 0, 16.r, 16.r),
      child: Container(
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Get.theme.colorScheme.primary,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14.h),
          ),
        ),
      ),
    );
  }

  Widget _buildStorefrontBody() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
              ElevatedButton(
                onPressed: () => controller.loadProducts(isRefresh: true),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      if (controller.products.isEmpty) {
        return const Center(child: Text('No products found.'));
      }

      return RefreshIndicator(
        onRefresh: () => controller.loadProducts(isRefresh: true),
        child: ListView.separated(
          controller: controller.scrollController,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemCount:
              controller.products.length +
              (controller.isMoreLoading.value ? 1 : 0),
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            if (index < controller.products.length) {
              final product = controller.products[index];
              return _buildProductCard(product);
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      );
    });
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(AppRoutes.productDetailScreen, arguments: product),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Get.theme.dividerColor.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                product.thumbnail,
                width: 80.w,
                height: 80.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image, size: 80.w),
              ),
            ),
            SizedBox(width: 16.w),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text('${product.rating}', style: Get.textTheme.bodySmall),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Get.textTheme.titleLarge?.copyWith(
                      color: Get.theme.colorScheme.primary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
