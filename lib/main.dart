import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/constants/routes.dart';
import 'package:notes/helpers/loading/loading_screen.dart';
import 'package:notes/services/auth/bloc/auth_bloc.dart';
import 'package:notes/services/auth/bloc/auth_event.dart';
import 'package:notes/services/auth/bloc/auth_state.dart';
import 'package:notes/services/auth/firebase_auth_provider.dart';
import 'package:notes/views/forgot_password_view.dart';
import 'package:notes/views/notes/create_update_note_view.dart';
import 'package:notes/views/notes/notes_view.dart';
import 'package:notes/views/register_view.dart';
import 'package:notes/views/login_view.dart';
import 'package:notes/views/verify_email_view.dart';

// This file represents the main flow in the application. Bloc is used to manage the state of the application, 
// based on these states the UI is updated.


void main() {
  // Ensure that Flutter bindings are initialized before running the app. this is the glue that connects the Flutter framework to the engine.
  // Making sure all the pieces are out of the box and ready to be used.
  WidgetsFlutterBinding.ensureInitialized();

  // Run the actual Flutter application
  runApp(
    MaterialApp( // A widget that defines the basic material design visual layout structure.
      title: 'Notes Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 96, 150, 219)),
        useMaterial3: true,
      ),
      home: BlocProvider<AuthBloc>( 
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      // The only route not dependent on the AuthBloc is the CreateOrUpdateNoteView route.
      routes: {
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}


// The HomePage widget is the main widget of the application. 
// It is responsible for managing the state of the application and displaying the appropriate UI based on the state.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>( // A widget that listens to the state changes of the AuthBloc and rebuilds the UI accordingly. 
                                              // It is using 2 parameters, the listener and the builder.
      
      listener: (context, state) { // The listener is used to listen to the state changes of the AuthBloc and perform side effects accordingly, like the loading screen.
        if (state is AuthStateLoggedOut) { // If the state is AuthStateLoggedOut and the state is loading the application will show the loading screen.
          if (state.isLoading) {
            LoadingScreen().show(
              context : context,
              text: state.loadingText ?? 'Please wait a moment',
            );
          } else { // If the state is not loading the application will hide the loading screen.
            LoadingScreen().hide();
          }
        }
      },

  // The BlocConsumer widget is used to listen to the state changes of the AuthBloc and rebuild the UI accordingly. 
  // this is the navigation in the application through the Bloc States.
  // The states are defined by looking at the AuthState class. some key elements in this are :
  // Unregistered/Registered, LoggedIn/LoggedOut, NeedsVerification and Forgot Password.
      builder: (context, state) {
        
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
