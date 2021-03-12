import 'package:flutter/material.dart';

import '../../localization/localizations.dart';

class CreateAnAccountButton extends StatelessWidget {
  final VoidCallback? _onPressed;

  CreateAnAccountButton({Key? key, VoidCallback? onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: _onPressed,
      child: Text(AppLocalizations.of(context).singup),
      fillColor: Colors.redAccent,
    );
  }
}
