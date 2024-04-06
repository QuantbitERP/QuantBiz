import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocation/widgets/drop_down.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:geolocation/widgets/text_button.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/customtextfield.dart';
import 'add_leave_viewmodel.dart';

class AddLeaveScreen extends StatefulWidget {

  const AddLeaveScreen({super.key});

  @override
  State<AddLeaveScreen> createState() => _AddLeaveScreenState();
}

class _AddLeaveScreenState extends State<AddLeaveScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddLeaveViewModel>.reactive(
        viewModelBuilder: () => AddLeaveViewModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child)=>Scaffold(

          appBar:AppBar(title:  const Text('Create Leave',style: TextStyle(fontSize: 18),),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: model.fromdatecontroller,
                              onTap: () => model.selectfromDate(context),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                labelText: 'From Date',
                                hintText: 'Enter the from Date',
                                prefixIcon:const Icon(Icons.calendar_today_rounded),
                                labelStyle: const TextStyle(
                                  color: Colors.black54, // Customize label text color
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.grey, // Customize hint text color
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.blue, // Customize focused border color
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey, // Customize enabled border color
                                  ),
                                ),
                              ),
                              validator: model.validatedate,
                              onChanged: model.setfromdate,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: model.todatecontroller,
                              onTap: () => model.selecttoDate(context),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                                labelText: 'to date',
                                hintText: 'Enter the to Date',
                                prefixIcon:const Icon(Icons.calendar_today_rounded),
                                labelStyle: const TextStyle(
                                  color: Colors.black54, // Customize label text color
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.grey, // Customize hint text color
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.blue, // Customize focused border color
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey, // Customize enabled border color
                                  ),
                                ),
                              ),
                              validator: model.validatedate,
                              onChanged: model.settodate,
                            ),
                          ),
                        ],
                      ),
const SizedBox(height: 15,),
CustomDropdownButton2(items:model.leavetype, hintText: 'select the leave type', onChanged: model.seteleavetype, labelText: 'Leave Type'),
                      const SizedBox(height: 15,),


                  SwitchListTile(
                    title: Text('Half Day'), // The title of the ListTile
                    subtitle:
                    Text('Click here for the half day'), // Optional subtitle
                    secondary: Icon(Icons.view_day_outlined
                    ), // Optional leading icon
                    onChanged: model.toggleSwitch,
                    value: model.isSwitched,
                  ),



                      if(model.leavedata.halfDay==1)
                      TextFormField(
                        readOnly: true,
                        controller: model.halfdaycontroller,
                        onTap: () => model.selecthalfDate(context),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          labelText: 'Half day date',
                          hintText: 'Enter the half day date',
                          prefixIcon:const Icon(Icons.calendar_today_rounded),
                          labelStyle: const TextStyle(
                            color: Colors.black54, // Customize label text color
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.grey, // Customize hint text color
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide: const BorderSide(
                              color: Colors.blue, // Customize focused border color
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide: const BorderSide(
                              color: Colors.grey, // Customize enabled border color
                            ),
                          ),
                        ),

                        onChanged: model.sethalfdate,
                      ),const SizedBox(height: 15,),CustomSmallTextFormField(controller: model.descriptoncontroller, labelText: 'Reason', hintText: 'Enter the Description',validator: model.validatedescription,onChanged: model.setdescription,),

                      const SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Expanded(child: CtextButton(onPressed: () => Navigator.of(context).pop(), text: 'Cancel', buttonColor: Colors.redAccent.shade400,)),
                          SizedBox(width: 20),
                          Expanded(child: CtextButton(onPressed: ()=> model.onSavePressed(context), text:'Create Leave', buttonColor: Colors.blueAccent.shade400,))
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