
import 'package:auto_size_text/auto_size_text.dart';
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
            style: TextStyle(fontSize: 18, color: colorScheme.onPrimary),
          ),
          leading: IconButton.outlined(
            onPressed: () => Navigator.popAndPushNamed(context, Routes.homePage),
            icon:  Icon(Icons.arrow_back, color: colorScheme.onPrimary),
          ),
          backgroundColor: colorScheme.primary,
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
                                child: Image.network(
                                  model.employeedetail.employeeImage ?? "",
                                  width: 60,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator(color: Colors.blueAccent));
                                    }
                                  },
                                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                    return Center(
                                      child: Image.asset('assets/images/profile.png', scale: 5),
                                    );
                                  },
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
      _buildProfileDetail("Date of Joining", model.employeedetail.dateOfJoining ?? "N/A", Icons.calendar_today),
      _buildProfileDetail("Date of Birth", model.employeedetail.dateOfBirth ?? "N/A", Icons.cake),
      _buildProfileDetail("Gender", model.employeedetail.gender ?? "N/A", Icons.people),
      _buildProfileDetail("Official Email", model.employeedetail.companyEmail ?? "N/A", Icons.email),
      _buildProfileDetail("Personal Email", model.employeedetail.personalEmail ?? "N/A", Icons.email_outlined),
      _buildProfileDetail("Contact Number", model.employeedetail.cellNumber ?? "N/A", Icons.phone),
      Row(
        children: [
          Icon(
            Icons.phone_in_talk,
            color: Colors.blueAccent,
            size: 30,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Emergency Contact",
                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14),
              ),
               
               AutoSizeText(
         textAlign: TextAlign.end,
        model.employeedetail.emergencyPhoneNumber ?? "N/A",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        minFontSize: 16,
      ),
            ],
          ),
        ],
      ),
     
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
              onTap: () => Navigator.popAndPushNamed(context, Routes.changePasswordScreen),
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
                            title: const Text('Logout'),
                            content: const Text('Are you sure you want to log out?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  // Close the dialog
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  logout(context); // Close the dialog
                                },
                                child: const Text('Logout'),
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
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        
        children: [
          Icon(
            icon,
            color: Colors.blueAccent,
            size: 30,
          ),
          const SizedBox(width: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14),
              ),
               AutoSizeText(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        textAlign: TextAlign.center,
        minFontSize: 16,
      ),
            ],
          ),
        ],
      ),
     
      const Divider(thickness: 1, color: Colors.grey),
      const SizedBox(height: 16),
    ],
  );
}
}
