import 'package:firebase_project/auth/auth_service.dart';
import 'package:firebase_project/pages/login_page.dart';
import 'package:firebase_project/pages/userList_page.dart';
import 'package:firebase_project/pages/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LauncherPage extends StatefulWidget {
  static const routeName ="/";
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero,(){

      if(AuthService.user==null){
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }else{
        Navigator.pushReplacementNamed(context, UserListPage.routeName);
      }

    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CircularProgressIndicator(),

    );
  }
}