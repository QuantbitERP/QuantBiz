
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/lead_screen/update_screen/update_viewmodel.dart';
import 'package:geolocation/widgets/customtextfield.dart';
import 'package:geolocation/widgets/drop_down.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';


class UpdateLeadScreen extends StatefulWidget {
  final String updateId;
  const UpdateLeadScreen({super.key, required this.updateId});

  @override
  State<UpdateLeadScreen> createState() => _UpdateLeadScreenState();
}

class _UpdateLeadScreenState extends State<UpdateLeadScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateLeadModel>.reactive(
      viewModelBuilder: () => UpdateLeadModel(),
      onViewModelReady: (model) => model.initialise(context,widget.updateId),
      builder: (context, model, child)=> Scaffold(
         appBar: AppBar(title:  Text(model.leaddata.name ?? "",style: const TextStyle(fontSize: 18),),
         actions: [IconButton(onPressed: ()=>Navigator.pushNamed(context, Routes.addLeadScreen,arguments: AddLeadScreenArguments(leadid: widget.updateId)), icon:const Icon(Icons.edit) ),],
         leading: IconButton.outlined(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back)),),
         body: fullScreenLoader(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 1,
                          color: Colors.white,
                          child:Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(flex: 4,child: AutoSizeText(model.leaddata.name ?? ""),),
                                  Expanded(
                                    flex: 3,
                                    child: DropdownButtonHideUnderline(
                                        child: CdropDown(dropdownButton: DropdownButton2<String>(
                                          isExpanded: true,
                                          hint: Text(
                                            'Select Status',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context).hintColor,
                                            ),
                                          ),
                                          items: model.status.map((String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                              .toList(),
                                          value: model.leaddata.customCallStatus,
                                          onChanged: (String? value) {
                                            model.changestatus(widget.updateId, value);
                                          },
                                          buttonStyleData: const ButtonStyleData(
                                            padding: EdgeInsets.symmetric(horizontal: 16),
                                            height: 40,
                                            width: 140,
                                          ),
                                          menuItemStyleData: const MenuItemStyleData(
                                            height: 40,
                                          ),
                                        ),)
                                    ),
                                  ),
                                ],
                              ),
                                Align(alignment:Alignment.topLeft,
                                    child:buildItemColumn(labelText:'Lead Owner',additionalText: '${model.leaddata.leadOwner}')),],
                            ),
                          ) ,
                        ),
                        
                        Card(
                          elevation: 1,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                 Align(alignment:Alignment.topLeft,
                                     child: buildItemColumn(labelText:'Name',additionalText: '${model.leaddata.leadName}')),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                  Expanded(child: buildItemColumn(labelText:'Email',additionalText: '${model.leaddata.emailId}'),),
                                  Expanded(
                                    child:buildItemColumn(labelText:'Mobile',additionalText: '${model.leaddata.mobileNo}'),
                                  ),
                                 ],
                                ),
                                 const SizedBox(height: 10,),
                                 Align(alignment:Alignment.topLeft,
                                     child: buildItemColumn(labelText:'Territory',additionalText: '${model.leaddata.territory}')),
                              ],
                            ),
                          ),
                        ),
                         
                         Card(
                           elevation: 1,
                           color: Colors.white,
                           child: Padding(
                             padding: const EdgeInsets.all(8),
                             child: Column(
                               children: [
                                 Align(alignment:Alignment.topLeft,child: buildItemColumn(labelText:'Organisation Name',additionalText: '${model.leaddata.companyName}')),
                                 const SizedBox(height: 10,),
                                 Align(alignment:Alignment.topLeft,child: buildItemColumn(labelText:'Industry type',additionalText: '${model.leaddata.industry}')),

                               ],
                             ),
                           ),
                         ),
                         Card(
                           elevation: 1,
                           color: Colors.white,
                           child: Padding(
                             padding: EdgeInsets.all(8),
                             child: Row(
                               children: [
                                 Expanded(
                                   child: GestureDetector(
                                       onTap: () {
                                         model.whatsapp(model.leaddata.mobileNo ??"");
                                       },
                                       child: CircleAvatar(
                                         child: Image.asset(
                                           'assets/images/whatsapp.png',scale: 5,),
                                       )),
                                 ),
                             
                                 Expanded(
                                   child: GestureDetector(
                                       onTap: () {
                                         model.service.call(model.leaddata.mobileNo ??"");
                                       },
                                       child: CircleAvatar(
                                         child: Image.asset(
                                           'assets/images/telephone.png',scale: 5,),
                                       )),
                                 ),
                             
                                 Expanded(
                                   child: GestureDetector(
                                       onTap: () {
                                         model.service.sendSms(model.leaddata.mobileNo ?? "");
                                       },
                                       child: CircleAvatar(
                                         child: Image.asset(
                                           'assets/images/comments.png',scale: 5,),
                                       )),
                                 ),
                                 Expanded(
                                   child: GestureDetector(
                                       onTap: () {
                                         model.service.sendEmail(model.leaddata.emailId ??"");
                                       },
                                       child: CircleAvatar(
                                         child: Image.asset(
                                           'assets/images/gmail.png',scale: 5,),
                                       )),
                                 ),
                               ],
                             ),
                           ),
                         ),
                    
                     const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Padding(
                             padding: EdgeInsets.all(8),
                             child: Text('Notes',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                      ],
                     ),
                    //  Center(child: const Text('----------------------------  Notes  -----------------------------',style: TextStyle(fontWeight: FontWeight.bold),)),
                     CustomSmallTextFormField(
                       controller: model.controller, hintText: 'Add your notes here',
                       labelText: 'Add Notes',
                       suffixicon: IconButton.filled(color: Colors.blue,style: const ButtonStyle(),
                       onPressed: () {model.addnote(widget.updateId,model.controller.text);
                     }, // Implement edit functionality
                                         icon: const Icon(Icons.send_rounded,color: Colors.white,),
                                       ), ),
                 ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), itemCount: model.notes.length, itemBuilder: (context, index) {final noteData = model.notes[index];
                  return Dismissible(
                  background: Container(
                  color: Colors.red.shade400,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.white,size: 40,
                ),
            ),
              confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                bool dismiss = false;
                await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text("Are you sure you want to delete the note"),
                        title: const Text("Delete Note?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                dismiss = false;
                                Navigator.pop(context);
                              },
                              child: const Text("No")),
                               TextButton(
                              onPressed: () {
                                dismiss = true;
                               model.deletenote(widget.updateId,noteData.name);
                                Navigator.pop(context);
                              },
                              child: const Text("Yes")),
                        ],
                      );
                    });
                return dismiss;
              }
            },
        //  onDismissed: (direction) {

        //           model.deleteitem(index);
        //           // Shows the information on Snackbar

        //         },
          direction: DismissDirection.startToEnd,
          key: Key(index.toString()),
              child: Card(
                elevation: 1,
                color: Colors.white,
                child: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(
                    // Set background color for the avatar
                   child: Image.network(
                     noteData.image ??"",
                     fit: BoxFit.cover,
                     height: 60,
                width: 60,
                     loadingBuilder: (BuildContext context, Widget child,
                         ImageChunkEvent? loadingProgress) {
                       if (loadingProgress == null) {
                         // Image is done loading
                         return child;
                       } else {
                         // Image is still loading
                         return const Center(
                             child: CircularProgressIndicator(color: Colors.blueAccent));
                       }
                     },
                     errorBuilder:
                         (BuildContext context, Object error, StackTrace? stackTrace) {
                       // Handle the error by displaying a broken image icon
                       return  Center(
                           child: Image.asset('assets/images/profile.png',scale: 5,));
                     },
                   ),
                  ),
                          const SizedBox(width: 8.0),
                          Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        noteData.note ?? "",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          noteData.commented ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          noteData.addedOn ?? "",
                          style: const TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ],
                ),
                          ),
                        ],
                      ),
                    ),
              ),
            );
          },
        ),


                      ],
                    ),
                  ),
                ),
                loader: model.isBusy,
                context: context,
              ),
                // floatingActionButton: FloatingActionButton(onPressed: ()=> Navigator.pushNamed(context, Routes.addLeadScreen,arguments: AddLeadScreenArguments(leadid: '')),child: Icon(Icons.add),),
      ));
  }

   Widget buildItemColumn( {required String additionalText, required String labelText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(labelText,style: const TextStyle(fontWeight: FontWeight.w400),),
        AutoSizeText(additionalText,style: const TextStyle(fontWeight: FontWeight.bold),),
      ],
    );
}
}
