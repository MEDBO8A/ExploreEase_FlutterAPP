// ignore_for_file: must_be_immutable, prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/screens/sign_in_screen.dart';

import '../model/user.dart';
import '../screens/community_chat_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/profile_screen.dart';
import '../services/authServices.dart';

class NavigationDrawerBar extends StatelessWidget {
  NavigationDrawerBar({Key? key});
  AuthServices auth = AuthServices();
  UserModel? user = UserModel.current;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Drawer(
      child: Material(
        color: themeColors.onBackground,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: user != null
                              ? NetworkImage(user!.profPic)
                              : null,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          user!.username,
                          style: TextStyle(
                            color: themeColors.surface,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            user!.mail,
                            style: TextStyle(
                              color: themeColors.surface,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: themeColors.surface,
                        size: 20,
                      ),
                      title: Text(
                        "My Account",
                        style: TextStyle(
                            color: themeColors.surface,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MyProfileScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.heart,
                        color: themeColors.surface,
                        size: 20,
                      ),
                      title: Text(
                        "Favorites",
                        style: TextStyle(
                            color: themeColors.surface,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      onTap: () {

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MyFavoriteScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.message_outlined,
                        color: themeColors.surface,
                        size: 20,
                      ),
                      title: Text(
                        "Community Chat",
                        style: TextStyle(
                            color: themeColors.surface,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      onTap: () {

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CommunityChatScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 10,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Icons.support_agent,
                  color: themeColors.surface,
                  size: 20,
                ),
                title: Text(
                  "Customer Support",
                  style: TextStyle(
                      color: themeColors.surface,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                onTap: () {
                  /*
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MySupportPage(),
                    ),
                  );

                   */
                },
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.powerOff,
                  color: themeColors.surface,
                  size: 20,
                ),
                title: Text(
                  "Log Out",
                  style: TextStyle(
                      color: themeColors.surface,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: themeColors.background,
                        title: Text(
                          "Log Out",
                          style: TextStyle(
                            color: themeColors.error,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        content: Text(
                          "Confirme to log out",
                          style: TextStyle(
                            color: themeColors.surface,
                            fontSize: 18,
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: themeColors.primary,
                                ),
                                onPressed: () async{
                                  await auth.signOut();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MySignInScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: themeColors.onSecondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
