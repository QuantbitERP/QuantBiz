import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/visit_screens/visit_List/visit_list_model.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return  ViewModelBuilder<VisitViewModel>.reactive(
        viewModelBuilder: () => VisitViewModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child)=> Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(title: const Text('My Visits'),
            leading: IconButton.outlined(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back)),

          ),
          body: WillPopScope(
            onWillPop: ()  async{
              Navigator.pop(context);
              return true; },
            child: fullScreenLoader(
              child: SingleChildScrollView(
                // controller: ScrollController(keepScrollOffset: false),
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: model.visitList.isNotEmpty
                      ? ListView.separated(
                    controller: ScrollController(keepScrollOffset: false),

                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (builder, index) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                              // spreadRadius: 5,
                              blurRadius: 7,
                              // offset: const Offset(0, 3), // Customize the shadow offset
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          onPressed: () => model.onRowClick(
                              context, model.visitList[index]),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText("${model.visitList[index].name.toString()}\n${model.visitList[index].date}-${model.visitList[index].time}",

                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight.w500,
                                    ),),

                                  Card( color: Colors.blue,
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
                                      child: AutoSizeText(model.visitList[index].visitType ?? "",  textAlign:
                                      TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text( "Customer Name", style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w800)),

                              Text(model.visitList[index].customerName.toString(), style: const TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, builder) {
                      return  const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: model.visitList.length,
                  ): _buildEmptyContainer('No upcoming leave found for this year and month'),
                ),
              ),


              loader: model.isBusy,
              context: context,
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(onPressed: ()=>Navigator.pushNamed(context, Routes.addVisitScreen,arguments: AddVisitScreenArguments(VisitId: "")),
            label: const Text('Create Visit'),),
        ));
  }

  Widget _buildEmptyContainer(String message) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: 100,
      child: Center(child: Text(message)),
    );
  }
}
