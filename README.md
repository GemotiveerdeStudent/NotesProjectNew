<<<<<<< HEAD
# NotesProjectNew
=======
# notes

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Mirror android device

use : https://github.com/Genymobile/scrcpy + ADB, Please watch https://www.youtube.com/watch?v=gOQeEXVa2Wo minute : 1 - 15
or use anroid studio.

## Starting the project

Powershell

- Navigate to the Flutter folder
- flutter create --org com.firstproject 'Projectname'
- cd 'Porjectname'
- code .

## Search dependencies

Check www.pub.dev for pubspec.yaml dependencies.

- Search : cupertino_icons: ^1.0.6 ( an already existing depencency), you can also do this for the added firebase dependencies.

## Add dependencies

in Terminal write the following 4 commands :

- flutter pub add firebase_core
- flutter pub add firebase_auth
- flutter pub add cloud_firestore
- flutter pub add firebase_analytics


## Fitebase init 
https://www.youtube.com/watch?v=KDzkbcBNdVo&list=PL6yRaaP0WPkVtoeNIGqILtRAgd3h2CNpT&index=12 - Vandad outdated method, gives good insight so worth watch. 
https://firebase.google.com/docs/flutter/setup?platform=android

Run following commands 

- flutter doctor 
- npm i -g firebase-tools
- Firebase login
- dart pub global activate flutterfire_cli
- flutterfire configure
- Add to Path envrionment variable , Windows key > Environment > Bottom button > Add NEW path

- Firebase logout
- Firebase login
>>>>>>> master
