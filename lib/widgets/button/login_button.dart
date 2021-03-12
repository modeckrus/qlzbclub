import 'package:flutter/material.dart';

import '../../localization/localizations.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? _onPressed;

  LoginButton({Key? key, VoidCallback? onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: _onPressed,
      child: Text(AppLocalizations.of(context).login),
    );
  }
}
