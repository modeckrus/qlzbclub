import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../localization/localizations.dart';
import 'bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                constraints: BoxConstraints(maxWidth: 600),
                child: _EmailInput()),
            const Padding(padding: EdgeInsets.all(12)),
            Container(
                constraints: BoxConstraints(maxWidth: 600),
                child: _PasswordInput()),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<LoginBloc>().add(LoginEmailChanged(email)),
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).email,
            errorText: state.email.invalid
                ? AppLocalizations.of(context).invalidEmail
                : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).password,
            errorText: state.password.invalid
                ? AppLocalizations.of(context).password
                : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final isInv = state.status.isInvalid || state.status.isPure;
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: RawMaterialButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: Text(
                      AppLocalizations.of(context).login,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  mouseCursor: isInv
                      ? SystemMouseCursors.forbidden
                      : SystemMouseCursors.click,
                  fillColor: isInv
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).buttonColor,
                  onPressed: isInv
                      ? null
                      : () {
                          context.read<LoginBloc>().add(const LoginSubmitted());
                        },
                ),
              );
      },
    );
  }
}
