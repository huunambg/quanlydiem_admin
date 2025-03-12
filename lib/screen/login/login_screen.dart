import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/config/api_state.dart';
import '/config/global_color.dart';
import '/config/global_text_style.dart';
import '/screen/login/controller/login_controller.dart';
import 'package:flutter/services.dart'; // Import for additional validation

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final loginCtl = Get.find<LoginController>();

  // Validation function for email and password
  bool _validateInputs() {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Check if email is empty
    if (email.isEmpty) {
      _showError("Vui lòng nhập email.");
      return false;
    }

    // Check if email format is correct
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(email)) {
      _showError("Email không hợp lệ.");
      return false;
    }

    // Check if password is empty
    if (password.isEmpty) {
      _showError("Vui lòng nhập mật khẩu.");
      return false;
    }

    // Check password length
    if (password.length < 6) {
      _showError("Mật khẩu phải có ít nhất 6 ký tự.");
      return false;
    }

    return true;
  }

  // Function to show error message
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => loginCtl.apiState.value == ApiState.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 60.0, 24.0, 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Đăng Nhập",
                        style: GlobalTextStyles.font24w700ColorWhite
                            .copyWith(color: const Color(0xFF2A4ECA)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Nó trở nên phổ biến vào những năm 1960 với việc phát hành các tờ Letraset có chứa Lorem Ipsum.",
                        textAlign: TextAlign.center,
                        style: GlobalTextStyles.font14w400ColorWhite
                            .copyWith(color: const Color(0xFF61677D)),
                      ),
                      const Gap(16.0),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 56.0,
                              decoration: BoxDecoration(
                                  color: GlobalColors.container,
                                  borderRadius: BorderRadius.circular(14.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/ic_fb.png",
                                      height: 24.0, width: 24.0),
                                  const Gap(12.0),
                                  Text(
                                    "Facebook",
                                    style:
                                        GlobalTextStyles.font16w500Color61677D,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(16.0),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: 56.0,
                              decoration: BoxDecoration(
                                  color: GlobalColors.container,
                                  borderRadius: BorderRadius.circular(14.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/ic_google.png",
                                      height: 24.0, width: 24.0),
                                  const Gap(12.0),
                                  Text(
                                    "Google",
                                    style:
                                        GlobalTextStyles.font16w500Color61677D,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 1,
                            color: const Color(0xFFE0E5EC),
                          )),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Hoặc",
                              style: GlobalTextStyles.font14w400Color262626,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            height: 1,
                            color: const Color(0xFFE0E5EC),
                          ))
                        ],
                      ),
                      const Gap(20),
                      // Email TextField
                      Container(
                        decoration: BoxDecoration(
                            color: GlobalColors.container,
                            borderRadius: BorderRadius.circular(14.0)),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 12),
                            isDense: true,
                            fillColor: GlobalColors.container,
                            hintText: 'Nhập email',
                            hintStyle: GlobalTextStyles.font16w400Color7C8BA0,
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Icons.mail,
                              color: const Color(0xFF7C8BA0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Password TextField
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: GlobalColors.container,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: _passwordController,
                          obscureText:
                              !_isPasswordVisible, // Ẩn hoặc hiện mật khẩu
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 12),
                            isDense: true,
                            fillColor: GlobalColors.container,
                            hintText: 'Nhập mật khẩu',
                            hintStyle: GlobalTextStyles.font16w400Color7C8BA0,
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xFF7C8BA0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color(0xFF61677D),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Login Button

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate before login
                            if (_validateInputs()) {
                              loginCtl.login(_emailController.text,
                                  _passwordController.text, context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            'Đăng nhập',
                            style: GlobalTextStyles.font14w600ColorWhite,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
