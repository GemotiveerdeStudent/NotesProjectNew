import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/services/auth/bloc/auth_bloc.dart';
import 'package:notes/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify E-mail'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(children: [
        const Text(
            'Verify E-mail has been send. Please check your E-mail to verify your account'),
        const Text(
            'If you have not received the E-mail, please click the button below to resend the E-mail'),
        TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(
                  const AuthEventSendEmailVerification(),
                );
          },
          child: const Text('Send E-mail Verification'),
        ),
        TextButton(
          onPressed: () async {
            context.read<AuthBloc>().add(
                  const AuthEventLogOut(),
                );
          },
          child: const Text('Restart'),
        ),
      ]),
    );
  }
}
