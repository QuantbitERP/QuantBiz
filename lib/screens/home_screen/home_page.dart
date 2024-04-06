import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/router.router.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stacked/stacked.dart';
import '../../constants.dart';
import '../../widgets/drawer.dart';
import 'home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onViewModelReady: (model) => model.initialize(context),
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
              appBar: AppBar(
                title:  Text(model.dashboard.company!=null?model.dashboard.company.toString() :model.employeeData.company.toString(),style: const TextStyle(fontSize: 17),),
              ),
              drawer: myDrawer(context, (model.dashboard.empName!=null?model.dashboard.empName.toString() :model.employeeData.empName.toString()),
                  (model.dashboard.email!=null?model.dashboard.email.toString() :model.employeeData.email.toString()), (model.dashboard.employeeImage!=null?model.dashboard.employeeImage.toString() :model.employeeData.employeeImage.toString())),
              body: WillPopScope(
                onWillPop: showExitPopup,
                child: fullScreenLoader(
                  loader: model.isBusy,
                  context: context,
                  child: RefreshIndicator(
                    onRefresh: () =>model.onRefresh(context),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(model.isHide==false)
                                Container(
                                 decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3), // Customize the shadow offset
                                              ),
                                            ],
                                          ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.greeting ?? "",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      "${model.dashboard.empName.toString().toUpperCase()},",overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                     Text( model.dashboard.lastLogType=="IN"?
                                                  'Last Check-In at ${model.dashboard.lastLogTime.toString()}':"You're not check-in yet",
                                                  style: const TextStyle(fontSize: 16),
                                                  textAlign: TextAlign.center,
                                                ),

                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 40,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: '${model.dashboard.employeeImage}',
                                        width: 70, // Set width to twice the radius for a complete circle
                                        height: 70,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
                                        errorWidget: (context, url, error) => Center(child: Image.asset('assets/images/profile.png', scale: 5)),
                                      ),
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                                Center(
                                child: OutlinedButton(
                                  onPressed: () {
                                    String logtype= model.dashboard.lastLogType=="IN" ? "OUT" :"IN";
                                    Logger().i(logtype);
                                    model.employeeLog(logtype,context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    side: BorderSide(color:model.dashboard.lastLogType=="OUT" ? Colors.green:Colors.red,width: 2), // Set the border color
                                    minimumSize: const Size(150, 50), // Set the minimum button size
                                  ),
                                  child:model.loading == true ?LoadingAnimationWidget.hexagonDots(
                                                color:Colors.blueAccent,
                                                size: 18,
                                              ) :Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(model.dashboard.lastLogType=="OUT" ? 'assets/images/check-in.png':'assets/images/check-out.png',scale: 20),
                        const SizedBox(width: 8),
                        Text(model.dashboard.lastLogType=="OUT" ? 'Check-In':'Check-Out',style: TextStyle(color:model.dashboard.lastLogType=="OUT" ? Colors.green:Colors.red),),
                                    ],
                                  ),
                                ),
                              ),

                        ],
                                    ),
                                  ),
                                ),
                                if(model.isHide==false)
                                const SizedBox(height: 20,)
                              ,const Text('What would you like to do ?',textAlign: TextAlign.left,style:TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: GridView(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                    ),
                                    controller: ScrollController(keepScrollOffset: true),
                                    shrinkWrap: true,
                                    children: [
                                      if(model.isFormAvailableForDoctype("Customer"))
                                        buildButton("Customer", 'assets/images/customer.png', () {
                                          Navigator.pushNamed(context, Routes.customerList);
                                        },model),
                                      if(model.isFormAvailableForDoctype("Lead"))
                                      buildButton("Lead", 'assets/images/recruitment.png', () {
                                        Navigator.pushNamed(context, Routes.leadListScreen);
                                      },model),
                                      if(model.isFormAvailableForDoctype("Quotation"))
                                      buildButton("Quotation", 'assets/images/quotation.png', () {
                                        Navigator.pushNamed(context, Routes.listQuotationScreen);
                                      },model),
                                      if(model.isFormAvailableForDoctype("Sales Order"))
                                      buildButton("Sales Orders", 'assets/images/cargo.png', () {
                                        Navigator.pushNamed(context, Routes.listOrderScreen);
                                      },model),
                                      if(model.isFormAvailableForDoctype("sales Invoice"))
                                      buildButton("Sales Invoice", 'assets/images/bill.png', () {
                                        Navigator.pushNamed(context, Routes.listInvoiceScreen);
                                      },model),
                                      if(model.isFormAvailableForDoctype("Attendance"))
                                      buildButton("Holidays", 'assets/images/calendar.png', () {
                                        Navigator.pushNamed(context, Routes.holidayScreen);
                                      },model),
                                      if(model.isFormAvailableForDoctype("Attendance"))
                                      buildButton("Attendence", 'assets/images/attendance.png', () {
                                        Navigator.pushNamed(context, Routes.attendanceScreen);
                                      },model),
                                      if(model.isFormAvailableForDoctype("Expense Claim"))
                                      buildButton("Expenses", 'assets/images/budget.png', () {
                                        Navigator.pushNamed(context, Routes.expenseScreen);
                                      },model),
                                      if(model.isFormAvailableForDoctype("Leave Application"))
                                      buildButton("Leaves", 'assets/images/flight.png', () {
                                        Navigator.pushNamed(context, Routes.listLeaveScreen);
                                      },model),
                                    ],
                                  ),
                                ),
                                if(model.isHide==false)
                                const SizedBox(height: 20,),

                                // Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //   children: [
                                //   ElevatedButton.icon(onPressed: (){
                                //     setState(() {
                                //       model.changeColor("0xFF2196F3");
                                //     });
                                //
                                //   }, label: Text('Flutter'), icon: Icon(Icons.flutter_dash),),
                                //   ElevatedButton.icon(onPressed: (){setState(() {
                                //     // Here we are going to set the orange color
                                //     model.changeColor("0xFFE65100");
                                //   });}, label: Text('Kotlin'), icon: Icon(Icons.android),)
                                // ],),
                                if(model.isHide==false)
                                const Text('Attendance Details',textAlign: TextAlign.left,style:TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),

                                if(model.isHide==false)
                                  const SizedBox(height: 10,),
                                if(model.isHide==false)
                                Container(
                                  width: getWidth(context),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3), // Customize the shadow offset
                                      ),
                                    ],
                                  ),
                                  // Set a fixed width for the container
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      Card(
                                        color: Colors.blueAccent,
                                        shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              20.0),
                                          // Set border color and width
                                        ),
                                        // color:model.getColorForStatus(model.expenselist[index].approvalStatus.toString()),
                                        child:  Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: AutoSizeText(model.attendanceDashboard.monthTitle ??"",
minFontSize: 15,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),),
                                        ),

                                      ),
                                      const SizedBox(height: 10,),
                                       Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(children: [
                                          Text('${model.attendanceDashboard.present ?? 0.0} Days',textAlign: TextAlign.left,style:const TextStyle(fontWeight: FontWeight.w700,color: Colors.green)),
                                          const Divider(thickness: 5,color: Colors.black,indent: 10,height: 20,),
                                          const Text('|',textAlign: TextAlign.left,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black)),
                                          const Divider(thickness: 5,color: Colors.black,indent: 10,height: 20,),
                                          Text('${model.attendanceDashboard.absent ?? 0.0} Days',textAlign: TextAlign.left,style:const TextStyle(fontWeight: FontWeight.w700,color: Colors.redAccent)),
                                          const Divider(thickness: 5,color: Colors.black,indent: 10,height: 20,),
                                          const Text('|',textAlign: TextAlign.left,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black)),
                                          const Divider(thickness: 5,color: Colors.black,indent: 10,height: 20,),
                                          Text('${model.attendanceDashboard.dayOff ?? 0.0} Days',textAlign: TextAlign.left,style:TextStyle(fontWeight: FontWeight.w700,color: Colors.yellow[700])),
                                          const Divider(thickness: 5,color: Colors.black,indent: 15,height: 20,),
                                          Text('${model.attendanceDashboard.totalDays ?? 0} Days',textAlign: TextAlign.left,style:const TextStyle(fontWeight: FontWeight.w700,color: Colors.grey)),
                                        ],),
                                      ),

                                      LinearPercentIndicator(
                                        width: getWidth(context) / 1.18,
                                        lineHeight: 15.0,
                                        percent: (model.attendanceDashboard.tillDays ?? 0) /
                                            (model.attendanceDashboard.totalDays ?? 1), // Added null checks
                                        barRadius: const Radius.circular(20),
                                        center: Text(
                                          "${(model.attendanceDashboard.tillDays ?? 0)} days",
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black),
                                        ),
                                        progressColor: Colors.blueAccent,
                                      ),


                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                                          const Icon(Icons.radio_button_checked,color: Colors.green,),
                                          const Text('Present',textAlign: TextAlign.left,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black)),
                                          const SizedBox(width: 20,),
                                          const Icon(Icons.radio_button_checked,color: Colors.red,),
                                          const Text('Absent',textAlign: TextAlign.left,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black)),
                                          const SizedBox(width: 20,),
                                          Icon(Icons.radio_button_checked,color: Colors.yellow[700],),
                                          const Text('Days Off',textAlign: TextAlign.left,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black)),

                                        ],),
                                      ),
                                    ]
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                if(model.isHide==false)
                                const Text('Leave Balance',textAlign: TextAlign.left,style:TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
                                // Existing code...
                                if(model.isHide==false)
                                SizedBox(

                                  width: getWidth(context),
                                  height: getHeight(context)/4, // Adjust the height as needed
                                  child: SizedBox(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: model.leaveList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 150,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5), // Customize the shadow color and opacity
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: const Offset(0, 3), // Customize the shadow offset
                                                ),
                                              ],
                                            ),
                                            // Set a fixed width for the container
                                            child: CircularPercentIndicator(
                                              radius: 45.0,
                                              lineWidth: 8.0,

                                              percent:model.leaveList[index].leaveType != "Leave Without Pay" ?((model.leaveList[index].closingBalance ?? 0.0)/((model.leaveList[index].openingBalance ?? 0.0)+(model.leaveList[index].leavesAllocated ?? 0.0))):1,
                                              center: Text(
                                                model.leaveList[index].closingBalance!.abs().toString(),
                                                style:
                                                const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                                              ),
                                              footer: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    model.leaveList[index].leaveType ?? "",
                                                    style:
                                                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                                                  ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                  Text(
                                                    "Allocated: ${(model.leaveList[index].leavesAllocated ?? 0.0).toString()}",
                                                    style:
                                                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                                                  ),
                                                ],
                                              ),
                                              circularStrokeCap: CircularStrokeCap.round,
                                              progressColor: Colors.blueAccent,
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, builder) {
                                        return const SizedBox(
                                          width: 5,
                                        );
                                      },
                                    ),
                                  ),
                                ),
// Rest of the code...
                              ],
                            ),


                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit an App?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:const Text('No'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            child:const Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }


  Widget buildButton(String label, String imagePath, VoidCallback onTap,HomeViewModel model) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(imagePath, scale: 10,),
             AutoSizeText(
             label,
              style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ) , // If the form is not available, show an empty SizedBox
    );
  }
}
