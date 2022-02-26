import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<IconData> actionsIcons = [
    Icons.cast_sharp, Icons.notifications_outlined,
    Icons.search,
    Icons.account_circle,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Image.asset(
          "assets/images/logo.png",
          height: 30,
          fit: BoxFit.contain,
        ),
        actions: actionsIcons
            .map((iconName) =>
                IconButton(onPressed: (){}, icon: Icon(iconName)))
            .toList(),
      ),
    );
  }
}