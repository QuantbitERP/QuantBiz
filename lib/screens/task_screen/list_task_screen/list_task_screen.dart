import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:geolocation/screens/visit_screens/visit_List/visit_list_model.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';
import 'list_task_ViewModel.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return  ViewModelBuilder<TaskListViewModel>.reactive(
        viewModelBuilder: () => TaskListViewModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child)=> Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(title: const Text('My Tasks'),
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
                  child: model.taskList.isNotEmpty
                      ? ListView.separated(
                    controller: ScrollController(keepScrollOffset: false),

                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (builder, index) {
                      return Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                              context, model.taskList[index]),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1,
                                      color: model.getColorForPriority(model.taskList[index].priority.toString()),
                                    ),
                                  ),


                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                                      child: AutoSizeText(model.taskList[index].priority ?? "",  textAlign:
                                      TextAlign.center,
                                        style:  TextStyle(
                                          color: model.getColorForPriority(model.taskList[index].priority.toString()),
                                          fontWeight:
                                          FontWeight.bold,
                                        ),),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1,
                                      color: model.getColorForStatus(model.taskList[index].status.toString()),
                                    ),
                                  ),
                                    // color:model.getColorForStatus(model.expenselist[index].approvalStatus.toString()),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                                      child: AutoSizeText(model.taskList[index].status ?? "",  textAlign:
                                      TextAlign.center,
                                        style:  TextStyle(
                                          color: model.getColorForStatus(model.taskList[index].status.toString()),
                                          fontWeight:
                                          FontWeight.bold,
                                        ),),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              AutoSizeText(model.taskList[index].projectName ?? "",
                                minFontSize: 19,
                                style: const TextStyle(

                                  fontWeight:
                                  FontWeight.bold,
                                ),),
                              AutoSizeText(model.taskList[index].subject ?? "",
                                minFontSize: 19,
                                style: const TextStyle(
                                  color: Colors.grey,

                                  fontWeight:
                                  FontWeight.bold,
                                ),),
                              if(model.taskList[index].expEndDate != "")
                              Row(
                                children: [
                                  Icon(Icons.timer),
                                  SizedBox(width: 10,),
                                  AutoSizeText(model.taskList[index].expEndDate ?? "",
                                  minFontSize: 16,
                                    style: const TextStyle(

                                      fontWeight:
                                      FontWeight.w500,
                                    ),),
                                ],
                              ),
                              Divider(),
Row(

  children: [
  Icon(Icons.comment),
  SizedBox(width: 12,),
  Text("${model.taskList[index].numComments ?? 0}"),SizedBox(width: 8,),

  Text(model.taskList[index].assignedBy?.user ?? "",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),)
],)
                              ,SizedBox(height: 10,),
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
                    itemCount: model.taskList.length,
                  ): Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const Text('Sorry, you got nothing!',textDirection: TextDirection.ltr,style: TextStyle(fontWeight: FontWeight.w700),),),
                  )
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


}
