import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import 'holiday_viewmodel.dart';

class HolidayScreen extends StatelessWidget {
  const HolidayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Holidayviewmodel>.reactive(
        viewModelBuilder: () => Holidayviewmodel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child)=> Scaffold(
backgroundColor: Colors.grey.shade200,
          appBar: AppBar(title: const Text('Holiday'),
            leading: IconButton.outlined(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
          bottom:  PreferredSize(preferredSize: const Size(20, 75), child:Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
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
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(30.0),
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

          ),),
          body: fullScreenLoader(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  model.holidaylist.isNotEmpty
                      ? Expanded(
                    child: ListView.separated(
                        itemBuilder: (builder, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            height: 55,
                            child:  ListTile(
                              leading: Image.asset('assets/images/beach-chair.png',scale: 20,),
                              title: AutoSizeText(model.holidaylist[index].description ?? "",style: const TextStyle(fontWeight: FontWeight.bold),),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  AutoSizeText(model.holidaylist[index].date ?? "",style: const TextStyle(fontWeight: FontWeight.bold),),
                                  AutoSizeText(model.holidaylist[index].day ?? "",style: const TextStyle(fontWeight: FontWeight.w300),),
                                ],
                              ),
                            )
                          );
                        },
                        separatorBuilder: (context, builder) {
                          return const Divider(
                            thickness: 1,
                          );
                        },
                        itemCount: model.holidaylist.length),
                  )
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
                    child: Center(child: Text('No holidays available for the year ${model.selectedYear}')),
                  )
                ],
              ),
            ),
            loader: model.isBusy,
            context: context,
          ),

        ));
  }
}