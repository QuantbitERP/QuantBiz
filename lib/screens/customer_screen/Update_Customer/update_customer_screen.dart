import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:geolocation/screens/customer_screen/Update_Customer/update_customer_model.dart';
import 'package:geolocation/widgets/full_screen_loader.dart';
import 'package:stacked/stacked.dart';

import '../../../router.router.dart';
import '../../../widgets/custom_button.dart';

class UpdateCustomer extends StatefulWidget {
  final String id;
  const UpdateCustomer({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateCustomer> createState() => _UpdateCustomerState();
}

class _UpdateCustomerState extends State<UpdateCustomer> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateCustomerViewModel>.reactive(
      viewModelBuilder: () => UpdateCustomerViewModel(),
      onViewModelReady: (model) => model.initialise(context, widget.id),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: AutoSizeText(
            model.customerData.name ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(
                  context, Routes.addCustomer,
                  arguments: AddCustomerArguments(id: widget.id)),
              icon: const Icon(Icons.edit),
            )
          ],
        ),
        body: fullScreenLoader(
          loader: model.isBusy,
          context: context,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Receivable\n RS. 100',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.white,
                            height: 20,
                          ),
                          Text(
                            'Used Credits\n RS. 200',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'To Packed: 1',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'To Be Shipped: 2',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const TabBar(
                          tabAlignment: TabAlignment.fill,
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(
                              text: 'Details',
                            ),
                            Tab(
                              text: 'Transactions',
                            ),
                            Tab(
                              text: 'Comments',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 300,
                        child: TabBarView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 7,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.account_circle_outlined),
                                            const SizedBox(width: 16.0),
                                            Text(
                                              model.customerData.customerName ?? "",
                                              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.phone_outlined),
                                            const SizedBox(width: 16.0),
                                            Text(
                                              model.customerData.mobileNo ?? "N/A",
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.email_outlined),
                                            const SizedBox(width: 16.0),
                                            Text(
                                              model.customerData.emailId ?? "N/A",
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15.0),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomButton(
                                              icon: Icons.phone_outlined,
                                              text: 'Mobile',
                                              onPressed: () {
                                                if(model.customerData.mobileNo!.isNotEmpty){
                                                model.service.call(model.customerData.mobileNo ?? "");}},
                                            ),
                                            CustomButton(
                                              icon: Icons.sms_outlined,
                                              text: 'SMS',
                                              onPressed: () { if(model.customerData.mobileNo!.isNotEmpty){
                                                model.service.sendSms(model.customerData.mobileNo ?? "");}}
                                            ),
                                            CustomButton(
                                              icon: Icons.email_outlined,
                                              text: 'Email',
                                              onPressed: () {
                                                if(model.customerData.emailId!.isNotEmpty){
    model.service.sendEmail(model.customerData.emailId ?? "");}
                                                }
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            orderList(context, model),
                            comment(context, model),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget comment(BuildContext context, UpdateCustomerViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: model.comments.isNotEmpty
              ? ListView.separated(
            separatorBuilder: (context, builder) {
              return const SizedBox(
                height: 5,
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: model.comments.length,
            itemBuilder: (context, index) {
              final comment = model.comments[index];
              return Card(
                child: ListTile(
                  leading: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: comment.userImage ?? '',
                      width: 40,
                      matchTextDirection: true,
                      height: 40,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
                      errorWidget: (context, url, error) => Center(child: Image.asset('assets/images/profile.png', scale: 5)),
                    ),
                  ),
                  title: Html(data: comment.comment.toString(),shrinkWrap: true,),
                  subtitle: Text("${comment.commentBy} | ${comment.creation}",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              );
            },
          )
              : Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: const Text(
                'Sorry, you got nothing!',
                textDirection: TextDirection.ltr,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        Container(
          color: Colors.blueAccent.shade400,
          padding: const EdgeInsets.all(10),
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: model.comment,
                    decoration: InputDecoration(
                      hintText: 'Enter a comment',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (model.comment.text.isNotEmpty) {
                    model.addComment(model.customerData.name, model.comment.text);
                  }
                },
                icon: const Icon(Icons.send_outlined, size: 30, color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }


  Widget orderList(BuildContext context, UpdateCustomerViewModel model) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sales Orders'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close_outlined),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1, color: Colors.grey),
                        ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: model.status.length,
                          itemBuilder: (BuildContext context, int index) {
                            final status = model.status[index];
                            return ListTile(
                              tileColor: Colors.black12,
                              selectedTileColor: Colors.black,
                              title: Text(status),
                              onTap: () {
                                model.addFilter(model.customerData.name.toString(), status);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.filter_alt_rounded),
          )
        ],
      ),
      body: model.filterOrders.isNotEmpty
          ? ListView.builder(
        itemCount: model.filterOrders.length,
        itemBuilder: (context, index) {
          final order = model.filterOrders[index];
          return Card(
            elevation: 1,
            color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: Text(order.name ?? ""),
              subtitle: Text(order.deliveryDate ?? ""),
              trailing: Text(
                '\$${order.roundedTotal}',
                style: const TextStyle(color: Colors.green, fontSize: 15),
              ),
              onTap: () {
                Navigator.pushNamed(context, Routes.addOrderScreen, arguments: AddOrderScreenArguments(orderid: order.name.toString()));
              },
            ),
          );
        },
      )
          : Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: const Text(
            'Sorry, you got nothing!',
            textDirection: TextDirection.ltr,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          child: const Icon(Icons.add, size: 40),
          onPressed: () => Navigator.pushNamed(context, Routes.addOrderScreen, arguments: const AddOrderScreenArguments(orderid: "")),
        ),
      ),
    );
  }
}
