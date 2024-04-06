import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';
import '../../widgets/customtextfield.dart';
import '../../widgets/text_button.dart';
import 'change_password_model.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    // Choose the color scheme based on the current theme
    return ViewModelBuilder<ChangePasswordModel>.reactive(
      viewModelBuilder: () => ChangePasswordModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Change Password',
            style: TextStyle(fontSize: 18, ),
          ),
          leading: IconButton.outlined(
            onPressed: () =>  Navigator.pop(context),
            icon:  const Icon(Icons.arrow_back, ),
          ),
        ),
        body: fullScreenLoader(
          loader: model.isBusy,
          context: context,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Form(
                key: model.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 10,),
                    CustomSmallTextFormField(prefixIcon:Icons.lock_outlined,controller: model.currentpasswordcontroller,labelText:'Current Password' ,hintText: 'Enter the password',onChanged: model.setcurrentpassword,validator: model.validatcurrentpass,),
                    const SizedBox(height: 10,),
                    CustomSmallTextFormField(prefixIcon:Icons.lock_outlined,controller: model.newpasswordcontroller,labelText:'New Password' ,hintText: 'Enter the password',onChanged: model.setnewpassword,validator: model.validatnewpass,),
                    const SizedBox(height: 20,),
                    CtextButton(onPressed: () => model.onSavePressed(context), text: 'Change Password', buttonColor: Colors.blueAccent.shade400,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
