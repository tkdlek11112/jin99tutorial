import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:jin99tutorial/model/model.dart';

abstract class PostsState extends Equatable{
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsEmpty extends PostsState {}
class PostsLoading extends PostsState {}
class PostsLoaded extends PostsState {
  final Posts posts;

  const PostsLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostsError extends PostsState {}