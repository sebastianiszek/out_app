import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_app/login_controller/screens/register_screen.dart';
import 'package:out_app/shared_components/out_dialog.dart';

import '../../shared_components/button.dart';
import '../../shared_components/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2678),
      body: Form(
          key: _loginFormKey,
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(
                    15.0,
                    90.0,
                    35.0,
                    25.0,
                  ),
                  child: Center(
                      child: Image.asset('assets/images/logo.png', scale: 1))),
              Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(22, 20, 22, 15),
                  child: TextFormField(
                    decoration: getOutLoginInputDecoration("E-mail"),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your e-mail';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Please enter a valid e-mail';
                      }
                      return null;
                    },
                  )),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 5, 22, 15),
                child: TextFormField(
                  obscureText: _isObscure,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  // The validator receives the text that the user has entered.
                  decoration: MergeInputDecoration(
                      input1: getOutLoginInputDecoration("Password"),
                      input2: InputDecoration(
                        suffixIcon: IconButton(
                          padding: const EdgeInsetsDirectional.only(end: 15.0),
                          icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFF1B1B1F)),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      )).merge(),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 15, 22, 0),
                child: ElevatedButton(
                    style: getOutButtonStyle(const Color(0xFFEFE827)).merge(
                        ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(color: Colors.black)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsetsDirectional.fromSTEB(
                                    25, 17, 25, 17)))),
                    onPressed: () async {
                      if (_loginFormKey.currentState!.validate()) {
                        try {
                          // ignore: unused_local_variable
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'invalid-email') {
                            showOutDialog(
                                context, 'Please enter a valid email.');
                          } else if (e.code == 'user-not-found') {
                            showOutDialog(
                                context, 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showOutDialog(context, 'Invalid Password.');
                          }
                        }
                      }
                    },
                    child: Text(
                      "LOGIN",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.merge(const TextStyle(fontSize: 17)),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.merge(const TextStyle(color: Color(0xFFFFFFFF))),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: Text(
                        'Register',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.merge(const TextStyle(color: Color(0xFFEFE827))),
                      )),
                ],
              ),
            ],
          )),
    );
  }
}

class MergeInputDecoration {
  final InputDecoration input1;
  final InputDecoration input2;

  MergeInputDecoration({
    required this.input1,
    required this.input2,
  });

  InputDecoration merge() {
    return input1.copyWith(
      alignLabelWithHint: input2.alignLabelWithHint,
      border: input2.border,
      constraints: input2.constraints,
      contentPadding: input2.contentPadding,
      counter: input2.counter,
      counterStyle: input2.counterStyle,
      counterText: input2.counterText,
      disabledBorder: input2.disabledBorder,
      enabled: input2.enabled,
      enabledBorder: input2.enabledBorder,
      errorBorder: input2.errorBorder,
      errorMaxLines: input2.errorMaxLines,
      errorStyle: input2.errorStyle,
      errorText: input2.errorText,
      fillColor: input2.fillColor,
      filled: input2.filled,
      floatingLabelBehavior: input2.floatingLabelBehavior,
      floatingLabelStyle: input2.floatingLabelStyle,
      focusColor: input2.focusColor,
      focusedBorder: input2.focusedBorder,
      focusedErrorBorder: input2.focusedErrorBorder,
      helperMaxLines: input2.helperMaxLines,
      helperStyle: input2.helperStyle,
      helperText: input2.helperText,
      hintMaxLines: input2.hintMaxLines,
      hintStyle: input2.hintStyle,
      hintText: input2.hintText,
      hintTextDirection: input2.hintTextDirection,
      hoverColor: input2.hoverColor,
      icon: input2.icon,
      iconColor: input2.iconColor,
      isCollapsed: input2.isCollapsed,
      isDense: input2.isDense,
      label: input2.label,
      labelStyle: input2.labelStyle,
      labelText: input2.labelText,
      prefix: input2.prefix,
      prefixIcon: input2.prefixIcon,
      prefixIconColor: input2.prefixIconColor,
      prefixIconConstraints: input2.prefixIconConstraints,
      prefixStyle: input2.prefixStyle,
      prefixText: input2.prefixText,
      semanticCounterText: input2.semanticCounterText,
      suffix: input2.suffix,
      suffixIcon: input2.suffixIcon,
      suffixIconColor: input2.suffixIconColor,
      suffixIconConstraints: input2.suffixIconConstraints,
      suffixStyle: input2.suffixStyle,
      suffixText: input2.suffixText,
    );
  }
}
