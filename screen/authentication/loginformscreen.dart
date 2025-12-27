import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktokclone/repos/login_view_model.dart';
import 'package:ticktokclone/repos/signup_view_model.dart';
import 'package:ticktokclone/screen/interests.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';
import 'package:ticktokclone/widgets/button/formbutton.dart';

class formScreen extends ConsumerStatefulWidget {
  const formScreen({super.key});

  @override
  ConsumerState<formScreen> createState() => _formScreenState();
}

class _formScreenState extends ConsumerState<formScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onSubmittedTap(BuildContext context) {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        ref
            .read(signinProvider.notifier)
            .signin(_formData['email']!, _formData['password']!, context);
      }
    }
  }

  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log in"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.size36,
          vertical: Sizes.size28,
        ),

        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Add more validation logic if needed
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    _formData['email'] = newValue;
                  }
                },
              ),
              Gaps.v20,
              TextFormField(
                decoration: InputDecoration(hintText: "Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  // Add more validation logic if needed
                  return null;
                },
                obscureText: true,
                onSaved: (newValue) {
                  if (newValue != null) {
                    _formData['password'] = newValue;
                  }
                },
              ),
              Gaps.v20,
              GestureDetector(
                onTap: () => onSubmittedTap(context),
                child: FormButton(
                  isInput: true,
                  disabled: ref.watch(signUpProvider).isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
