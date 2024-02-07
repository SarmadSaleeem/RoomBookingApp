import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nfs_room_booking/Pages/LoginPage.dart';

void main(){

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Login", (widgetTester) async {

    await widgetTester.pumpWidget(const MaterialApp(home: Login(),));

    final Finder emailField = find.byKey(const ValueKey<String>("EmailInputField"));

    await widgetTester.enterText(emailField, "sarmadawan81@gmail.com");

    final Finder passwordField = find.byKey(const ValueKey<String>("PasswordInputField"));

    await widgetTester.enterText(passwordField, "1AllahisGreat@");

    final Finder button = find.byKey(const ValueKey<String>("LoginButton"));

    await widgetTester.tap(button);



    await widgetTester.pumpAndSettle();

    expect(find.text("Invalid Email or Password"), findsOneWidget);

    // widgetTester.ensureVisible();





  });
}