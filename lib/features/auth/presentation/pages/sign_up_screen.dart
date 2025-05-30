import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food_delivery/core/widgets/my_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  IconData iconPassword = Icons.remove_red_eye;
  bool obscurePassword = true;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return state is AuthLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: MyTextField(
                            controller: emailController,
                            hintText: 'Email',
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(Icons.mail_outline),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please fill in this field';
                              } else if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                                  .hasMatch(val)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            }),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: MyTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: obscurePassword,
                            keyboardType: TextInputType.visiblePassword,
                            prefixIcon: const Icon(Icons.lock_clock_outlined),
                            onChanged: (val) {
                              if (val!.contains(RegExp(r'[A-Z]'))) {
                                setState(() {
                                  containsUpperCase = true;
                                });
                              } else {
                                setState(() {
                                  containsUpperCase = false;
                                });
                              }
                              if (val.contains(RegExp(r'[a-z]'))) {
                                setState(() {
                                  containsLowerCase = true;
                                });
                              } else {
                                setState(() {
                                  containsLowerCase = false;
                                });
                              }
                              if (val.contains(RegExp(r'[0-9]'))) {
                                setState(() {
                                  containsNumber = true;
                                });
                              } else {
                                setState(() {
                                  containsNumber = false;
                                });
                              }
                              if (val.contains(RegExp(
                                  r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                                setState(() {
                                  containsSpecialChar = true;
                                });
                              } else {
                                setState(() {
                                  containsSpecialChar = false;
                                });
                              }
                              if (val.length >= 8) {
                                setState(() {
                                  contains8Length = true;
                                });
                              } else {
                                setState(() {
                                  contains8Length = false;
                                });
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                  if (obscurePassword) {
                                    iconPassword =
                                        Icons.remove_red_eye_outlined;
                                  } else {
                                    iconPassword = Icons.lock_outline;
                                  }
                                });
                              },
                              icon: Icon(iconPassword),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please fill in this field';
                              } else if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                                  .hasMatch(val)) {
                                return 'Please enter a valid password';
                              }
                              return null;
                            }),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "⚈  1 uppercase",
                                style: TextStyle(
                                    color: containsUpperCase
                                        ? Colors.green
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                              ),
                              Text(
                                "⚈  1 lowercase",
                                style: TextStyle(
                                    color: containsLowerCase
                                        ? Colors.green
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                              ),
                              Text(
                                "⚈  1 number",
                                style: TextStyle(
                                    color: containsNumber
                                        ? Colors.green
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "⚈  1 special character",
                                style: TextStyle(
                                    color: containsSpecialChar
                                        ? Colors.green
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                              ),
                              Text(
                                "⚈  8 minimum character",
                                style: TextStyle(
                                    color: contains8Length
                                        ? Colors.green
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: MyTextField(
                            controller: nameController,
                            hintText: 'Name',
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            prefixIcon: const Icon(Icons.person),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please fill in this field';
                              } else if (val.length > 30) {
                                return 'Name too long';
                              }
                              return null;
                            }),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) return;

                              context.read<AuthCubit>().signUp(
                                    emailController.text,
                                    passwordController.text,
                                    nameController.text,
                                  );
                            },
                            style: TextButton.styleFrom(
                                elevation: 3.0,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              child: Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
