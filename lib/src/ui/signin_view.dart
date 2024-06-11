
import 'package:finwise/src/ui/welcome_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentication/authentication_bloc.dart';
import '../bloc/form/form_bloc.dart';
import '../res/strings/english_strings.dart';
import 'home_view.dart';
import 'signup_view.dart';

OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));

class SignInView extends StatelessWidget {
  static const String id = 'sign_in_view';
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocListener(
      listeners: [
        BlocListener<FormBloc, FormsValidate>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      ErrorDialog(errorMessage: state.errorMessage));
            } else if (state.isFormValid && !state.isLoading) {
              context.read<AuthenticationBloc>().add(AuthenticationStarted());
            } else if (state.isFormValidateFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(EnglishStrings.textFixIssues)));
            }
          },
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeView.id,
                      (Route<dynamic> route) => false);
            }
          },
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.white),
          ),
          backgroundColor: Constants.kPrimaryColor,
          body: Center(
              child: SingleChildScrollView(
                child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset("assets/icons/logo.png"),
                  RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: EnglishStrings.textSignInTitle,
                            style: TextStyle(
                              color: Constants.kBlackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            )),
                      ])),
                  SizedBox(height: size.height * 0.01),
                  const Text(
                    EnglishStrings.textSmallSignIn,
                    style: TextStyle(color: Constants.kDarkGreyColor),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
                  const _EmailField(),
                  SizedBox(height: size.height * 0.01),
                  const _PasswordField(),
                  SizedBox(height: size.height * 0.01),
                  const _SubmitButton(),
                  const _SignInNavigate(),
                ]),
              ))),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
              onChanged: (value) {
                context.read<FormBloc>().add(EmailChanged(value));
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                helperText: 'A complete, valid email e.g. joe@gmail.com',
                errorText: !state.isEmailValid
                    ? 'Please ensure the email entered is valid'
                    : null,
                hintText: 'Email',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                border: border,
              )),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: border,
              helperText:
              '''Password should be at least 8 characters with at least one letter and number''',
              helperMaxLines: 2,
              labelText: 'Password',
              errorMaxLines: 2,
              errorText: !state.isPasswordValid
                  ? '''Password must be at least 8 characters and contain at least one letter and number'''
                  : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(PasswordChanged(value));
            },
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
          width: size.width * 0.8,
          child: OutlinedButton(
            onPressed: !state.isFormValid
                ? () => context
                .read<FormBloc>()
                .add(const FormSubmitted(value: Status.signIn))
                : null,
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                    Constants.kPrimaryColor),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Constants.kBlackColor),
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide.none)),
            child: const Text(EnglishStrings.textSignIn),
          ),
        );
      },
    );
  }
}

class _SignInNavigate extends StatelessWidget {
  const _SignInNavigate();

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: <TextSpan>[
          const TextSpan(
              text: EnglishStrings.textAcc,
              style: TextStyle(
                color: Constants.kDarkGreyColor,
              )),
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () => {
                  Navigator.of(context).pop(),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpView()),
                  )
                },
              text: EnglishStrings.textSignUp,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Constants.kDarkBlueColor,
              )),
        ]));
  }
}

class ErrorDialog extends StatelessWidget {
  final String? errorMessage;
  const ErrorDialog({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(errorMessage!),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}