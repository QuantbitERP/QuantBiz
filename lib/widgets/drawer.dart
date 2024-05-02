import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../constants.dart';
import '../router.router.dart';

Widget myDrawer(BuildContext context, String name, String email, String image) {
  return Drawer(
    child: SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.blue, // Change the background color as needed
            padding: const EdgeInsets.only(top: 20),
            child: UserAccountsDrawerHeader(
              accountName: AutoSizeText(
                name,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Adjust text color
                ),
              ),
              accountEmail: AutoSizeText(
                email,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white, // Adjust text color
                ),
              ),
              arrowColor: Colors.black87,
              currentAccountPicture: ClipOval(
                // Set background color for the avatar
               child: CachedNetworkImage(
                 imageUrl: image,
                 width: 70, // Set width to twice the radius for a complete circle
                 height: 70,
                 fit: BoxFit.cover,
                 placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
                 errorWidget: (context, url, error) => Center(child: Image.asset('assets/images/profile.png', scale: 5)),
               ),
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/images/drawer_bg.jpg',
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Bootstrap.house, color: Colors.black),
            title: const Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.homePage);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.black),
            title: const Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.profileScreen);
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.black),
            title: const Text(
              'Route Details',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.geolocation);
            },
          ),

          const Divider(thickness: 1),
          ListTile(
            leading: const Icon(Icons.policy, color: Colors.black),
            title: const Text(
              'Privacy Policy',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),

            onTap: () async {
              String url =
                  'https://doc-hosting.flycricket.io/quantbiz-privacy-policy/be560405-7f35-4f4f-87bb-5a7b9acb1c69/privacy';
              if (await canLaunchUrlString(url)) {
                await launchUrlString(url);
              } else {
                throw 'Could not launch $url';
              }

            },
          ),
          ListTile(
            leading: const Icon(Iconsax.logout, color: Colors.black),
            title: const Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Logout'),
                    content: Text('Are you sure you want to log out?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          logout(context); // Close the dialog
                        },
                        child: Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    ),
  );
}
