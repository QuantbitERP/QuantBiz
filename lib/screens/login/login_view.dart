import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stacked/stacked.dart';

import 'login_model.dart';

class LoginViewScreen extends StatefulWidget {
  const LoginViewScreen({super.key,});

  @override
  State<LoginViewScreen> createState() => _LoginViewScreenState();
}

class _LoginViewScreenState extends State<LoginViewScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onViewModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        body: WillPopScope(
          onWillPop: showExitPopup,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF005BEA), Color(0xFF00C6FB)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        child:  Image.asset('assets/images/atom.png',scale: 7,)
                      ),

                      const SizedBox(height: 40),
                      const AutoSizeText(
                        "Let's sign you in",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        minFontSize: 30,
                      ),
                      const AutoSizeText(
                        "Enter below details to continue",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        minFontSize: 18,
                      ),
                      const SizedBox(height: 45),
                      Form(
                        key: model.formGlobalKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: model.urlController,
                              style: const TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                // labelText: "Username",
                                hintText: "Enter workplace url",
                                hintStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                prefixIcon: const Icon(FontAwesome.earth_asia,
                                    color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                filled: true,
                                fillColor: const Color.fromRGBO(255, 255, 255, 1),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16.0),
                              ),
                              autofillHints: const [AutofillHints.url],
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: model.usernameController,
                              style: const TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                // labelText: "Email address or Mobile Number",
                                hintText: "Email address or Mobile Number",
                                hintStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                prefixIcon: const Icon(Icons.person_sharp),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                filled: true,
                                fillColor: const Color.fromRGBO(255, 255, 255, 1),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16.0),
                              ),
                              autofillHints: const [AutofillHints.username],
                              onEditingComplete: () {
                                TextInput.finishAutofillContext();
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              validator: (value) => model.validateUsername(value),
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              style: const TextStyle(color: Colors.black87),
                              controller: model.passwordController,
                              obscureText: model.obscurePassword,
                              decoration: InputDecoration(
                                // labelText: "Password",
                                hintText: "Password",
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      model.obscurePassword =
                                          !model.obscurePassword;
                                    });
                                  },
                                  child: Icon(
                                    model.obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                                hintStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                prefixIcon: const Icon(Icons.lock_outlined),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                filled: true,
                                fillColor: const Color.fromRGBO(255, 255, 255, 1),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16.0),
                              ),
                              autofillHints: const [AutofillHints.password],
                              onEditingComplete: () {
                                TextInput.finishAutofillContext();
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              validator: (value) => model.validatePassword(value),
                            ),
                            const SizedBox(height: 36.0),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF007BFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (model.formGlobalKey.currentState!
                                      .validate()) {
                                    model.formGlobalKey.currentState!.save();
                                    model.loginwithUsernamePassword(context);
                                  }
                                },
                                child: model.isLoading
                                    ? LoadingAnimationWidget.hexagonDots(
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    : const Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      const SizedBox(height: 80),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Try Our Demo App",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF007BFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () =>model.loginWithDemoUser(context),
                                child:model.isDemoLoading
                                    ? LoadingAnimationWidget.hexagonDots(
                                  color: Colors.white,
                                  size: 18,
                                )
                                    : const Text(
                                  'Continue as Demo User >',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit an App?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:const Text('No'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            child:const Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }
}
