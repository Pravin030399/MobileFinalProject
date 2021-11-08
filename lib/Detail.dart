// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.title,
    required this.description,
    required this.url,
  }) : super(key: key);

  final String title;
  final String description;
  final String url;
  
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF43A047);
    return Scaffold(
      backgroundColor: Colors.yellow,
      
      appBar: AppBar(title: const Text('POST DETAILS'),centerTitle: true, backgroundColor: primaryColor),
      body: 
      ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 40, right: 40, bottom: 10),
                child: Image(
                  image: NetworkImage(Uri.parse(url).isAbsolute
                      ? url
                      : 'https://scontent.fkul8-1.fna.fbcdn.net/v/t1.6435-9/149098093_436876477759911_208740524272399589_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=VweEd71zZUQAX91Vm-I&_nc_ht=scontent.fkul8-1.fna&oh=5c953fc30bbbda3921d7b422ddd5bc72&oe=61ACFDE3'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Flexible(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}