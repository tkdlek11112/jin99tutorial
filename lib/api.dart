import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'model/model.dart';
import 'package:meta/meta.dart';

Future<Album> fetchAlbum() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  if(response.statusCode == 200){
    return Album.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to load album');
  }
}

Future<Album> fetchAlbum2() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/2'));
  if(response.statusCode == 200){
    return Album.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to load album');
  }
}

class PostsApiClient {
  final _baseUrl = 'https://jsonplaceholder.typicode.com';
  final http.Client httpClient;
  PostsApiClient({
    required this.httpClient,
  });
  Future<Posts> fetchPosts() async{
    final url = '$_baseUrl/posts';
    final response = await this.httpClient.get(Uri.parse(url));
    if(response.statusCode != 200){
      throw new Exception('error getting posts');
    }
    final json = jsonDecode(response.body);
    return Posts.fromJson(json);
  }
}

class PostsRepository{
  final PostsApiClient postsApiClient;
  PostsRepository({required this.postsApiClient});
  Future<Posts> fetchPosts() async{
    return await postsApiClient.fetchPosts();
  }
}
