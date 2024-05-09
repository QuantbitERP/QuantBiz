
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/lead_screen/update_screen/update_viewmodel.dart';
import 'package:geolocation/screens/visit_screens/update_visit/update_visit_viewmodel.dart';
import 'package:geolocation/widgets/customtextfield.dart';
import 'package:geolocation/widgets/drop_down.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';


class UpdateVisitScreen extends StatefulWidget {
  final String updateId;
  const UpdateVisitScreen({super.key, required this.updateId});

  @override
  State<UpdateVisitScreen> createState() => _UpdateVisitScreenState();
}

class _UpdateVisitScreenState extends State<UpdateVisitScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateVisitModel>.reactive(
        viewModelBuilder: () => UpdateVisitModel(),
        onViewModelReady: (model) => model.initialise(context, widget.updateId),
        builder: (context, model, child) =>
            Scaffold(
              appBar: AppBar(title: Text(model.visitdata.name ?? "",
                style: const TextStyle(fontSize: 18),),
                actions: [
                  IconButton(onPressed: () =>
                      Navigator.pushNamed(context, Routes.addVisitScreen,
                          arguments: AddVisitScreenArguments(
                              VisitId: widget.updateId)),
                      icon: const Icon(Icons.edit)),
                ],
                leading: IconButton.outlined(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back)),),
              body: fullScreenLoader(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(flex: 4,
                              child: AutoSizeText(
                                "${model.visitdata.name.toString()}\n${model
                                    .visitdata.date}-${model.visitdata.time}",

                                style: const TextStyle(
                                    fontWeight:
                                    FontWeight.w500,
                                    color: Colors.black54
                                ),),
                            ),
                            Expanded(
                                flex: 3,
                                child: Card(color: Colors.blue,
                                  shape:
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        20.0),
                                    // Set border color and width
                                  ),
                                  // color:model.getColorForStatus(model.expenselist[index].approvalStatus.toString()),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: AutoSizeText(
                                      model.visitdata.visitType ?? "",
                                      textAlign:
                                      TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),),
                                  ),
                                )
                            ),
                          ],
                        ),
                        Divider(),
                        buildItemColumn(labelText: "Customer name",
                            additionalText: model.visitdata.customerName ?? ""),
                        SizedBox(height: 15),
                        buildItemColumn(labelText: "Employee",
                            additionalText: model.visitdata.employee ?? ""),
                        SizedBox(height: 15),
                        buildItemColumn(labelText: "Description",
                            additionalText: model.visitdata.description ?? ""),

                      ],
                    ),
                  ),
                ),
                loader: model.isBusy,
                context: context,
              ),
              // floatingActionButton: FloatingActionButton(onPressed: ()=> Navigator.pushNamed(context, Routes.addLeadScreen,arguments: AddLeadScreenArguments(leadid: '')),child: Icon(Icons.add),),
            ));
  }

  Widget buildItemColumn(
      {required String additionalText, required String labelText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          labelText, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),minFontSize: 18,),
        AutoSizeText(
          additionalText, style: const TextStyle(fontWeight: FontWeight.w500),minFontSize: 17),
      ],
    );
  }
}