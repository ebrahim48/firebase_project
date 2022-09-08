import 'package:firebase_project/providers/user_provider.dart';
import 'package:firebase_project/widgets/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_group_page.dart';

class UserListPage extends StatefulWidget {
  static const routeName = "user-list-page";
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool isinit = true;

  @override
  void didChangeDependencies() {
    if (isinit) {
      Provider.of<UserProvider>(context, listen: false).getAllUsers();

      isinit = false;
    }



    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
      ),
      drawer: MainDrawer(),
      body: Consumer<UserProvider>(
        builder: (context, provider, _) => ListView.builder(
            itemCount: provider.allUserList.length,
            itemBuilder: (context, index) {
              final user = provider.allUserList[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: user.image == null
                      ? Image.asset(
                    "assets/images/person.png",
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  )
                      : Image.network(user!.image!,
                      height: 40, width: 40, fit: BoxFit.cover),
                ),
                title: Text(user!.name ?? user!.email!),
                trailing: Icon(
                  Icons.circle,
                  color: user.available ? Colors.green : Colors.red,
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, CreateGroupPage.routeName);
        },
        child: Icon(Icons.groups),
      ),
    );

  }
}
