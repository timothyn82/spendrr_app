import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendrr/configs/colors.dart';
import 'package:spendrr/controllers/signup_controller.dart';

SignupController signupController= Get.put(SignupController());
TextEditingController signupUsernameCtrl   = TextEditingController();
TextEditingController signupEmailCtrl      = TextEditingController();
TextEditingController signupPasswordCtrl   = TextEditingController();

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Top hero section ──────────────────────────────────────
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryColor, accentColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Icon(Icons.arrow_back_ios,
                                  color: Colors.white70, size: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.person_add_outlined,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── White card form ───────────────────────────────────────
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Join Spendrr',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Fill in the details to get started',
                      style: TextStyle(fontSize: 13, color: subtitleColor),
                    ),
                    const SizedBox(height: 26),

                    // Username field
                    const Text(
                      'Username',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textDark),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: signupUsernameCtrl,
                      decoration: InputDecoration(
                        hintText: 'Choose a username',
                        hintStyle: TextStyle(color: subtitleColor, fontSize: 13),
                        prefixIcon: const Icon(Icons.person_outline, color: accentColor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: accentColor, width: 1.5),
                        ),
                        filled: true,
                        fillColor: cardColor,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Email field
                    const Text(
                      'Email',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textDark),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: signupEmailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: subtitleColor, fontSize: 13),
                        prefixIcon: const Icon(Icons.email_outlined, color: accentColor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: accentColor, width: 1.5),
                        ),
                        filled: true,
                        fillColor: cardColor,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password field
                    const Text(
                      'Password',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textDark),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => TextField(
                        controller: signupPasswordCtrl,
                        obscureText: !signupController.passwordVisible.value,
                        decoration: InputDecoration(
                          hintText: 'Create a password',
                          hintStyle: TextStyle(color: subtitleColor, fontSize: 13),
                          prefixIcon: const Icon(Icons.lock_outline, color: accentColor),
                          suffixIcon: GestureDetector(
                            onTap: () => signupController.togglePassword(),
                            child: Icon(
                              signupController.passwordVisible.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: accentColor,
                            ),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: accentColor, width: 1.5),
                          ),
                          filled: true,
                          fillColor: cardColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Register button
                    Obx(
                      () => GestureDetector(
                        onTap: signupController.isLoading.value
                            ? null
                            : () async {
                                bool success = await signupController.register(
                                  signupUsernameCtrl.text,
                                  signupEmailCtrl.text,
                                  signupPasswordCtrl.text,
                                );
                                if (success) {
                                  Get.snackbar(
                                    'Success',
                                    'Account created! Please login.',
                                    backgroundColor: incomeColor,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                  Get.offAndToNamed('/');
                                } else {
                                  Get.snackbar(
                                    'Registration Failed',
                                    'Please try again.',
                                    backgroundColor: expenseColor,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              },
                        child: Container(
                          height: 52,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.35),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: signupController.isLoading.value
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(color: subtitleColor, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}