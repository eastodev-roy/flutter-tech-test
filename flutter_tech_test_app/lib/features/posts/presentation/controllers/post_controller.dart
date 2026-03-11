import 'package:assignment_app/features/posts/data/models/post_model.dart';
import 'package:assignment_app/features/posts/data/repository/post_repository.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final PostRepository _postRepository;

  PostController(this._postRepository);

  final RxList<Post> posts = <Post>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isPaginationLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt totalPosts = 0.obs;
  final RxInt skip = 0.obs;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      skip.value = 0;
      
      final response = await _postRepository.getPosts(limit: limit, skip: skip.value);
      
      posts.assignAll(response.posts);
      totalPosts.value = response.total;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isPaginationLoading.value || posts.length >= totalPosts.value) return;

    try {
      isPaginationLoading.value = true;
      skip.value += limit;

      final response = await _postRepository.getPosts(limit: limit, skip: skip.value);
      
      posts.addAll(response.posts);
    } catch (e) {
      // For pagination, we might just show a snackbar instead of blocking the whole UI
      Get.snackbar('Error', 'Failed to load more posts');
      skip.value -= limit; // Revert skip on failure
    } finally {
      isPaginationLoading.value = false;
    }
  }

  Future<void> refreshPosts() async {
    await fetchPosts();
  }

  bool get hasMore => posts.length < totalPosts.value;
}
