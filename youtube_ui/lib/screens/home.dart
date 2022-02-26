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
  List<String> categories = [
    "All",
    "Stoves",
    "Baking",
    "Movies",
    "Flutter",
    "React Native",
    "Coding is Love",
  ];
  String selectedCategory = "All";
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: (){},
                      child: Row(children: [
                        const Icon(
                          Icons.explore_outlined, 
                          color: Colors.black
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            "Explore",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        )
                      ]),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade200),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: SizedBox(
                        height: 30,
                        child: VerticalDivider(
                          thickness: 1,
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 5.0,
                      children: categories
                        .map((category) => FilterChip(
                          showCheckmark: false,
                          selectedColor: Colors.grey.shade600,
                          label: Text(
                            category,
                            style: TextStyle(
                              color: selectedCategory == category
                                  ? Colors.white
                                  : Colors.black
                            ),
                          ),
                          backgroundColor: Colors.grey.shade200,
                          selected: selectedCategory == category,
                          onSelected: (bool value) {
                            setState(() {
                              selectedCategory = category;
                            });
                          }))
                        .toList())
                  ],
                ),
              )),
      ),
    );
  }
}