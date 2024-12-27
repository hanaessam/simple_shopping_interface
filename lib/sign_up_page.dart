import 'package:flutter/material.dart';
import 'package:simple_shopping_interface/shopping_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // string to hold error message
  String errorMessage = '';

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Enter your full name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                      validator: (value) {
                        // validate that first letter is capital
                        // first ensure that string is not null before accessing the first letter
                        if (value == null || value.isEmpty) {
                          errorMessage = 'you must enter your full name';
                          return errorMessage;
                        }
                        var firstLetter = value[0];
                        if (firstLetter == firstLetter.toUpperCase()) {
                          return null;
                        } else {
                          errorMessage = 'first letter must be capital';
                          return errorMessage;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                      validator: (value) {
                        // validate that email contains @
                      
                        if (value == null || value.isEmpty) {
                          errorMessage = 'you must enter your email';
                          return errorMessage;
                        }
                        if (value.contains('@')) {
                          return null;
                        } else {
                          errorMessage = 'email must contain @ symbol';
                          return errorMessage;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: isPassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          icon: Icon(isPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (value) {
                        // validate that password is at least 6 characters
                        
                        if (value == null || value.isEmpty) {
                          errorMessage = 'you must enter a password';
                          return errorMessage;
                        }
                        if (value!.length >= 6) {
                          return null;
                        } else {
                          errorMessage =
                              'password must be at least 8 characters';
                          return errorMessage;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: isPassword,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          icon: Icon(isPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (value) {
                        // validate that password and confirm password match

                        if (value == null || value.isEmpty) {
                          errorMessage = 'you must confirm your password';
                          return errorMessage;
                        }
                        if (value == passwordController.text) {
                          return null;
                        } else {
                          errorMessage = 'passwords do not match';
                          return errorMessage;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        final fullName = fullNameController.text;
                        final email = emailController.text;
                        final password = passwordController.text;
                        final confirmPassword = confirmPasswordController.text;
                        if (_formKey.currentState!.validate() &&
                            fullName.isNotEmpty &&
                            email.isNotEmpty &&
                            password.isNotEmpty &&
                            confirmPassword.isNotEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Success'),
                                content:
                                    const Text('Account created successfully'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ShoppingPage(
                                                title: 'Shopping Page')),
                                      );
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(errorMessage)),
                          );
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
