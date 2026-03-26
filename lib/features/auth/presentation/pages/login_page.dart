import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_event.dart';
import 'package:clean_architecture_test/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
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
                  Icon(Icons.lock_outline, size: 80.0, color: Colors.blue),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    controller: _emailController,
                    enabled: !isLoading,
                    keyboardType: TextInputType.emailAddress,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefix: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    enabled: !isLoading,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefix: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter password';
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
                        : Text('Login'),
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
