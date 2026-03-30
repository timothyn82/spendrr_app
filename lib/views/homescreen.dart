import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendrr/configs/colors.dart';
import 'package:spendrr/controllers/expense_controller.dart';
import 'package:spendrr/views/dashboard.dart';
import 'package:spendrr/views/transactions.dart';
import 'package:spendrr/views/analytics.dart';
import 'package:spendrr/views/budget.dart';
import 'package:spendrr/views/add_expense.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    Dashboard(),
    Transactions(),
    Analytics(),
    Budget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: _tabs[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () {
                Get.to(() => AddExpenseScreen());
              },
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            )
          : null,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xFFF5F7FF),
        color: primaryColor,
        buttonBackgroundColor: accentColor,
        height: 60,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.dashboard_outlined, size: 26, color: Colors.white),
          Icon(Icons.receipt_long_outlined, size: 26, color: Colors.white),
          Icon(Icons.pie_chart_outline, size: 26, color: Colors.white),
          Icon(Icons.account_balance_wallet_outlined, size: 26, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}