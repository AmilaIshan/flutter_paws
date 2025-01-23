import 'package:flutter/material.dart';
import 'package:paws/screens/cart.dart';
import 'package:paws/screens/favorite.dart';
import 'package:paws/screens/home.dart';
import 'package:paws/screens/profile.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigation(),
    );
  }
}


class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            currentPage = index;
          });
        },
          selectedIndex: currentPage,
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.home),
                label: "Home"
            ),
            NavigationDestination(
                icon: Icon(Icons.shopping_cart),
                label: "Cart"
            ),
            NavigationDestination(
                icon: Icon(Icons.favorite),
                label: "Favorite"
            ),
            NavigationDestination(
                icon: Icon(Icons.person_2_rounded),
                label: "Profile"
            ),
          ]
      ),
      body: <Widget>[
        Home(),
        Cart(),
        Favorite(),
        Profile()
      ][currentPage],
    );
  }
}
