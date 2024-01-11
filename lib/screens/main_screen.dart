import 'package:flutter/material.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/screens/placeholder_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? _screens[_currentIndex]
          : Center(
              child: PlaceHolderScreen(),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          if (newIndex != 0) {
            showDialog(
              context: context,
              builder: (context) {
                return PlaceHolderScreen();
              },
            );
          } else {
            setState(() {
              _currentIndex = newIndex;
            });
          }
        },
        items: [
          BottomNavigationBarItem(label: 'Trang chủ', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Lưu trữ", icon: Icon(Icons.archive)),
          BottomNavigationBarItem(label: "Cài đặt", icon: Icon(Icons.settings)),
          BottomNavigationBarItem(label: "Tài khoản", icon: Icon(Icons.manage_accounts)),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blue,
        showSelectedLabels: true, // Ẩn label khi được chọn
        showUnselectedLabels: false, // Ẩn label khi không được chọn
      ),
    );
  }
}
