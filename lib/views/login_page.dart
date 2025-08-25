// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:ecommerce_admin/controllers/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700),
                ),
                Text("Get started with your account"),
                SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) =>
                        value!.isEmpty ? "Email can not be empty" : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) => value!.length < 8
                        ? "Password shoul have at least 8 characters"
                        : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Password"),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              title: Text("Forget Password"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter your email"),
                                  SizedBox(height: 10.0),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      label: Text("Email"),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    if (_emailController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Email cannot be empty",
                                          ),
                                        ),
                                      );

                                      return;
                                    }

                                    await AuthService()
                                        .resetPassword(_emailController.text)
                                        .then((value) {
                                          if (value ==
                                              "Password reset link has been sent to your email") {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Password reset link has been sent to your email",
                                                ),
                                              ),
                                            );

                                            Navigator.pop(context);
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  value,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    Colors.red.shade400,
                                              ),
                                            );
                                          }
                                        });
                                  },
                                  child: Text("Submit"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text("Forget Password?"),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                SizedBox(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        AuthService()
                            .loginWithEmail(
                              _emailController.text,
                              _passwordController.text,
                            )
                            .then((value) {
                              if (value == "You successfully logged in") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Login Successfully")),
                                );

                                Navigator.restorablePushNamedAndRemoveUntil(
                                  context,
                                  "/home",
                                  (route) => false,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      value,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red.shade400,
                                  ),
                                );
                              }
                            });
                      }
                    },
                    child: Text("Login", style: TextStyle(fontSize: 16.0)),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: Text("Sign up"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
