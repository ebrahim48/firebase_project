import 'package:firebase_project/pages/chat_room_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import '../pages/launcher_page.dart';
import '../pages/login_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [



          UserAccountsDrawerHeader(

              accountName: Text(AuthService.user!.displayName == null ?"No display name set" : AuthService.user!.displayName!),
              accountEmail: Text(AuthService.user!.email!)
          ),
          ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(context, ChatRoomPage.routeName);

            },
            leading: Icon(Icons.chat_rounded),
            title: const Text("Chat Room"),
          ),

          ListTile(
            onTap: ()async{
              await AuthService.logout();
              Navigator.pushReplacementNamed(context, LoginPage.routeName);

            },
            leading: Icon(Icons.logout),
            title: const Text("LOGOUT"),
          ),
        ],
      ),
    );
  }
}
