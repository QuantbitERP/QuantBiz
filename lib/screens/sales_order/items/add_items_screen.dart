import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/widgets/customtextfield.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';
import '../../../constants.dart';
import '../../../model/add_order_model.dart';
import 'add_item_model.dart';

class ItemScreen extends StatelessWidget {
  final String warehouse;
  final List<Items> items;

  const ItemScreen({super.key, required this.warehouse, required this.items});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemListModel>.reactive(
      viewModelBuilder: () => ItemListModel(),
      onViewModelReady: (model) => model.initialise(context, warehouse, items),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Select Items'),
          ),
          body: fullScreenLoader(
            loader: model.isBusy,
            context: context,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomSmallTextFormField(controller: model.searchController, labelText: 'Search', hintText: 'Type here to search',onChanged: model.searchItems,),
                  const SizedBox(height: 15),
                  ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: model.filteredItems.length,
              itemBuilder: (context, index) {
                final selectedItem = model.filteredItems[index];
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:  model.isSelected(selectedItem) ? Colors.blue.shade200 : Colors.white,
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
                        child:CachedNetworkImage(
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
                            AutoSizeText(
                              'Code: ${selectedItem.itemCode}\n${selectedItem.itemName}',
                              style: const TextStyle(

                                fontWeight: FontWeight.bold,
                              ),
                              maxFontSize:16.0,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  'Rate\n ${selectedItem.rate.toString()}',
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(width: 40,),
                                AutoSizeText(
                                  'Actual Qty\n ${selectedItem.actualQty}',
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      // Quantity and Buttons
                      Column(

                        children: [
                          Checkbox(value: model.isSelected(selectedItem),
                            onChanged: (bool? value) {
                              if (model.filteredItems.contains(selectedItem)) {
                                model.toggleSelection(selectedItem);
                              }
                            },),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.blueAccent.shade400, width: 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center, // Align items in the center horizontally
                              crossAxisAlignment: CrossAxisAlignment.center, // Align items in the center vertically
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_circle, color: Colors.blueAccent.shade400,),
                                  onPressed: () {
                                    // Decrease quantity when the remove button is pressed
                                    if (selectedItem.qty != null && (selectedItem.qty ?? 0) > 1) {
                                      model.removeitem(index);
                                    }
                                  },
                                ),
                                Text(
                                  model.getQuantity(selectedItem).toString(),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add_circle, color: Colors.blueAccent.shade400,),
                                  onPressed: () {
                                    model.additem(index);
                                  },
                                ),
                              ],
                            ),
                          )


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
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(thickness: 1,);
              },
            )
]
            ),
            ),
          ),
          bottomSheet: BottomSheetWidget(
            model: model,
          )),
    );
  }

  Widget buildImage(String? imageUrl) {
    return Image.network(
      '$baseurl$imageUrl',
      height: 36,
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
        return const Icon(Icons.broken_image,size: 36,);
      },
    );
  }

  Widget buildItemColumn(String label, {String? additionalText}) {
    return Column(
      children: [
        AutoSizeText(label),
        if (additionalText != null) AutoSizeText(additionalText),
      ],
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  final ItemListModel model;

  const BottomSheetWidget({super.key, required this.model});

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white38,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: Colors.white38,
            ),
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context, widget.model.isSelecteditems);
                },
                minWidth: 200.0,
                height: 48.0,
                color: Colors.blueAccent,
                textColor: Colors.white,
                child: const Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
