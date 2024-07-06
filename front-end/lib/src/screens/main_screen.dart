import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:vtcc_app/src/screens/home_screen.dart';
import 'package:vtcc_app/src/screens/image_pick.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget chosenScreen = HomeScreen();
  int _selectedIndex = 0;
  final _pageController = PageController();

  final _pages = [
    HomeScreen(),
    ImageSelect(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          //Here goes the same radius, u can put into a var or function
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: SalomonBottomBar(
            unselectedItemColor: Colors.black.withOpacity(0.2),
            backgroundColor: Colors.white,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(_selectedIndex,
                    duration: Duration(milliseconds: 1), curve: Curves.linear);
              });
            },
            currentIndex: _selectedIndex,
            // control which tab will be highlighted when chosen
            items: [
              SalomonBottomBarItem(
                  icon: Icon(FontAwesomeIcons.house),
                  title: Text('Home'),
                  selectedColor: Colors.deepPurple),
              SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.image),
                title: Text('Classify'),
                selectedColor: Colors.deepPurple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
