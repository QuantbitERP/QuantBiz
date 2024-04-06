import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocation/screens/customer_screen/address/address_model.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';

import '../../../model/create_customer_model.dart';
import '../../../widgets/drop_down.dart';

class AddressScreen extends StatefulWidget {
  final Billing billing;
  final Shipping shipping;
  const AddressScreen({super.key, required this.billing, required this.shipping});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddressModel>.reactive(  viewModelBuilder: () => AddressModel(),
    onViewModelReady: (model) => model.initialise(context,widget.billing,widget.shipping),
    builder: (context, model, child)=>Scaffold(appBar: AppBar(title: const Text('Address'),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Implement saving addresses and returning to the add customer screen
            model.onSavedPressed(context);
          },
          child: const Text('Save'),
        ),
      ],
    ),body:fullScreenLoader(loader: model.isBusy, child: SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
      
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Billing Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: model.billingAddressLine1Controller,
              decoration: const InputDecoration(labelText: 'Address Line 1'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: model.billingAddressLine2Controller,
              decoration: const InputDecoration(labelText: 'Address Line 2'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: model.billingCityController,
              decoration: const InputDecoration(labelText: 'City'),
            ),
            const SizedBox(height: 10),
            CustomDropdownButton2(value: model.billing.state,items: model.state, hintText: 'Select the state', onChanged: model.setEmail, labelText: 'State'),
            const SizedBox(height: 10),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
              ],
              keyboardType: TextInputType.number,
              controller: model.billingPostalCodeController,
              decoration: const InputDecoration(labelText: 'Postal Code'),
            ),
            
          ],
        ),
      ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Shipping Address',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: model.shippingAddressLine1Controller,
                  decoration: const InputDecoration(labelText: 'Address Line 1'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: model.shippingAddressLine2Controller,
                  decoration: const InputDecoration(labelText: 'Address Line 2'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: model.shippingCityController,
                  decoration: const InputDecoration(labelText: 'City'),
                ),
                const SizedBox(height: 10),
                CustomDropdownButton2(value: model.shipping.state,items: model.state, hintText: 'Select the state', onChanged: model.setShippingState, labelText: 'State'),
                const SizedBox(height: 10),
                TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  keyboardType: TextInputType.number,
                  controller: model.shippingPostalCodeController,
                  decoration: const InputDecoration(labelText: 'Postal Code'),
                ),

              ],
            ),
          ),

        ],
      ),
    ), context: context) ,));
  }
}
