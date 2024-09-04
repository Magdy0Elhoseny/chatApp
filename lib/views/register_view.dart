// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/views/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:chat_app/widgets/costum_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';

class RegisterView extends StatelessWidget {
  static String id = '/RegisterView';
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
          showSnackBar(context, 'it\'s loading plase wait.');
        } else if (state is RegisterSuccess) {
          isLoading = false;
          showSnackBar(context, 'Login Success.');
          Navigator.pushNamed(context, ChatView.id);
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: const Color(0xff2B475E),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: formkey,
                child: ListView(
                  children: [
                    const SizedBox(height: 75),
                    Image.asset('assets/images/scholar.png', height: 100),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Schalar Chat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'pacifico',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 75),
                    const Row(
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            //fontFamily: 'pacifico',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      isPassword: true,
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: 'password',
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                              email: email!, password: password!));
                        } else {}
                      },
                      buttonName: 'Register',
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'already have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '  Login',
                            style: TextStyle(
                              color: Color(0xffC7EDE6),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
