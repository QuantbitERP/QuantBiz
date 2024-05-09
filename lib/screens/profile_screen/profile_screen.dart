
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/profile_screen/profile_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';
import '../../constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Choose the color scheme based on the current theme
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'My Profile',
            style: TextStyle(fontSize: 20 ),
          ),

        ),
           body: fullScreenLoader(
          loader: model.isBusy,
          context: context,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: colorScheme.shadow,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: '${model.employeedetail.employeeImage}',
                                  width: 70, // Set width to twice the radius for a complete circle
                                  height: 70,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
                                  errorWidget: (context, url, error) => Center(child: Image.asset('assets/images/profile.png', scale: 5)),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 30,
                              child: IconButton.filled(
                                color: Colors.white,
                                onPressed: () {
                                  model.selectPdf(ImageSource.gallery);
                                },
                                icon: const Icon(Icons.add_a_photo, color: Colors.black, size: 25),
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          (model.employeedetail.employeeName ?? "N/A").toUpperCase(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          model.employeedetail.designation ?? "N/A",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                 Container(
  padding: const EdgeInsets.all(18),
  decoration: BoxDecoration(
    color: colorScheme.surface,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        blurRadius: 8,
        color: colorScheme.shadow,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildProfileDetail("Employee ID", model.employeedetail.name ?? "N/A", Icons.person),
      const Divider(thickness: 1,height: 1,color: Colors.black,),
      _buildProfileDetail("Date of Joining", model.employeedetail.dateOfJoining ?? "N/A", Icons.calendar_today),
      const Divider(thickness: 1,height: 1,color: Colors.black,),
      _buildProfileDetail("Date of Birth", model.employeedetail.dateOfBirth ?? "N/A", Icons.cake),
      const Divider(thickness: 1,height: 1,color: Colors.black,),
      _buildProfileDetail("Gender", model.employeedetail.gender ?? "N/A", Icons.people),
      const Divider(thickness: 1,height: 1,color: Colors.black,),
      _buildProfileDetail("Official Email", model.employeedetail.companyEmail ?? "N/A", Icons.email),
      const Divider(thickness: 1,height: 1,color: Colors.black,),
      _buildProfileDetail("Personal Email", model.employeedetail.personalEmail ?? "N/A", Icons.email_outlined),
      const Divider(thickness: 1,height: 1,color: Colors.black,),
      _buildProfileDetail("Contact Number", model.employeedetail.cellNumber ?? "N/A", Icons.phone),
      const Divider(thickness: 1,height: 1,color: Colors.black,),
                     Container(
                       margin: const EdgeInsets.symmetric(vertical: 8.0),
                       child: Row(
                        mainAxisSize: MainAxisSize.min,
                         children: [
                           const Icon(
                             Icons.phone,
                             color: Colors.blueAccent,
                             size: 30,
                           ),
                           const SizedBox(width: 16.0), // Adjust the spacing between icon and text
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               const Text(
                                 "Emergency Contact",
                                 style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14),
                               ),
                               const SizedBox(height: 4.0), // Adjust the spacing between label and value
                               AutoSizeText(
                                 model.employeedetail.emergencyPhoneNumber ??"N/A",
                                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                 minFontSize: 16,
                               ),

                             ],
                           ),
                         ],
                       ),
                     )
     
     
    ])
),


                  const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: colorScheme.shadow,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),child: ListTile(
              onTap: () => Navigator.pushNamed(context, Routes.changePasswordScreen),
              leading: const Icon(Icons.lock_outlined),
              title: const Text('Change the Password',style: TextStyle(fontWeight: FontWeight.bold),),trailing: const Icon(Icons.arrow_forward_ios_outlined),
            )),
                  const SizedBox(height: 20,),
                  Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: colorScheme.shadow,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),child: ListTile(textColor: Colors.redAccent,iconColor: Colors.redAccent,
                    onTap:() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Logout',style: TextStyle(color: Colors.redAccent),),
                            content: const Text('Are you sure you want to log out ?',style: TextStyle(fontSize: 18),),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  // Close the dialog
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel',style: TextStyle(color: Colors.redAccent),),
                              ),
                              TextButton(
                                onPressed: () {
                                  logout(context); // Close the dialog
                                },
                                child: const Text('Yes',),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    leading: const Icon(Icons.login_outlined),
                    title: const Text('Logout',style: TextStyle(fontWeight: FontWeight.bold),),trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildProfileDetail(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.blueAccent,
            size: 30,
          ),
          const SizedBox(width: 16.0), // Adjust the spacing between icon and text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(height: 4.0), // Adjust the spacing between label and value
              AutoSizeText(
                value,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                minFontSize: 16,
              ),

            ],
          ),
        ],
      ),
    );
  }

}
