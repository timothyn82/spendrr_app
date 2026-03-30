import 'package:get/get.dart';
import 'package:spendrr/views/login.dart';
import 'package:spendrr/views/signup.dart';
import 'package:spendrr/views/homescreen.dart';

var routes = [
  GetPage(name: '/',           page: () => LoginScreen()),
  GetPage(name: '/signup',     page: () => SignupScreen()),
  GetPage(name: '/homescreen', page: () => HomeScreen()),
];