import 'package:flutter/material.dart';
import 'package:notes/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset Email Sent',
    content: 'We have now sent you an email with instructions on how to reset your password.',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}