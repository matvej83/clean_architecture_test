import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_event.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/app_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var obscure = true;

  void handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthLoginRequested(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  void obscureIcon() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  void initState() {
    _emailController.text = 'john@mail.com';
    _passwordController.text = 'changeme';
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('loginScreen.screenName'.tr()),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = state.isLoading;
          return SingleChildScrollView(
            padding: EdgeInsetsGeometry.only(
              top: 24.0,
              left: 24.0,
              right: 24.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16.0,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 80.0,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(height: 40.0),
                  AppTextFormField(
                    controller: _emailController,
                    enabled: !isLoading,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'loginScreen.fieldNameEmail'.tr(),
                      prefix: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'fieldValidation.enterPassword'.tr();
                      }
                      return null;
                    },
                  ),
                  AppTextFormField(
                    controller: _passwordController,
                    enabled: !isLoading,
                    obscureText: obscure,
                    decoration: InputDecoration(
                      labelText: 'loginScreen.fieldNamePassword'.tr(),
                      prefix: GestureDetector(
                        onTap: obscureIcon,
                        child: Icon(obscure ? Icons.lock : Icons.lock_open),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'fieldValidation.enterPassword'.tr();
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: isLoading ? null : handleLogin,
                    child: isLoading
                        ? SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(strokeWidth: 2.0),
                          )
                        : Text('loginScreen.btnLogin'.tr()),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.error?.isNotEmpty == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
      ),
    );
  }
}
