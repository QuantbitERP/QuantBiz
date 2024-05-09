import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/text_button.dart';
import 'customer_list_viewmodel.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerListViewModel>.reactive(  viewModelBuilder: () => CustomerListViewModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child)=>Scaffold(
          appBar: AppBar(title: const Text('Customer List'),centerTitle: true,
          actions: [
            IconButton(onPressed: ()=>_showBottomSheet(context,model), icon: Icon(Icons.filter_list_rounded))
          ],),
          body:  WillPopScope(
            onWillPop: ()  async{
              Navigator.pop(context);
              return true; },
            child: RefreshIndicator(
              onRefresh: ()=>model.refresh(),
              child: fullScreenLoader(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      model.filterCustomerList.isNotEmpty
                          ? Expanded(
                        child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (builder, index) {
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Colors.purple.shade400, Colors.deepPurpleAccent.shade200],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.purple.withOpacity(0.5),
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: MaterialButton(
                                  onPressed: ()=>model.onRowClick(context, model.filterCustomerList[index]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  model.filterCustomerList[index].customerName ?? "",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                  maxLines: 2,
                                                  minFontSize: 15,

                                                ),
                                                Text(
                                                  model.filterCustomerList[index].customerGroup ?? "",
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: 15.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'GST Category',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  model.filterCustomerList[index].gstCategory?.toString() ?? "",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Territory",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  model.filterCustomerList[index].territory?.toString() ?? "",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
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
                            itemCount: model.filterCustomerList.length),
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
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, Routes.addCustomer,arguments: AddCustomerArguments(id: ""));
            },
            label: const Text('Create Customer'),
          ),
        ));
  }


  void _showBottomSheet(BuildContext context, CustomerListViewModel model) {

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
                        items: model.customerShowList,
                        hintText: 'Select the Customer',
                        labelText: 'Customer',
                        onChanged: model.setcustomer,
                      ),
                      const SizedBox(height: 10.0),
                      CustomDropdownButton2(
                        value: model.territory,
                        prefixIcon: Icons.my_location,
                        items: model.territoryList,
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
