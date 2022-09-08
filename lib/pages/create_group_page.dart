import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import '../providers/chat_room_provider.dart';

class CreateGroupPage extends StatefulWidget {
  static const routeName = "create-group-page";
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final nameController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group!"),
        actions: [
          IconButton(onPressed: (){
            Provider.of<ChatRoomProvider>(context,listen: false).addGroup(

                nameController.text.trim(), AuthService.user!.uid);

          }, icon: Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: TextFormField(
              controller: nameController,
              style: TextStyle(
                  color: Colors.purple, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffe6e6e6),
                  contentPadding: EdgeInsets.only(left: 10),
                  focusColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.groups,
                  ),
                  hintText: "Enter your group name",
                  hintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.normal),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field must not be empty';
                } else {
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
