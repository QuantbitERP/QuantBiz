import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocation/widgets/drop_down.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:geolocation/widgets/text_button.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/customtextfield.dart';
import 'add_visit_viewmodel.dart';

class AddVisitScreen extends StatefulWidget {
final String VisitId;
  const AddVisitScreen({super.key, required this.VisitId});

  @override
  State<AddVisitScreen> createState() => _AddVisitScreenState();
}

class _AddVisitScreenState extends State<AddVisitScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddVisitViewModel>.reactive(
        viewModelBuilder: () => AddVisitViewModel(),
        onViewModelReady: (model) => model.initialise(context,widget.VisitId),
        builder: (context, model, child)=>Scaffold(

          appBar:AppBar(title:   Text(model.isEdit? (model.visitdata.name ?? ""):'Create Visit',style: TextStyle(fontSize: 18),),
            leading: IconButton.outlined(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back)),actions: [
               IconButton.outlined(onPressed: ()=>model.onSavePressed(context), icon: const Icon(Icons.check))
            ],),
          body: fullScreenLoader(
            loader: model.isBusy,context: context,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      CustomDropdownButton2(value: model.visitdata.customer,items:model.customer, hintText: 'select the customer', onChanged: model.setcustomer, labelText: 'Customer'),

                      const SizedBox(height: 15,),
CustomDropdownButton2(value: model.visitdata.visitType,items:model.visitType, hintText: 'select the visit type', onChanged: model.seteleavetype, labelText: 'Visit Type'),
                      const SizedBox(height: 15,),

                      CustomSmallTextFormField(controller: model.descriptoncontroller, labelText: 'Description', hintText: 'Enter the Description',validator: model.validatedescription,onChanged: model.setdescription,),

                      const SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Expanded(child: CtextButton(onPressed: () => Navigator.of(context).pop(), text: 'Cancel', buttonColor: Colors.redAccent.shade400,)),
                          SizedBox(width: 20),
                          Expanded(child: CtextButton(onPressed: ()=> model.onSavePressed(context), text:model.isEdit? 'Update Visit':'Create Visit', buttonColor: Colors.blueAccent.shade400,))
              ]
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),  ));
  }
}