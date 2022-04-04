import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:networking/model/post_model.dart';
import 'package:networking/pages/edit_create_page.dart';
import '../service/http_service.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> posts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }

  void _apiPostList() {
    setState(() {
      isLoading = true;
    });
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
          _showResponse(response!),
        });
  }

  void _apiPostDelete(Post post) {
    Network.DELETE(
            Network.API_DELETE + post.id.toString(), Network.paramsEmpty())
        .then((response) => {
              _showResponse(response!),
            });
  }

  void _showResponse(String response) {
    setState(() {
      List json = jsonDecode(response);
      posts = List<Post>.from(json.map((x) => Post.fromJson(x)));
      isLoading = false;
    });
  }

  void _goToCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditCreatePage(post: Post())));
    if (result != null) {
      posts.add(result as Post);
      _apiPostList();
    }
  }

  void _goToEdit(Post post) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditCreatePage(
                  post: post,
                )));
    if (result != null) {
      posts
          .replaceRange(posts.indexOf(post), posts.indexOf(post) + 1, [result]);
      _apiPostList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("set State"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return _posts(index);
            },
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreate,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _posts(int index) {
    return Card(
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.red,
              onPressed: (_) {
                _apiPostDelete(posts[index]);
                posts.removeAt(index);
                setState(() {});
              },
              icon: Icons.delete,
            ),
          ],
        ),
        startActionPane: ActionPane(
          dragDismissible: true,
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.blue,
              onPressed: (_) {
                _goToEdit(posts[index]);
                setState(() {});
              },
              icon: Icons.edit,
            ),
          ],
        ),
        child: ListTile(
          title: Text(posts[index].title!.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Text(posts[index].body!),
        ),
      ),
    );
  }
}
