import 'package:assignment_app/features/posts/data/models/post_model.dart';
import 'package:assignment_app/features/posts/presentation/controllers/post_controller.dart';
import 'package:assignment_app/features/posts/presentation/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PostController controller = Get.find<PostController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      controller.loadMore();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'All Posts'),
            Tab(text: 'Featured'),
            Tab(text: 'Recent'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildPostList(),
              _buildSpecifiedPostList(controller.featuredPosts, 'No featured posts found.'),
              _buildSpecifiedPostList(controller.recentPosts, 'No recent posts found.'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostList() {
    return Obx(() {
      if (controller.isLoading.value && controller.posts.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty && controller.posts.isEmpty) {
        return _buildErrorWidget();
      }

      if (controller.posts.isEmpty) {
        return const Center(child: Text('No posts found.'));
      }

      return RefreshIndicator(
        onRefresh: controller.refreshPosts,
        child: ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(16.r),
          itemCount: controller.posts.length + (controller.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.posts.length) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            final post = controller.posts[index];
            return PostCard(
              post: post,
              onTap: () {
                Get.toNamed('/post_detail', arguments: post);
              },
            );
          },
        ),
      );
    });
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          SizedBox(height: 16.h),
          Text(
            'Oops! Something went wrong.',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(controller.errorMessage.value),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: controller.fetchPosts,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecifiedPostList(List<Post> postList, String emptyMessage) {
    return Obx(() {
      if (controller.isLoading.value && postList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (postList.isEmpty) {
        return Center(child: Text(emptyMessage));
      }

      return ListView.builder(
        padding: EdgeInsets.all(16.r),
        itemCount: postList.length,
        itemBuilder: (context, index) {
          final post = postList[index];
          return PostCard(
            post: post,
            onTap: () {
              Get.toNamed('/post_detail', arguments: post);
            },
          );
        },
      );
    });
  }
}
