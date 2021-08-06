import 'package:jin99tutorial/api.dart';
import 'package:bloc/bloc.dart';

import 'package:jin99tutorial/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState>{
  final PostsRepository repository;
  
  PostsBloc({required this.repository}) : super(PostsEmpty());

  PostsState get initialState => PostsEmpty();

  
  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async*{
    if (event is FetchPosts){
      yield PostsLoading();
      try{
        final posts = await repository.fetchPosts();
        // print(posts);
        yield PostsLoaded(posts: posts);
      }catch(_){
        yield PostsError("데이터 읽다가 뻑남");
      }
    }
  }
}