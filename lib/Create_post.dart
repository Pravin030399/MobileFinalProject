
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/cubit/cubit_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

@override
class Create_post extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      create: (context) => cubit_controller(),
    ));
  }
}


class Add_post extends StatefulWidget {
  Add_post({required this.channel, Key? key}) : super(key: key);
  final WebSocketChannel channel;

  State<StatefulWidget> createState() {
    return _Add_post(channel);
  }
}


class _Add_post extends State<Add_post> {
  GlobalKey<FormState> validkey = GlobalKey<FormState>();

  _Add_post(this.channel);
  WebSocketChannel channel;
  String title = '';
  String description = '';
  String url = '';
  
  @override
  Widget build(BuildContext context) {
       const primaryColor = Color(0xFF43A047);
        
    return SafeArea(
      
        child: Scaffold(
          backgroundColor: Colors.yellow,
          

      appBar: new AppBar(
        centerTitle: true,
        title: Text("ADD POST"),
         backgroundColor: primaryColor
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),

      //         decoration: new BoxDecoration(
      //         boxShadow: [
      //           new BoxShadow(
      //           color: Colors.black,
      //           blurRadius: 20.0,
      //     ),
      //   ],
      // ),
              color: Colors.yellow,
            
              child: Form(
                key: validkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
           
                    TextFormField(
                        
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),

                          hintText: "Title:",
                        ),
                        onChanged: (String? value) {
                          setState(
                            () {
                              title = value!;
                            },
                          );
                        },
                      ),

                    SizedBox(height: 20.0),

                    TextFormField(
                      decoration: InputDecoration(
                                                border: OutlineInputBorder(),

                        hintText: "Description:",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          description = value!;
                        });
                      },
                      maxLines: 5,
                    ),
                    SizedBox(height: 20.0),

                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Image url:",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          url = value!;
                        });
                      },
                      maxLines: 2,
                    ),

                    SizedBox(height: 20.0),

                    ElevatedButton(
                        child: Text('SUBMIT'),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 92, vertical: 10),
                            primary: Colors.black,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        onPressed: () async {

                            channel.sink.add(
                                '{"type": "create_post","data": {"title": "$title", "description": "$description", "image": "$url"}}');
 }
                        ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

