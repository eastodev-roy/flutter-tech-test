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

  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch initial posts
    fetchPosts();
    
    // Setup search listener with debounce
    debounce(searchQuery, (_) => fetchPosts(), time: const Duration(milliseconds: 500));
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      skip.value = 0;
      
      final PostResponse response;
      if (searchQuery.value.isEmpty) {
        response = await _postRepository.getPosts(limit: limit, skip: skip.value);
      } else {
        response = await _postRepository.searchPosts(searchQuery.value, limit: limit, skip: skip.value);
      }
      
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

      final PostResponse response;
      if (searchQuery.value.isEmpty) {
        response = await _postRepository.getPosts(limit: limit, skip: skip.value);
      } else {
        response = await _postRepository.searchPosts(searchQuery.value, limit: limit, skip: skip.value);
      }
      
      posts.addAll(response.posts);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load more posts');
      skip.value -= limit;
    } finally {
      isPaginationLoading.value = false;
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
  }

  Future<void> refreshPosts() async {
    await fetchPosts();
  }

  bool get hasMore => posts.length < totalPosts.value;

  List<Post> get featuredPosts => posts.where((p) => p.reactions > 10).toList();
  
  List<Post> get recentPosts {
    final list = List<Post>.from(posts);
    list.sort((a, b) => b.id.compareTo(a.id));
    return list;
  }
}
