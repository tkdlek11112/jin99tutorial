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


class Posts extends Equatable{
  final userId;
  final id;
  final String title;
  final String body;

  const Posts({this.userId, this.id, required this.title, required this.body});

  @override
  List<Object> get props => [userId, id, title, body];

  static Posts fromJson(dynamic json){
    return Posts(
      userId:json['userId'], // 여긴 왜 _userId지?
      id:json['id'],
      title:json['title'],
      body:json['body'],
    );
  }

  @override
  String toString() => 'Posts {userId:$userId}';
}