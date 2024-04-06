import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../router.router.dart';
import 'attendence_viewmodel.dart';


class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AttendenceViewModel>.reactive(
        viewModelBuilder: () => AttendenceViewModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child)=> Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(title: const Text('Attendance'),

            leading: IconButton.outlined(onPressed: ()=> Navigator.pop(context), icon: const Icon(Icons.arrow_back)),

            bottom:  PreferredSize(preferredSize: Size(20, 95), child:Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<int>(
                      value: model.selectedMonth, // The currently selected month
                      onChanged: (int? month) {
                        // Update the selected month when the user changes the dropdown value
                        model.updateSelectedmonth(month);
                      },
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(maxHeight: 60),
                        labelText: 'Month',
                        hintText: 'Select month',

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
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
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<int>(
                      value: model.selectedYear, // The currently selected year
                      onChanged: (int? year) {
                        // Update the selected year when the user changes the dropdown value
                        model.updateSelectedYear(year);
                      },
                      decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 60),
                        labelText: 'Year',
                        hintText: 'Select year',

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
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
          body: fullScreenLoader(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: TableCalendar(
                        focusedDay: DateTime(model.selectedYear ?? DateTime.now().year, model.selectedMonth ?? DateTime.now().month, 1),
                        firstDay: DateTime(2000),
                        lastDay: DateTime(2100),
                        calendarFormat: model.calendarFormat,
                        weekendDays: const [DateTime.sunday],
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        headerStyle: HeaderStyle(

                          // ... header style configuration ...
                          formatButtonVisible: true,
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          formatButtonTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onFormatChanged: (format) {
                          model.calenderformat(format);
                        },
                        eventLoader: (day) => model.attendancelist,
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        calendarStyle: CalendarStyle(
                          markersAnchor: 0.7,
                          markersMaxCount: 1,
                          weekendTextStyle: TextStyle(
                            color: Colors.red,
                          ),
                          todayDecoration: BoxDecoration(
                            color: Colors.blue[300],
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, date, events) {
                            final attendance = model.getAttendanceForDate(date); // You should have a method to get attendance for a specific date

                            if (attendance != null) {
                              // Use different colors based on the status
                              Color markerColor = model.getColorForStatus(attendance.status ?? "");
                              return Positioned(
                                right: 0,
                                bottom: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: markerColor,
                                    shape: BoxShape.circle,
                                  ),
                                  width: 20,
                                  height: 20,
                                ),
                              );
                            } else {
                              return Positioned(
                                right: 0,
                                bottom: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  width: 20,
                                  height: 20,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),padding: EdgeInsets.all(10),
                      child: Column(
              
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: AutoSizeText("${model.getMonthName(model.selectedMonth ?? 0).toUpperCase()}  ${model.selectedYear}",
                  textAlign:
                TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight:
                    FontWeight.bold,
                  ),),
                ),
              
              
                    ),
                          const SizedBox(height: 10,),
                          // Wrap(
                          //   spacing: 4.0,
                          //   runSpacing: 3.0,
                          //   alignment: WrapAlignment.center,
                          //   children: [
                          //     for (String item in model.items)
                          //       Padding(
                          //         padding: const EdgeInsets.all(4.0),
                          //         child: Row(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: [
                          //             Checkbox(
                          //               value: model.selectedItems.contains(item),
                          //               onChanged: (_) => model.toggleItem(item),
                          //             ),
                          //             Text(item),
                          //           ],
                          //         ),
                          //       ),
                          //   ],
                          // ),
              //             Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //               const Icon(Icons.radio_button_checked,color: Colors.green,size: 20,),Text("  Present Days: ${model.attendeancedetails.present ?? 0}"),const Icon(Icons.radio_button_checked,color: Colors.red,size: 20,),Text("Absent Days: ${model.attendeancedetails.absent ?? 0}"),
              //             ],),
              //             const SizedBox(height: 10,),
              //             Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              // const Icon(Icons.radio_button_checked,color: Colors.indigo,size: 20,),Text("  Half Days: ${model.attendeancedetails.halfDay ?? 0}"),const Icon(Icons.radio_button_checked,color: Colors.amber,size: 20,),Text("Days Off: ${model.attendeancedetails.onLeave ?? 0}")
              //               ],),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.radio_button_checked, color: Colors.green, size: 20,),
                                    const SizedBox(width: 5),
                                    Text("Present Days: ${model.attendeancedetails.present ?? 0}"),
                                    const SizedBox(width: 20),
                                    const Icon(Icons.radio_button_checked, color: Colors.red, size: 20,),
                                    const SizedBox(width: 5),
                                    Text("Absent Days: ${model.attendeancedetails.absent ?? 0}"),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.radio_button_checked, color: Colors.indigo, size: 20,),
                                    const SizedBox(width: 5),
                                    Text("Half Days: ${model.attendeancedetails.halfDay ?? 0}"),
                                    const SizedBox(width: 50),
                                    const Icon(Icons.radio_button_checked, color: Colors.amber, size: 20,),
                                    const SizedBox(width: 5),
                                    Text("Days Off: ${model.attendeancedetails.onLeave ?? 0}"),
                                  ],
                                ),
                              ],
                            ),
                          )
              
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    model.attendancelist.isNotEmpty
                        ? ListView.separated(
                            controller: ScrollController(keepScrollOffset: false),
               
                physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                            itemBuilder: (builder, index) {
                              return Container(padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container( 
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blueAccent,
                                      ),child: AutoSizeText(DateFormat("EEEE dd").format(DateTime.parse(model.attendancelist[index].attendanceDate ?? "")),style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),)),
                                      SizedBox(height: 10,)
                                      ,Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const AutoSizeText('Check-In Time',style: TextStyle(fontWeight: FontWeight.w300
                                              ),),
                                              SizedBox(height: 10,),
                                              AutoSizeText(model.attendancelist[index].inTime ?? "- / -",style: const TextStyle(fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                          const Divider(thickness: 1,color: Colors.black,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const AutoSizeText('Check-Out Time',style: TextStyle(fontWeight: FontWeight.w300),),
                                              SizedBox(height: 10,),
                                              AutoSizeText(model.attendancelist[index].outTime ?? "- / -",style: const TextStyle(fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                          const Divider(thickness: 1,),Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const AutoSizeText('Working Hours',style: TextStyle(fontWeight: FontWeight.w300),),
                                              SizedBox(height: 10,),
                                              AutoSizeText('${model.attendancelist[index].workingHours}',style: TextStyle(fontWeight: FontWeight.bold),)
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
                              );
                            },
                            separatorBuilder: (context, builder) {
                              return Divider(
                                thickness: 1,
                              );
                            },
                            itemCount: model.attendancelist.length)
                        : Container(
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

        ));
  }
}
///fdsfsdfdfdsfsdfsdf

