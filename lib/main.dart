import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jin99tutorial/bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
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
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      "Oeschinen Lake Compground",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    )),
                Text(
                  "Kandersteg, Switzerland",
                  style: TextStyle(color: Colors.grey[500]),
                ),
                Text(
                  "Kandersteg, Switzerland",
                  style: TextStyle(color: Colors.grey[900]),
                ),
              ],
            )),
          ],
        ));
    Widget buttonSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
            _buildButtonColumn(Colors.blue, Icons.near_me, 'ROUTE'),
            _buildButtonColumn(Colors.blue, Icons.share, 'SHARE'),
          ],
        ));
    Widget textSection = Container(
      padding: EdgeInsets.all(24),
      child: Text(
          'this is text are you ok? so this page is introduce adove figure. hones'
          'idont know what i am saying but, is this new line? with 2 indent? '
          'really? oh shit, I hope to work it well',
          textAlign: TextAlign.left,
          softWrap: true),
    );
    Widget ImageSection = Container(
      child: Image.asset(
        'images/lake.jpg',
        width: 600,
        height: 240,
        fit: BoxFit.cover,
      ),
    );
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
              Image.asset(
                'images/lake.jpg',
                width: 600,
                height: 240,
                fit: BoxFit.cover,
              ),
              titleSection,
              buttonSection,
              textSection,
              ApiTestWidget(),
              HomePage()
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation
              .endFloat, // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          icon,
          color: color,
        ),
        Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ))
      ],
    );
  }
}

class ApiTestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApiTestWidgetState();
  }
}

class _ApiTestWidgetState extends State<ApiTestWidget> {
  late Future<Album> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    futureAlbum = fetchAlbum2();
                  });
                },
                child: const Text('change')),
            FutureBuilder<Album>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data!.id.toString()),
                        Text(snapshot.data!.userId.toString()),
                        Text(snapshot.data!.title.toString()),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ));
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
          return ListTile(
            leading: Text(
              '${state.posts.userId}',
              style: TextStyle(fontSize: 10.0),
            ),
            title: Text(state.posts.title),
            isThreeLine: true,
            subtitle: Text(state.posts.body),
            dense: true,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}