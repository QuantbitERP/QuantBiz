import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/view_docs_from_internet.dart';
import 'list_expense_viewmodel.dart';



class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExpenseViewModel>.reactive(
        viewModelBuilder: () => ExpenseViewModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child)=> Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(title: const Text('My Expenses'),
            leading: IconButton.outlined(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
            bottom:  PreferredSize(preferredSize: const Size(20, 75), child:Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: model.selectedMonth, // The currently selected month
                      onChanged: (int? month) {
                        // Update the selected month when the user changes the dropdown value
                        model.updateSelectedmonth(month!);
                      },
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(maxHeight: 60),
                        labelText: 'Month',
                        hintText: 'Select month',

                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: List.generate(12, (index) {
                        // Generate a list of 12 months (1-based index)
                        return DropdownMenuItem<int>(
                          value: index + 1, // Months are 1-based
                          child: Text(model.getMonthName(index + 1)), // Replace with your method to get month name
                        );
                      }),
                    ),

                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: model.selectedYear, // The currently selected year
                      onChanged: (int? year) {
                        // Update the selected year when the user changes the dropdown value
                        model.updateSelectedYear(year);
                      },
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(maxHeight: 60),
                        labelText: 'Year',
                        hintText: 'Select year',
                        prefixIcon: const Icon(Icons.calendar_month),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                      ),
                      items: model.availableYears.map((int year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            ),
          ),
          body: WillPopScope(
            onWillPop: ()  async{
              Navigator.pop(context);
                  return true; },
            child: fullScreenLoader(
              child: RefreshIndicator(
                onRefresh: ()=>model.refresh(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              // spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Row(

                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.drafts,color: Colors.grey,)
                            ,AutoSizeText('Draft'),
                            Icon(Icons.check_circle,color: Colors.green,)
                            ,AutoSizeText('Approved'),
                            Icon(Icons.close,color: Colors.red,)
                            ,AutoSizeText('Rejected')
                          ],
                        ),
                      ),
                  const SizedBox(height: 10,),
                  model.expenselist.isNotEmpty
                  ? Expanded(
                  child: ListView.separated(
                      itemBuilder: (builder, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        // spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                  tilePadding: const EdgeInsets.all(8),
                  title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      color: Colors.blue,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            20.0),
                         // Set border color and width
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AutoSizeText("${model.expenselist[index].expenseType.toString()} Expense",  textAlign:
                        TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight:
                            FontWeight.w500,
                          ),),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText("Date:- ${model.expenselist[index].postingDate?.toString() ?? ""}", style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                        AutoSizeText("Amount:- ${model.expenselist[index].totalClaimedAmount?.toString() ?? "0.0"}", style: const TextStyle(fontSize: 15, color: Colors.green,fontWeight: FontWeight.w700)),
                      ],
                    ),
                            CircleAvatar(radius: 15,backgroundColor:model.getColorForStatus(model.expenselist[index].approvalStatus ?? ""),child: Icon(model.getIconForStatus(model.expenselist[index].approvalStatus ?? ""),color: Colors.white,))
                  ],
                  ),
                  children: [
                  Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const AutoSizeText("Sanction Amount :-", style: TextStyle(fontSize: 15)),
                  AutoSizeText(model.expenselist[index].totalSanctionedAmount?.toString() ?? "0.0", style: const TextStyle(fontSize: 15, color: Colors.green,fontWeight: FontWeight.w700)),
                  ],
                  ),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const AutoSizeText("Claimed Amount :-", style: TextStyle(fontSize: 15)),
                  AutoSizeText(model.expenselist[index].totalClaimedAmount?.toString() ?? "0.0", style: const TextStyle(fontSize: 15, color: Colors.green,fontWeight: FontWeight.w700)),
                  ],
                  ),
                  ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      _buildSubtitle("posting Date :- ${model.expenselist[index].expenseDate ?? ""}"),
                      Card(color: model.getColorForStatus(model.expenselist[index].approvalStatus.toString()),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              15.0),
                          // Set border color and width
                        ),
                        // color:model.getColorForStatus(model.expenselist[index].approvalStatus.toString()),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: AutoSizeText(model.expenselist[index].approvalStatus ?? "",  textAlign:
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
                  _buildSubtitle("Description :- ${model.expenselist[index].expenseDescription ?? ""}"),
                            if (model.expenselist[index].attachments?.isNotEmpty == true)
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ViewImageInternet(
                            url: model.expenselist[index].attachments![0].fileUrl ?? "",
                          ),
                        ),
                      );
                    },
                    child: Text("Image: ${model.expenselist[index].attachments![0].fileUrl?.split("/").last ?? ""}"),
                  )

                        ],
                  ),
                  ),
                  ],
                  ),
                );
                },
                  separatorBuilder: (context, builder) {
                    return const Divider(
                      thickness: 1,
                    );
                  },
                  itemCount: model.expenselist.length,
                ),
                            )
                    : Container(
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
                  child: const Center(child: Text('No attendance found for this year and month')),
                  )

                  ],
                  ),
                ),
              ),
              loader: model.isBusy,
              context: context,
            ),
          ),
floatingActionButton: FloatingActionButton.extended(onPressed: ()=>Navigator.pushNamed(context, Routes.addExpenseScreen),
label: const Text('Create Expense'),),
        ));
  }



  Widget _buildSubtitle(String text) {
    return AutoSizeText(text, style: const TextStyle(fontSize: 15));
  }
}