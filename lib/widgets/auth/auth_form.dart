import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class AuthForm extends StatefulWidget {
  final bool _isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    String userLastname,
    bool isLoginMode,
    BuildContext ctx,
  ) _submitAuthForm;

  AuthForm(
    this._submitAuthForm,
    this._isLoading,
  );

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userPassword = '';
  var _userName = '';
  var _userLastname = '';
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!
        .validate(); // trigger all TextFormField for validation
    FocusScope.of(context).unfocus(); // close keyboard
    if (isValid) {
      _formKey.currentState!.save(); //
      widget._submitAuthForm(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userLastname.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey, // necessarily create key for form
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // so that the column does not take up all the available space,
                // but only the space needed by its children
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: 'Email address'),
                    validator: (value) {
                      bool isEmailValid = EmailValidator.validate(value!);
                      //print(value);
                      if (!isEmailValid) {
                        //print(isEmailValid);
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    obscureText:
                        _passwordVisible, //obscureText - hidden or not password input
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          }),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 3) {
                          return 'Username must be at least 3 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('lastname'),
                      decoration: const InputDecoration(labelText: 'Lastname'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 3) {
                          return 'Lastname must be at least 3 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userLastname = value!;
                      },
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget._isLoading)
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  if (!widget._isLoading)
                    ElevatedButton(
                        child: Text(_isLogin ? 'Login' : 'Sing up'),
                        onPressed: _trySubmit),
                  if (!widget._isLoading)
                    TextButton(
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'I already have an account'),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
