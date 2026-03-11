import 'package:assignment_app/core/services/api_services.dart';
import 'package:assignment_app/features/posts/data/models/post_model.dart';

class PostRepository {
  final ApiService _apiService;

  PostRepository(this._apiService);

  Future<PostResponse> getPosts({int limit = 10, int skip = 0}) async {
    try {
      final response = await _apiService.get(
        'https://dummyjson.com/posts',
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );
      return PostResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Post> getPostDetails(int id) async {
    try {
      final response = await _apiService.get('https://dummyjson.com/posts/$id');
      return Post.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
