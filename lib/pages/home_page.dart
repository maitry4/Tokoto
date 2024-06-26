import "package:flutter/material.dart";
import 'package:tokoto/pages/logged_in_user_pages/chat_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/explore_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/favorites_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  static  List<Widget> body = [
    ExplorePage(),
    FavoritePage(),
    ChatPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Theme.of(context).primaryColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          currentIndex: _currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: "Profile",
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(
              bottom: 16.0), // Adjust the bottom padding as needed
          child: Center(
            child: body.elementAt(_currentIndex),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
