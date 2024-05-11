import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:geolocation/screens/task_screen/update_task_screen/update_task_viewmodel.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';

import '../../../constants.dart';
import '../../../router.router.dart';


class UpdateTaskScreen extends StatefulWidget {
  final String updateTaskId;
  const UpdateTaskScreen({super.key, required this.updateTaskId});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateTaskViewModel>.reactive(
        viewModelBuilder: () => UpdateTaskViewModel(),
    onViewModelReady: (model) => model.initialise(context,widget.updateTaskId),
    builder: (context, model, child)=> Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.updateTaskId),
        actions: [
          IconButton(onPressed: ()=>Navigator.pushNamed(context, Routes.addTaskScreen,arguments: AddTaskScreenArguments(taskId: widget.updateTaskId)), icon: Icon(Icons.edit))
        ],
      ),
      body: SingleChildScrollView(

        padding: EdgeInsets.all(12),
        child: fullScreenLoader(loader: model.isBusy, child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
             model.taskData.projectName ?? "",

              style: const TextStyle(
                fontSize: 20,
                  fontWeight:
                  FontWeight.w500,
                  color: Colors.black
              ),),
            AutoSizeText(
             model.taskData.subject ?? "",

              style: const TextStyle(
                  fontSize: 20,
                  fontWeight:
                  FontWeight.w500,
                  color: Colors.black54
              ),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: model.getColorForPriority(model.taskData.priority.toString()),
                  ),
                ),


                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                    child: AutoSizeText(model.taskData.priority ?? "",  textAlign:
                    TextAlign.center,
                      style:  TextStyle(
                        color: model.getColorForPriority(model.taskData.priority.toString()),
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
                      color: model.getColorForStatus(model.taskData.status.toString()),
                    ),
                  ),
                  // color:model.getColorForStatus(model.expenselist[index].approvalStatus.toString()),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                    child: AutoSizeText(model.taskData.status ?? "",  textAlign:
                    TextAlign.center,
                      style:  TextStyle(
                        color: model.getColorForStatus(model.taskData.status.toString()),
                        fontWeight:
                        FontWeight.bold,
                      ),),
                  ),
                )
              ],
            ),
SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildItemColumn(additionalText: (model.taskData.expectedTime ?? 0.0).toString(), labelText: 'Expected Hrs'),
                buildItemColumn(additionalText: (model.taskData.expEndDate ?? 0.0).toString(), labelText: 'Due Date'),
                buildItemColumn(additionalText: (model.taskData.actualTime ?? 0.0).toString(), labelText: 'Actual Hrs'),
              ],),
            SizedBox(height: 10,),
            buildItemColumn(additionalText: model.taskData.description ?? "", labelText: 'Description'),
            SizedBox(height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                "Assigned By", style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),minFontSize: 16,),
              Row(

                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Product Image
                  ClipRRect(

                    borderRadius: BorderRadius.circular(8.0),
                    child:CachedNetworkImage(
                      imageUrl: '$baseurl${model.taskData.assignedBy?.userImage ?? ""}',
                      width: 15, // Set width to twice the radius for a complete circle
                      height: 15,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
                      errorWidget: (context, url, error) => Center(child: Image.asset('assets/images/profile.png', scale: 5)),
                    ),
                  ),
                  SizedBox(width: 10,),
                  AutoSizeText(
                   model.taskData.assignedBy?.fullName ?? "", style: const TextStyle(fontWeight: FontWeight.bold),minFontSize: 18,),

                ])
            ],
          ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 1, // Height of the divider
                    color: Colors.blueAccent, // Color of the divider
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Activity',
                  style: TextStyle(color: Colors.blueAccent,
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 1, // Height of the divider
                    color: Colors.blueAccent, // Color of the divider
                  ),
                ),

              ],
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: model.comment,
              decoration: InputDecoration(
                hintText: 'Comment Here',
                hintStyle: TextStyle(fontSize: 15),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.black45, width: 2),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: TextButton(
                    onPressed: () {
                      if (model.comment.text.isNotEmpty) {
                        model.addComment(model.taskData.name, model.comment.text);
                      }
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),


            model.comments.isNotEmpty
                ? ListView.separated(
              separatorBuilder: (context, builder) {
                return const SizedBox(
                  height: 5,
                );
              },
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: model.comments.length,
              itemBuilder: (context, index) {
                final comment = model.comments[index];
                return ListTile(
                  leading: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: comment.userImage ?? '',
                      width: 40,
                      matchTextDirection: true,
                      height: 40,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
                      errorWidget: (context, url, error) => Center(child: Image.asset('assets/images/profile.png', scale: 5)),
                    ),
                  ),
                  title: Html(data: comment.comment.toString(),shrinkWrap: true,),
                  subtitle: Text("${comment.commentBy} | ${comment.creation}",style: TextStyle(fontWeight: FontWeight.bold),),
                );
              },
            )
                : Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: const Text(
                  'Sorry, you got nothing!',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ), context: context),
      ),
    ));
  }

  Widget buildItemColumn(
      {required String additionalText, required String labelText}) {
    return Column(
mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AutoSizeText(
          labelText, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),minFontSize: 16,),
        AutoSizeText(
            additionalText, style: const TextStyle(fontWeight: FontWeight.w500),minFontSize: 18),
      ],
    );
  }

}
