import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jin99tutorial/bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent : $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('error : $error');
    print('stackTrace : $stackTrace');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('transition : $transition');
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  final PostsRepository repository = PostsRepository(
    postsApiClient: PostsApiClient(
      httpClient: http.Client(),
    ),
  );
  runApp(MyApp(
    repository: repository,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final PostsRepository repository;

  MyApp({Key? key, required this.repository});

  @override
  Widget build(BuildContext context) {
    String title = 'title입니다.';

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: ListView(
            children: [
              BlocProvider(
                  create: (context) => PostsBloc(repository: repository),
                  child: HomePage()
              )
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation
              .endFloat, // This trailing comma makes auto-formatting nicer for build methods.
        )
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsEmpty) {
          BlocProvider.of<PostsBloc>(context).add(FetchPosts());
        }
        if (state is PostsError) {
          return Center(
            child: Text('failed to fetch Posts'),
          );
        }
        if (state is PostsLoaded) {
          return _buildPost(context, state.posts);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildPost(BuildContext context, Posts model){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: model.posts.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("userid : ${model.posts[index].userId}"),
                  Text("id : ${model.posts[index].id}"),
                  Text("title : ${model.posts[index].title}"),
                  Text("body : ${model.posts[index].body}")
                ],
              ),
            ),
          ),
        );
      },
    );

  }
}


