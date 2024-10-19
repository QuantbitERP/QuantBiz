import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/home_screen/home_page.dart';
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
    return ViewModelBuilder<TaskListViewModel>.reactive(
        viewModelBuilder: () => TaskListViewModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.grey.shade100,
              appBar: AppBar(
                title: const Text('My Tasks'),
                leading: IconButton.outlined(
                    onPressed: () => HomePage(),
                    icon: const Icon(Icons.arrow_back)),
              ),
              body: RefreshIndicator(
                onRefresh: () => model.refresh(),
                child: fullScreenLoader(
                  child: SingleChildScrollView(
                    // controller: ScrollController(keepScrollOffset: false),
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: model.filterTaskList.isNotEmpty
                            ? ListView.separated(
                                controller:
                                    ScrollController(keepScrollOffset: false),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (builder, index) {
                                  return Card(
                                    elevation: 2.0,
                                    child: MaterialButton(
                                      onPressed: () => model.onRowClick(
                                          context, model.filterTaskList[index]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: model
                                                        .getColorForPriority(
                                                            model
                                                                .filterTaskList[
                                                                    index]
                                                                .priority
                                                                .toString()),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 7),
                                                  child: AutoSizeText(
                                                    model.filterTaskList[index]
                                                            .priority ??
                                                        "",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: model
                                                          .getColorForPriority(
                                                              model
                                                                  .filterTaskList[
                                                                      index]
                                                                  .priority
                                                                  .toString()),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: model
                                                        .getColorForStatus(model
                                                            .filterTaskList[
                                                                index]
                                                            .status
                                                            .toString()),
                                                  ),
                                                ),
                                                // color:model.getColorForStatus(model.expenselist[index].approvalStatus.toString()),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 7),
                                                  child: AutoSizeText(
                                                    model.filterTaskList[index]
                                                            .status ??
                                                        "",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: model
                                                          .getColorForStatus(model
                                                              .filterTaskList[
                                                                  index]
                                                              .status
                                                              .toString()),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          AutoSizeText(
                                            model.filterTaskList[index]
                                                    .projectName ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          AutoSizeText(
                                            model.filterTaskList[index]
                                                    .subject ??
                                                "",
                                            minFontSize: 17,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 7),
                                          if (model.filterTaskList[index]
                                                  .expEndDate !=
                                              "")
                                            Row(
                                              children: [
                                                Icon(Icons.timer),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                AutoSizeText(
                                                  model.filterTaskList[index]
                                                          .expEndDate ??
                                                      "",
                                                  minFontSize: 16,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          Divider(),
                                          Row(
                                            children: [
                                              Icon(Icons.comment),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Text(
                                                  "${model.filterTaskList[index].numComments ?? 0}"),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                model.filterTaskList[index]
                                                        .assignedBy?.user ??
                                                    "",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, builder) {
                                  return const SizedBox(
                                    height: 20,
                                  );
                                },
                                itemCount: model.filterTaskList.length,
                              )
                            : Center(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: const Text(
                                    'Sorry, you got nothing!',
                                    textDirection: TextDirection.ltr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              )),
                  ),
                  loader: model.isBusy,
                  context: context,
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () => Navigator.pushNamed(
                    context, Routes.addTaskScreen,
                    arguments: const AddTaskScreenArguments(taskId: "")),
                label: const Text('Create Task'),
              ),
            ));
  }
}
