import 'package:equatable/equatable.dart';

class Album{
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title
});
  factory Album.fromJson(Map<String, dynamic> json){
    return Album(userId: json['userId'], id: json['id'], title: json['title']);
  }
}


class Posts{
  late List<Post> posts;

  Posts({required this.posts});

  Posts.fromJson(List<dynamic> json){
    posts = new List<Post>.empty(growable: true);
    json.forEach((value) {
      posts.add(new Post.fromJson(value));
    });
  }
}

class Post{
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json){
    userId=json['userId'];
    id=json['id'];
    title=json['title'];
    body=json['body'];
  }
}