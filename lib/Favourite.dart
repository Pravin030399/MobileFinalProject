import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class FavouritePage extends StatefulWidget{
  @override
  FavouritePageState createState() => FavouritePageState();
}

class FavouritePageState extends State<FavouritePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favourite'),),
    );
  }
}