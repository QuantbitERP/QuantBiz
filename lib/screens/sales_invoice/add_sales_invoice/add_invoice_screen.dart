import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/model/add_invoice_model.dart';
import 'package:geolocation/screens/sales_invoice/add_sales_invoice/add_invoice_viewmodel.dart';
import 'package:geolocation/screens/sales_invoice/list_sales_invoice/list_sales_invoice_screen.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import '../../../constants.dart';
import '../../../router.router.dart';
import '../../../widgets/drop_down.dart';
import '../../../widgets/text_button.dart';


class AddInvoiceScreen extends StatefulWidget {
  final String invoiceid;
  const AddInvoiceScreen({super.key, required this.invoiceid});
  @override
  State<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddInvoiceViewModel>.reactive(
      viewModelBuilder: () => AddInvoiceViewModel(),
      onViewModelReady: (model) => model.initialise(context, widget.invoiceid),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: model.isEdit == true
              ? Text(model.invoiceData.name ?? "")
              : const Text('Create Invoice'),
          leading: IconButton.outlined(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [IconButton.outlined(
            onPressed: () {
              model.onSavePressed(context);
            },
            icon: const Icon(Icons.check),
          ),],
        ),
        body: fullScreenLoader(
          loader: model.isBusy,
          context: context,
          child: SingleChildScrollView(
              child: Form(
            key: model.formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomDropdownButton2(value: model.invoiceData.customer,prefixIcon: Icons.person_2,items: model.searchcutomer, hintText: 'Select the customer', labelText: 'Customer', onChanged:  model.setcustomer,),

                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: model.deliverydatecontroller,
                    onTap: () => model.selectdeliveryDate(context),
                    decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        labelText: 'Payment Due Date',
        hintText: 'Payment Due Date',
        prefixIcon:const Icon(Icons.calendar_today_rounded),
        labelStyle: const TextStyle(
          color: Colors.black54, // Customize label text color
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey, // Customize hint text color
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(
            color: Colors.blue, // Customize focused border color
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(
            color: Colors.grey, // Customize enabled border color
          ),
        ),
      ),
                    validator: model.validatedeliveryDob,
                    onChanged: model.ondeliveryDobChanged,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
              CheckboxListTile(
                value: model.updateStock,
                onChanged: model.setStock,
                title: const Text(
                  'Update Stock',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54, // Customize the text color
                  ),
                ),
                controlAffinity: ListTileControlAffinity.trailing,
                 // Customize the background color

                
                activeColor: Colors.blue, // Color when the checkbox is checked
                checkColor: Colors.white, // Color of the check icon
              ),
                  const SizedBox(
                    height: 10,
                  ),
              CustomDropdownButton2(prefixIcon:Icons.warehouse_outlined,items: model.warehouse, hintText: 'select the warehouse', onChanged: model.setwarehouse, labelText: 'Set Warehouse',value: model.invoiceData.setWarehouse,),

                  const SizedBox(
                    height: 15,
                  ),

                  TextFormField(
                    readOnly: true,
                  key:Key(model.displayString),
                  initialValue: model.displayString,
                    onTap: () async {
                      if(model.invoiceData.customer == null){
                        const snackBar= SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Please select the customer ',style: TextStyle(color: Colors.white,fontSize: 18),),
                          duration: Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                        final SelectedItems = await Navigator.pushNamed(
                          context,
                          Routes.invoiceItemScreen,
                          arguments: InvoiceItemScreenArguments(
                              invoiceItems: model.selectedItems, warehouse: model.invoiceData.setWarehouse ?? '' ),
                        ) as List<InvoiceItems>?;
                        if (SelectedItems != null) {
                          model.selectedItems.clear();
                          // Update the model or perform any actions with the selected items
                          model.setSelectedItems(SelectedItems);
                        }
                    },
                     decoration: InputDecoration(
       suffixIcon: const Icon(Icons.arrow_drop_down),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        labelText: 'Items',
        hintText: 'For select items click here',
        prefixIcon:const Icon(Icons.shopping_basket),
        labelStyle: const TextStyle(
          color: Colors.black54, // Customize label text color
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey, // Customize hint text color
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(
            color: Colors.blue, // Customize focused border color
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(
            color: Colors.grey, // Customize enabled border color
          ),
        ),
      ),
                  ),
                   const SizedBox(
                    height: 5,
                  ),
                  const Text('Item List',style: TextStyle(fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                   const SizedBox(
                    height: 10,
                  ),
                  if (model.selectedItems.isNotEmpty)
                   ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      // Prevent scrolling
                      shrinkWrap: true,
                      itemCount: model.selectedItems.length,
                      itemBuilder: (context, index) {
                        final selectedItem = model.selectedItems[index];

                        return Dismissible(
                          key: Key(selectedItem.itemCode.toString()), // Use a unique key for each item
                          background: Container(
                            color: Colors.red.shade400,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              bool dismiss = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: const Text("Are you sure you want to delete the item"),
                                    title: const Text("Delete Item ?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, false); // Dismiss without deletion
                                        },
                                        child: const Text("No"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true); // Confirm deletion
                                        },
                                        child: const Text("Yes"),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return dismiss;
                            }
                          },
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            model.deleteitem(index); // Delete the item from the model
                          },
                          child: Container(
            padding: const EdgeInsets.all(10),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: '$baseurl${selectedItem.image}',
                    width: 70, // Set width to twice the radius for a complete circle
                    height: 70,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
                    errorWidget: (context, url, error) => Center(child: Image.asset('assets/images/image.png', scale: 5)),
                  ),
                ),
                const SizedBox(width: 10),
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       'ID: ${selectedItem.itemCode}(${selectedItem.itemName})',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                       AutoSizeText(
                                        'Rate: ${selectedItem.rate.toString()}',
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      AutoSizeText(
                                        'Amount: ${selectedItem.amount?.toString() ?? ""}',
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                    ],
                  ),
                ),
                // Quantity and Buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Quantity"),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                                        icon:  Icon(Icons.remove_circle,color: Colors.blueAccent.shade400,),
                                        onPressed: () {
                                          // Decrease quantity when the remove button is pressed
                                          if (selectedItem.qty != null &&
                                              (selectedItem.qty ?? 0) > 1) {
                                            model.removeitem(index);
                                          }
                                        },
                                      ),
                                      Text(
                                        model
                                            .getQuantity(selectedItem)
                                            .toString(),
                                      ),
                                      IconButton(
                                        icon:  Icon(Icons.add_circle,color: Colors.blueAccent.shade400,),
                                        onPressed: () {
                                          model.additem(index);
                                        },
                                      ),
                      ],
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.delete, size: 20.0),
                    //   onPressed: () {
                    //     // Handle delete button action
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          ),
        );
      }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 10,); },
    ),
                  const SizedBox(
                    height: 8,
                  ),
                  buildbillingsection(model),
                  const SizedBox(
                    height: 25,
                  ),
                invoiceStatus==2?Container():
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Expanded(
                            child: CtextButton(
                                                    text: 'Cancel',
                                                    onPressed:(){if(invoiceStatus==1){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Are you want to cancel?"),
                                  content: const Text("Permanently Cancelled quotation?"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false); // Return false when cancel is pressed
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                        model.onCancelPressed(context); // Return true when confirm is pressed
                                      },
                                      child: const Text("Confirm"),
                                    ),
                                  ],
                                );
                              },
                            );
                                                    }else{
                            Navigator.of(context).pop();}}, buttonColor: Colors.red.shade400,
                                                  ),
                          ),
                        const SizedBox(width: 20,),
                        invoiceStatus==0||model.invoiceData.docstatus==null?
                      model.isSame==false ?
                        Expanded(
                          child: CtextButton(
                          text:  model.isEdit
                                          ? 'Update Invoice'
                                          : 'Create Invoice',
                          onPressed: () =>  model.onSavePressed(context), buttonColor: Colors.blueAccent.shade400,
                                                ),
                        )
                     :
                      Expanded(
                        child: CtextButton(
                          text: 'Submit Invoice',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm Submit?"),
                                  content: const Text("Permanently Submit invoice?"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false); // Return false when cancel is pressed
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                        model.onSubmitPressed(context); // Return true when confirm is pressed
                                      },
                                      child: const Text("Confirm"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          buttonColor: Colors.blueAccent.shade400,
                        ),
                      ):Container()

                      ],
                    )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  Widget buildImage(String? imageUrl) {
    return Image.network(
      '$baseurl$imageUrl',
    height: 40,
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
        return const Center(
            child: Icon(Icons.broken_image_outlined, size: 36.0));
      },
    );
  }

  Widget buildbillingsection(AddInvoiceViewModel model) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tax and Discount',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          const Divider(
            thickness: 2,
          ),
          buildBillingRow(
              'Subtotal :', model.invoiceData.netTotal?.toString() ?? '0.0'),
          const SizedBox(height: 10,),
          buildBillingRow('Total Tax :',
              model.invoiceData.totalTaxesAndCharges?.toString() ?? '0.0'),
          const SizedBox(height: 10,),
          buildBillingRow('Discount :',
              model.invoiceData.discountAmount?.toString() ?? '0.0'),
          const Divider(
            thickness: 2,
          ),
          buildBillingRow(
              'Total :', model.invoiceData.grandTotal?.toString() ?? '0.0'),
        ],
      ),
    );
  }

  Widget buildBillingRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ],
    );
  }

  Widget buildItemColumn(String labelText, {required String additionalText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AutoSizeText(labelText),
        AutoSizeText(additionalText),
      ],
    );
  }

}
