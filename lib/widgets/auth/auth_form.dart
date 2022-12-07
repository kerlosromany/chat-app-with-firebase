import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    bool islogin,
    BuildContext ctx,
  ) submitFun;
  final bool isLoading;
  AuthForm(this.submitFun, this.isLoading);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _username = "";
  bool _isLogin = true;
  void _submit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFun(
          _email.trim(), _password.trim(), _username.trim(), _isLogin, context);
    }    
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey("email"),
                  decoration: const InputDecoration(
                    label: Text("Email Address"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return "Email does not validate please try again";
                    }
                    return null;
                  },
                  onSaved: (val) => _email = val!,
                  keyboardType: TextInputType.emailAddress,
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey("username"),
                    decoration: const InputDecoration(
                      label: Text("Username"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return "Please enter at least 4 characters";
                      }
                      return null;
                    },
                    onSaved: (val) => _username = val!,
                  ),
                TextFormField(
                  key: ValueKey("password"),
                  decoration: const InputDecoration(
                    label: Text("Password"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return "Please enter at least 7 characters";
                    }
                    return null;
                  },
                  onSaved: (val) => _password = val!,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                // if(widget.isLoading)
                //   CircularProgressIndicator(),
                if(!widget.isLoading)
                  ElevatedButton(
                      onPressed: _submit,
                      child: Text(_isLogin ? "Login" : "Sign Up")),
                if(!widget.isLoading)
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? "Create new account"
                          : "I already have an account")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
