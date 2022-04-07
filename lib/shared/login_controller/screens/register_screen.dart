import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/out_dialog.dart';
import 'package:out_app/shared/shared_components/out_snackbar.dart';

import '../../shared_components/button.dart';
import '../../shared_components/input.dart';
import 'login_screen.dart';
import 'package:password_strength/password_strength.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  double strength = 0;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    void _updateStrenght(double strength) {
      setState(() {
        this.strength = strength;
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1C2678),
      body: Form(
          key: _registerFormKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: TextButton.icon(
                      style: ButtonStyle(
                          alignment: Alignment.center,
                          textStyle: MaterialStateProperty.all(
                              Theme.of(context).textTheme.headline6),
                          foregroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 255, 255, 255))),
                      icon: const Icon(Icons.chevron_left, size: 30),
                      label: const Text("GO BACK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(
                    15.0,
                    29.0,
                    35.0,
                    25.0,
                  ),
                  child: Center(
                      child: Image.asset('assets/images/logo.png', scale: 1))),
              Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(22, 20, 22, 0),
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
                padding: const EdgeInsetsDirectional.fromSTEB(42, 15, 22, 5),
                child: getStrenghtText(strength),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 5, 22, 15),
                child: TextFormField(
                  onChanged: (value) {
                    _updateStrenght(estimatePasswordStrength(value));
                  },
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
                padding: const EdgeInsetsDirectional.fromSTEB(22, 5, 22, 15),
                child: TextFormField(
                  obscureText: _isObscure,
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.value.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  // The validator receives the text that the user has entered.
                  decoration: MergeInputDecoration(
                      input1: getOutLoginInputDecoration("Confirm Password"),
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
                padding: const EdgeInsetsDirectional.fromSTEB(22, 15, 22, 15),
                child: ElevatedButton(
                    style: getOutButtonStyle(const Color(0xFFEFE827)).merge(
                        ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(color: Colors.black)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsetsDirectional.fromSTEB(
                                    25, 17, 25, 17)))),
                    onPressed: () async {
                      if (_registerFormKey.currentState!.validate()) {
                        if (strength < 0.3) {
                          showOutDialog(
                              context, 'The provided password is too weak.');
                        } else {
                          try {
                            // ignore: unused_local_variable
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);

                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(userCredential.user!.uid)
                                .set({
                              'email': userCredential.user!.email,
                              'booking': '',
                            });
                            Navigator.pop(context);
                            outSnackbar('Registration successful', context);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showOutDialog(context,
                                  'The provided password is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              showOutDialog(context, 'E-mail already in use.');
                            } else if (e.code == 'invalid-email') {
                              showOutDialog(context, 'E-mail is invalid.');
                            } else {
                              showOutDialog(context, 'Fail.');
                            }
                          } catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
                          }
                        }
                      }
                    },
                    child: Text(
                      "REGISTER",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.merge(const TextStyle(fontSize: 17)),
                    )),
              ),
            ],
          )),
    );
  }
}

RichText getStrenghtText(double strength) {
  String strengthText;
  Color strengthColor = const Color.fromARGB(255, 255, 0, 0);

  if (strength < 0.3) {
    strengthText = 'Weak';
    strengthColor = const Color.fromARGB(255, 238, 0, 0);
  } else if (strength < 0.7) {
    strengthText = 'Okay';
    strengthColor = const Color(0xFFEFE827);
  } else {
    strengthText = 'Strong';
    strengthColor = const Color.fromARGB(255, 0, 255, 0);
  }

  return RichText(
    text: TextSpan(
      style: const TextStyle(color: Colors.white),
      text: 'Password Strength: ',
      children: <TextSpan>[
        TextSpan(text: strengthText, style: TextStyle(color: strengthColor)),
      ],
    ),
  );
}
