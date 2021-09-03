import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Favourites here"),
      ),
      body: Container(
      child: Center(child: Text('Your Favourites')),
      ), 
    );
  }
}
