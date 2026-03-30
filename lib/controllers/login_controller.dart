import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  var username        = ''.obs;
  var password        = ''.obs;
  var passwordVisible = false.obs;
  var isLoading       = false.obs;

  void togglePassword() {
    passwordVisible.value = !passwordVisible.value;
  }

  Future<bool> login(String user, String pass) async {
    username.value = user;
    password.value = pass;

    isLoading.value = true;

    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2/spendrr_app/login.php'),
        body: {
          'username': user,
          'password': pass,
        },
      );

      var data = jsonDecode(response.body);
      isLoading.value = false;

      if (data['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }
}