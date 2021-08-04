import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable{
  const PostsEvent();
}

class FetchPosts extends PostsEvent{
  const FetchPosts();

  @override
  List<Object?> get props => [];
}

