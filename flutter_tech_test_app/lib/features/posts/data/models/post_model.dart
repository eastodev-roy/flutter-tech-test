class Post {
  final int id;
  final String title;
  final String body;
  final List<String> tags;
  final int reactions;
  final int userId;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.reactions,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      tags: List<String>.from(json['tags'] ?? []),
      reactions: json['reactions'] is int ? json['reactions'] : (json['reactions']['likes'] ?? 0), // DummyJSON v3 has likes/dislikes
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'tags': tags,
      'reactions': reactions,
      'userId': userId,
    };
  }
}

class PostResponse {
  final List<Post> posts;
  final int total;
  final int skip;
  final int limit;

  PostResponse({
    required this.posts,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      posts: (json['posts'] as List).map((i) => Post.fromJson(i)).toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}
