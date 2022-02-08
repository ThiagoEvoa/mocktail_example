import 'package:freezed_annotation/freezed_annotation.dart';
part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({required String title, required String body}) = _Post; // coverage:ignore-line

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  static List<Post> toList(List<dynamic> json) {
    return json.map((post) => Post.fromJson(post)).toList();
  }
}
