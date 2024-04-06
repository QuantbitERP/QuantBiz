import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/model/create_customer_model.dart';
import 'package:geolocation/screens/customer_screen/address/address_screen.dart';
import 'package:geolocation/widgets/drop_down.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/customtextfield.dart';
import '../../../widgets/text_button.dart';
import 'add_customer_model.dart';

class AddCustomer extends StatefulWidget {
  final String id;
  const AddCustomer({super.key, required this.id});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCustomerViewModel>.reactive(  viewModelBuilder: () => AddCustomerViewModel(),
    onViewModelReady: (model) => model.initialise(context,widget.id),
    builder: (context, model, child)=>Scaffold(appBar: AppBar(
      title:   Text(model.isEdit ? model.customerData.name.toString() :'Add Customer'),

    ),
    body: fullScreenLoader(loader: model.isBusy, child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(physics: const AlwaysScrollableScrollPhysics(),child: Form(
        key: model.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10,
            ),
            CustomSmallTextFormField(controller: model.customerName, labelText: 'Customer Name', hintText: 'Enter the Name',validator: model.validateName,onChanged: model.setName,),
            const SizedBox(
              height: 15,
            ),
            CustomDropdownButton2(value: model.customerData.customerGroup,items: model.groupList, hintText: 'Select the Group', onChanged: model.setGroup, labelText: 'Customer Group',validator: model.validateGroup,),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(child: DropdownButtonHideUnderline(
                    child: CdropDown(dropdownButton: DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: model.customerData.customerType,
                      decoration: const InputDecoration(
                        labelText: 'Customer Type',
                      ),
                      hint:
                      const Text('Select Is type'),
                      items: model.typeList.map((val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: AutoSizeText(val),
                        );
                      }).toList(),
                      onChanged: (value) =>
                      model.setType,
                      validator: model.validateType,
                    ),)
                ),),
                const SizedBox(
                  width: 5,
                ),
                Expanded(child:CustomDropdownButton2(value: model.customerData.territory,items: model.territoryList, hintText: 'Select the territory', onChanged: model.setTerritory, labelText: 'Territory',validator: model.validateTerritory,),),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            CustomSmallTextFormField(keyboardtype: TextInputType.emailAddress,controller: model.emailId, labelText: 'Email Id', hintText: 'Enter the email address',validator: model.validateEmail,onChanged: model.setEmail,),
            const SizedBox(
              height: 15,
            ),
            CustomSmallTextFormField(length: 10,keyboardtype: TextInputType.phone,controller: model.mobileNumber, labelText: 'Mobile Number', hintText: 'Enter the mobile number',validator: model.validateMobile,onChanged: model.setMobile,),
            const SizedBox(
              height: 15,
            ),
            CustomSmallTextFormField(length: 15,controller: model.gstIn, labelText: 'GST IN', hintText: 'Enter the gst number',onChanged: model.setGst,),
            const SizedBox(
              height: 15,
            ),
            DropdownButtonHideUnderline(
                child: CdropDown(dropdownButton: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: model.customerData.gstCategory,
                  decoration: const InputDecoration(
                    labelText: 'GST Category',
                  ),
                  hint:
                  const Text('Select the category'),
                  items: model.gstCategory.map((val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: AutoSizeText(val),
                    );
                  }).toList(),
                  onChanged: (value) =>
                  model.setGstCategory,
                  validator: model.validateCategory,
                ),)
            ),
            const SizedBox(
              height: 15,
            ),
        if(model.billing.country!=null || model.shipping.country!=null)
          Container(
          padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Billing Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  '${model.billing.addressLine1},',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '${model.billing.addressLine2},',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'City: ${model.billing.city}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'State: ${model.billing.state}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Pincode: ${model.billing.pincode}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Country: ${model.billing.country}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Divider(
            height: 100,
            color: Colors.green,
            thickness: 1,
            indent : 10,
            endIndent : 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  '${model.shipping.addressLine1},',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '${model.shipping.addressLine2},',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'City: ${model.shipping.city}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'State: ${model.shipping.state}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Pincode: ${model.shipping.pincode}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Country: ${model.shipping.country}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddressScreen(billing: model.billing, shipping: model.shipping),
                ),
              );
            },
            icon: Icon(Icons.edit),
            color: Colors.blue,
            iconSize: 30,
          )
        ],
      ),
    ),

        if(model.billing.country!=null && model.shipping.country!=null)
        const SizedBox(
              height: 15,
            ),
            if(model.isEdit==false)
            ElevatedButton.icon(
              onPressed: () async {
                final List<dynamic> addresses = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressScreen(billing: Billing(), shipping: Shipping()),
                  ),
                );

                Logger().i(addresses[0].toString());
                Logger().i(addresses[1].toString());
                Billing billingAddress = addresses[0];
                Shipping shippingAddress = addresses[1];

                // Now you can assign these addresses to your model or use them as needed

                setState(() {
                  model.billing = billingAddress;
                  model.shipping = shippingAddress;
                });
                            },
              icon: const Icon(Icons.add_circle_sharp),
              label: const Text('Add Address',style: TextStyle(fontSize: 20),),
            ),


            const SizedBox(
              height: 25,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CtextButton(
                    text: 'Cancel',
                    onPressed: () => Navigator.of(context).pop(), buttonColor: Colors.red.shade400,
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: CtextButton(
                    text:model.isEdit?'Update Customer' : 'Create Customer',
                    onPressed: () =>  model.onSavePressed(context), buttonColor: Colors.blueAccent.shade400,
                  ),
                )



              ],
            )


          ],
        ),
      ),),
    ), context: context),));
  }
}
