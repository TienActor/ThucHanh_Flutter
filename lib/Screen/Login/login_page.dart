import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tien/Config/const.dart';
import 'package:tien/Screen/Home/main_page.dart';
import '../../Admin/home_page_ad.dart';
import '../../Config/api_urls.dart';
import '../../data/model.dart';
import '../SignUp/signup_page.dart';
import '../components/have_account.dart';
import '../components/custom_textfield.dart';
import '../components/custom_dialog.dart';
import '../Login/forget_pass.dart'; // Import trang đổi mật khẩu

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accIdController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final LoginModel _model = LoginModel();
  final APIRepository _apiRepository = APIRepository();

  @override
  void dispose() {
    _accIdController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 110),
              Text(
                'Xin Chào!',
                textAlign: TextAlign.center,
                style: GoogleFonts.pacifico(
                  color: Colors.black,
                  fontSize: 30,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1.6,
                ),
              ),
              Text(
                'Chào mừng trở lại. Shop rất nhớ bạn!',
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CustomTextField(
                        labelText: "AccountID",
                        controller: _accIdController,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập AccountID';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _model.accountID = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: CustomTextField(
                        labelText: "Mật khẩu",
                        controller: _passController,
                        isPassword: true,
                        prefixIcon: Icons.lock,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _model.password = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordPage()),
                            );
                          },
                          child: const Text(
                            'Quên mật khẩu?',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("ĐĂNG NHẬP",
                          style: TextStyle(letterSpacing: 4)),
                    ),
                    const SizedBox(height: defaultPadding),
                    AlreadyHaveAnAccountCheck(
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      log('${_model.accountID}, ${_model.password}');
      final loginModel = LoginModel(
        accountID: _accIdController.text,
        password: _passController.text,
      );
      final result = await _apiRepository.login(loginModel);
      if (result['success']) {
        final token = result['token'];
        if (mounted) {
          CustomDialog(
            context: context,
            message: "ĐĂNG NHẬP THÀNH CÔNG",
            durationTimes: 1,
            borderRadius: 90.0,
            textStyle:
                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 14),
            backgroundColor: Colors.white,
          ).show();
        }
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          if (_model.accountID == 'Tie2023' && _model.password == 'Tient3st') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminHome()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DashBoard(
                  token: token,
                  accountId: _model.accountID,
                ),
              ),
            );
          }
        }
      } else {
        if (mounted) {
          CustomDialog(
            context: context,
            message: result['message'],
            durationTimes: 2,
            borderRadius: 90.0,
            textStyle:
                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 14),
            backgroundColor: Colors.white,
          ).show();
        }
      }
    }
  }
}
