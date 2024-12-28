import 'package:empowerhr_moblie/core/dialog_utils.dart';
import 'package:empowerhr_moblie/presentation/bloc/auth_bloc.dart';
import 'package:empowerhr_moblie/presentation/bloc/auth_event.dart';
import 'package:empowerhr_moblie/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isEmailFocused = false;

  bool isPasswordFocused = false;
  bool isPasswordVisible = false;
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();

  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    setState(() {
      _emailFocus.addListener(() {
        setState(() {
          isEmailFocused = _emailFocus.hasFocus;
        });
      });
      _passwordFocus.addListener(() {
        setState(() {
          isPasswordFocused = _passwordFocus.hasFocus;
        });
      });
    });
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B5563),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              DialogUtils.showLoadingDialog(context);
            } else if (state is AuthSuccess) {
              DialogUtils.dismissDialog(context);
              DialogUtils.showSuccessDialog(
                  context, "Welcome ${state.userName}!");
            } else if (state is AuthFailure) {
              DialogUtils.dismissDialog(context);
              DialogUtils.showErrorDialog(context, state.message);
            }
          },
          builder: (context, state) {

            return Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, top: 25),
                    child: Image.asset('assets/LOGO-02.png'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 170),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 75,
                                  ),
                                  Text(
                                    "Welcome Back!",
                                    style: GoogleFonts.poppins(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        child: const Text('Email')),
                                  ),
                                  const SizedBox(
                                    height: 13,
                                  ),
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDEE3E7),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: TextField(
                                      cursorColor: Color(0xFF2EB67D),
                                      style: const TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                      ),
                                      controller: emailController,
                                      focusNode: _emailFocus,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter your Email here',
                                        hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 15,
                                            color: isEmailFocused
                                                ? const Color(0xFF2EB67D)
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        child: const Text('Password')),
                                  ),
                                  const SizedBox(
                                    height: 13,
                                  ),
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDEE3E7),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextField(
                                      cursorColor: Colors.green,
                                      obscureText: !isPasswordVisible,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: passwordController,
                                      focusNode: _passwordFocus,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter your Password here',
                                        hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 15,
                                            color: isPasswordFocused
                                                ? const Color(0xFF2EB67D)
                                                : Colors.grey,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 13),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            isPasswordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              isPasswordVisible =
                                                  !isPasswordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: Text('Forgot password?',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: const Color(0xFF2EB67D),
                                                fontWeight: FontWeight.w500))),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<AuthBloc>().add(LoginEvent(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF2EB67D),
                                        foregroundColor: Colors.white,
                                        fixedSize: const Size(190, 45),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    child: Text("Login",
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
