// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/Home.dart';
import 'package:project1/cubit/name_cubit.dart';
import 'package:web_socket_channel/io.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
         theme: ThemeData(
        primarySwatch: Colors.green,
        ),
        home: BlocProvider(
          create: (context) => NameCubit(),
          child: MyHomePage(title: 'Flutter Capitalize'),
          
        ));
  }
  
}
final channel =
      IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


   String user_Input = '';

class _MyHomePageState extends State<MyHomePage> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 110, left: 20.0, right: 20.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                  image: NetworkImage('https://pbs.twimg.com/profile_images/1350740688728694785/fgL1qg2O_400x400.jpg'),
                ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'USERNAME',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                          onChanged: (String? value) {
                                    setState(() {
                                      user_Input = value!;
                                    });
                                  },  
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                      child: Text('ENTER TO THE APP',textAlign: TextAlign.center,),
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

                        if (user_Input.isEmpty) {
ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Fill in username"),
                                duration: const Duration(seconds: 2),
                              ));                        } else {
                          context
                                                    .read<NameCubit>()
                                                    .login(user_Input,channel);
                          
                          Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (_) => Home(channel: channel)),

                              );
                        }
                       
                      }),
                       
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

login() {
  
  channel.sink.add('{"type":"sign_in","data":{"name":"$user_Input"}}');

  channel.stream.listen((message) {
    final decodeMessage = jsonDecode(message);

    print(decodeMessage);


  });
}
