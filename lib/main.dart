import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/pages/chat_room_page.dart';
import 'package:firebase_project/pages/create_group_page.dart';
import 'package:firebase_project/pages/launcher_page.dart';
import 'package:firebase_project/pages/login_page.dart';
import 'package:firebase_project/pages/userList_page.dart';
import 'package:firebase_project/pages/user_profile.dart';
import 'package:firebase_project/providers/chat_room_provider.dart';
import 'package:firebase_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => ChatRoomProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    print("init");
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (AuthService.user != null) {
      Provider.of<UserProvider>(context, listen: false)
          .updateAvailable(AuthService.user!.uid!, true);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    switch(state){

      case AppLifecycleState.paused:
        if(AuthService.user != null){

          Provider.of<UserProvider>(context,listen: false).updateAvailable(AuthService.user!.uid!, false);
        }
        break;
      case AppLifecycleState.resumed:
        if(AuthService.user != null){

          Provider.of<UserProvider>(context,listen: false).updateAvailable(AuthService.user!.uid!, true);
        }
        break;


    }
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (context) => const LauncherPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        UserProfilePage.routeName: (context) => const UserProfilePage(),
        ChatRoomPage.routeName: (context) => const ChatRoomPage(),
        UserListPage.routeName: (context) => const UserListPage(),
        CreateGroupPage.routeName: (context) => const CreateGroupPage(),
      },
    );
  }
}
