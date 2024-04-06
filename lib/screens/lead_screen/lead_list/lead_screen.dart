import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocation/screens/lead_screen/lead_list/lead_viewmodel.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/text_button.dart';

class LeadListScreen extends StatefulWidget {
  const LeadListScreen({super.key});

  @override
  State<LeadListScreen> createState() => _LeadListScreenState();
}

class _LeadListScreenState extends State<LeadListScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeadListViewModel>.reactive(
      viewModelBuilder: () => LeadListViewModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child)=> Scaffold(
        backgroundColor: Colors.grey.shade200,
appBar: AppBar(title: const Text('Lead'),
  actions: [
    IconButton(
      icon: const Icon(Icons.filter_list),
      onPressed: () {
        _showBottomSheet(context,model);
      },
    ),
  ],
leading: IconButton.outlined(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back)),),
body: WillPopScope(
  onWillPop: ()  async{
    Navigator.pop(context);
                  return true; },
  child: fullScreenLoader(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        model.filterleadlist.isNotEmpty
                            ? Expanded(
                                child: RefreshIndicator(
                                  onRefresh: ()=>model.refresh(),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: AlwaysScrollableScrollPhysics(),
                                      itemBuilder: (builder, index) {
                                        return Container(
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
                                          onPressed: ()=>model.onRowClick(context, model.filterleadlist[index]),
                                            child: Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            model.filterleadlist[index]
                                                                    .name ??
                                                                "",
                                                            style: const TextStyle(
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            model.filterleadlist[index]
                                                                    .leadName?.toUpperCase() ??
                                                                "",
                                                            style: const TextStyle(
                                                              fontWeight: FontWeight.w300
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Card(
                                                        
                                                        color: model.getColorForStatus(model.filterleadlist[index]
                                                            .status ??
                                                            ""),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20.0),
                                                          // Set border color and width
                                                        ),
                                                       
                                                        // Make the inside of the card hollow
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  10.0),
                                                          child: AutoSizeText(
                                                            model.filterleadlist[index]
                                                                    .status ??
                                                                "",
                                                                minFontSize: 8,
                                                            textAlign:
                                                                TextAlign.center,
                                                            style: const TextStyle(
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15.0),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Company Name',
  
                                                          ),
                                                          Text(
                                                            model.filterleadlist[index]
                                                                    .companyName?.toUpperCase() ??
                                                                "", style: const TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                          ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Territory',
  
                                                          ),
                                                          Text(
                                                            model.filterleadlist[index]
                                                                    .territory
                                                                    ?.toString() ??
                                                                "", style: const TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                          ),
                                                          ),
                                                        ],
                                                      ),
                                                      
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, builder) {
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                      itemCount: model.filterleadlist.length),
                                ),
                              )
                            : Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
                            child: const Text('Sorry, you got nothing!',textDirection: TextDirection.ltr,style: TextStyle(fontWeight: FontWeight.w700),),),
                        )
                      ],
                    ),
                  ),
                  loader: model.isBusy,
                  context: context,
                ),
),
                floatingActionButton: FloatingActionButton.extended(onPressed: ()=> Navigator.pushNamed(context, Routes.addLeadScreen,arguments: const AddLeadScreenArguments(leadid: '')),label: const Text('Create Lead'),),
      ));
  }


  void _showBottomSheet(BuildContext context, LeadListViewModel model) {

    SchedulerBinding.instance.addPostFrameCallback(
            (_) {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Filters'),
                ),
                body: Container(
                  height: 250,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CustomDropdownButton2(
                        value: model.custm,
                        prefixIcon: Icons.person_2,
                        items: model.customerlist,
                        hintText: 'Select the Lead Company',
                        labelText: 'Lead Company',
                        onChanged: model.setcustomer,
                      ),
                      const SizedBox(height: 10.0),
                      CustomDropdownButton2(
                        value: model.territory,
                        prefixIcon: Icons.my_location,
                        items: model.territorylist,
                        hintText: 'Select the Territory',
                        labelText: 'Territory',
                        onChanged: model.setqterritory,
                      ),

                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                           CtextButton(
                              onPressed: () {
                              model.clearfilter();
                              Navigator.pop(
                                  context); // Close the bottom sheet
                            },
                                text: 'Clear Filter',
                                buttonColor: Colors.black54,
                               
                              ),
                              CtextButton(
                              onPressed: () {
                              model.setfilter(model.territory ?? "",
                                  model.custm ?? "");
                              Navigator.pop(context);
                            },
                                  text: 'Apply Filter',
                                buttonColor: Colors.blueAccent.shade400,
                               
                              ),
                        
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }
}