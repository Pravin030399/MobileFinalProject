import 'dart:convert';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/Detail.dart';
import 'package:project1/Create_post.dart';
import 'package:project1/cubit/cubit_controller.dart';
import 'package:project1/main.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class Home extends StatefulWidget {
  Home({required this.channel, Key? key}) : super(key: key);
  final WebSocketChannel channel;

  State<StatefulWidget> createState() {
    return _Home(channel);
  }
}

class _Home extends State<Home> {
  _Home(this.channel);
  WebSocketChannel channel;

  dynamic decodedMessage;
  String textID = "";

  List posts = [];
  bool isFavorite = false;
  bool favouriteClicked = false;
  List favoritePosts = [];

  @override
  initState() {
    super.initState();
    widget.channel.stream.listen((results) {
      decodedMessage = jsonDecode(results);
      if (decodedMessage['type'] == 'all_posts') {
        posts = decodedMessage['data']['posts'];
      }
      setState(() {});
    });
    getPosts();
  }

  void getPosts() {
    widget.channel.sink.add('{"type": "get_posts"}');
  }

  sortDate() {
    for (int i = 0; i >= posts.length; i++) {}
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void deletePost(postID) {
    channel.sink.add('{"type":"delete_post","data":{"postId":"$postID"}}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => cubit_controller(),
        child: Scaffold(
          backgroundColor: Colors.lightGreen,
            
            appBar: AppBar(
              leading: IconButton (
                 icon: Icon(Icons.logout_outlined), 
                 onPressed: () { 
                     Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MyApp(),
                    ));  /** Do something */ 
                 },
            ),
                automaticallyImplyLeading: false,

              centerTitle: true,
              title: Text("ALL POSTS"),
              actions: [],
              backgroundColor: Colors.green,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Add_post(channel: channel),
                    ));
              },
              child: const Icon(Icons.add_box),
              backgroundColor: Colors.green,
            ),
            body: BlocBuilder<cubit_controller, String>(
              builder: (context, index) {
                print(posts.length);
                return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        
                        color: Colors.yellowAccent,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                        elevation: 10.0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  title: posts[index]['title'],
                                  description: posts[index]['description'],
                                  url: posts[index]['image'],
                                ),
                              ),
                            );
                            // Move to post details page
                          },
                          child: Container(
                                                         padding:EdgeInsets.all(8),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                               CircleAvatar(
                                 radius: 50.0,
                                  backgroundImage: NetworkImage(Uri.parse(
                                                posts[index]['image'])
                                            .isAbsolute &&
                                        posts[index].containsKey('image')
                                    ? '${posts[index]['image']}'
                                    : 'https://scontent.fkul8-1.fna.fbcdn.net/v/t1.6435-9/149098093_436876477759911_208740524272399589_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=VweEd71zZUQAX91Vm-I&_nc_ht=scontent.fkul8-1.fna&oh=5c953fc30bbbda3921d7b422ddd5bc72&oe=61ACFDE3'),
                               
                              ),
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${posts[index]["title"].toString().characters.take(20)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Created by ${posts[index]["author"].toString().characters.take(15)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Date Created: ${posts[index]["date"].toString().characters.take(10)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      children: [
                                        FavoriteButton(
                                            iconSize: 30.0,
                                            valueChanged: (isFavorite) {
                                              setState(() {
                                                isFavorite = true;
                                                if (favoritePosts
                                                    .contains(posts[index])) {
                                                  favoritePosts
                                                      .remove(posts[index]);
                                                  print('item already added');
                                                } else {
                                                  favoritePosts
                                                      .add(posts[index]);
                                                }
                                                print(favoritePosts);
                                              });
                                            }),
                                        Ink(
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.delete_forever_rounded),
                                            color: Colors.black,
                                            onPressed: () {
                                              textID = posts[index]["_id"];
                                              print(textID);
                                              widget.channel.sink.add(
                                                  '{"type":"delete_post","data":{"postId": "$textID"}}');
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Ink(),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ),
                      );
                    });
              },
            )));
  }
}
