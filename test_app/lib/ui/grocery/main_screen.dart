import 'package:flutter/material.dart';
import 'package:test_app/ui/grocery/grocery_home.dart';
import 'package:test_app/ui/grocery/more_screen.dart';
import 'package:test_app/ui/grocery/orders_screen.dart';
import 'package:test_app/ui/grocery/place_order_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  var selectedIndex = 0;
  var listScreens = [const GroceryHome(),const OrdersScreen(),const PlaceOrderScreen(),const MoreScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        onTap: (index) => updateScreen(index),
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: CircleAvatar(radius: 18,child: Icon(Icons.home,color: selectedIndex == 0 ? Colors.white : Colors.grey),backgroundColor: selectedIndex == 0 ? Colors.green : Colors.transparent),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(radius: 18,child: Icon(Icons.apps,color: selectedIndex == 1 ? Colors.white : Colors.grey),backgroundColor: selectedIndex == 1 ? Colors.green : Colors.transparent),
            label: 'All'
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(radius: 18,child: Icon(Icons.shopping_cart,color: selectedIndex == 2 ? Colors.white : Colors.grey),backgroundColor: selectedIndex == 2 ? Colors.green : Colors.transparent),
            label: 'Cart'
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(radius: 18,child: Icon(Icons.menu,color: selectedIndex == 3 ? Colors.white : Colors.grey),backgroundColor: selectedIndex == 3 ? Colors.green : Colors.transparent),
            label: 'Menu'
          )
        ]
      ),
      body: listScreens[selectedIndex],
    );
  }

  updateScreen(int index){
    setState(() {
      selectedIndex = index;
    });
  }
}