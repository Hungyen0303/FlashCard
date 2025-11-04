import 'package:flashcard_learning/l10n/app_localization.dart';
import 'package:flashcard_learning/routing/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../utils/LoadingOverlay.dart';
import '../../../../utils/color/AllColor.dart';
import '../../login/view_models/login_viewmodel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Color palette matching the login page
  static const Color primaryColor = Color(0xFF4361EE);
  static const Color secondaryColor = Color(0xFF3A0CA3);
  static const Color accentColor = Color(0xFF7209B7);
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color darkText = Color(0xFF212529);
  static const Color lightText = Color(0xFF6C757D);

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  Future<void> _signUp() async {
    final l10n = context.l10n;

    if (_formKey.currentState!.validate()) {
      LoadingOverlay.show(context);
      try {
        await Provider.of<LoginViewModel>(context, listen: false).signUp(
          _emailController.text,
          _usernameController.text,
          _passwordController.text,
        );

        if (mounted) {
          LoadingOverlay.hide();
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: l10n.register_done,
              text: l10n.register_done_body,
              confirmBtnColor: primaryColor,
              onConfirmBtnTap: () {
                context.go(AppRoute.login);
              });
        }
      } catch (error) {
        if (mounted) {
          LoadingOverlay.hide();
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: l10n.register_failed,
            text: error.toString(),
            confirmBtnColor: Colors.red,
          );
        }
      }
    }
  }

  void _scrollToFocusedField(double offset) {
    Future.delayed(const Duration(milliseconds: 250), () {
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: lightBackground,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Header Section (same as login page)
            Container(
              height: 280,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [primaryColor, secondaryColor],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FlutterLogo(size: 80), // Replace with your logo
                    const SizedBox(height: 20),
                    Text(
                      l10n.register_create_account,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.register_subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Registration Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: l10n.register_email,
                        prefixIcon: Icon(Icons.email, color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.register_email_required;
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return l10n.register_email_invalid;
                        }
                        return null;
                      },
                      onTap: () => _scrollToFocusedField(200),
                    ),

                    const SizedBox(height: 20),

                    // Username Field
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: l10n.register_username,
                        prefixIcon: Icon(Icons.person, color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.register_username_required;
                        }
                        return null;
                      },
                      onTap: () => _scrollToFocusedField(250),
                    ),

                    const SizedBox(height: 20),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: l10n.register_password,
                        prefixIcon: Icon(Icons.lock, color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.register_password_required;
                        } else if (value.length < 6) {
                          return l10n.register_password_min_length;
                        }
                        return null;
                      },
                      onTap: () => _scrollToFocusedField(300),
                    ),

                    const SizedBox(height: 20),

                    // Confirm Password Field
                    TextFormField(
                      controller: _retypePasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: l10n.register_confirm_password,
                        prefixIcon:
                            Icon(Icons.lock_outline, color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.register_confirm_password_required;
                        } else if (value != _passwordController.text) {
                          return l10n.register_password_not_match;
                        }
                        return null;
                      },
                      onTap: () => _scrollToFocusedField(350),
                    ),

                    const SizedBox(height: 30),

                    // Sign Up Button
                    ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        shadowColor: primaryColor.withOpacity(0.3),
                      ),
                      child: Text(
                        l10n.register_sign_up_button,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Already have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.register_have_account,
                          style: TextStyle(color: lightText),
                        ),
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Text(
                            l10n.register_login,
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
