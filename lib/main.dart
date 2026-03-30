import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendrr/configs/routes.dart';
import 'package:spendrr/controllers/expense_controller.dart';
import 'package:spendrr/views/login.dart';

void main() {
  Get.put(ExpenseController()); // ✅ registered before anything else
  runApp(
    GetMaterialApp(
      title: 'Spendrr',
      initialRoute: '/',
      getPages: routes,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
  );
}