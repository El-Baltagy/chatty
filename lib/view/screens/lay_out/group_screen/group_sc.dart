import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import '../../../../controller/provider/auth.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_colors.dart';
import '../../../../shared/utils/app_methods.dart';
import '../../../../shared/utils/global.dart';
import 'package:chatty/models/group_model.dart' as model;
import '../../../../shared/widgets/ttf.dart';


 List<String> selectedGroupUids = [];
List selectedGroupMembers = [];

 List avilableMembers = [];


class GroupSC extends StatefulWidget {
  const GroupSC({super.key});

  @override
  State<GroupSC> createState() => _GroupSCState();
}

class _GroupSCState extends State<GroupSC> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool atFirst=true;
  File? image;

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMembersData();
  }
  @override
  void dispose() {
    super.dispose();
    groupNameController.dispose();
  }

  void createGroup() {
    if (groupNameController.text.trim().isNotEmpty && image != null) {
      creatGroup(
        context,
        groupNameController.text.trim(),
        image!,
          selectedGroupMembers
      );
      selectedGroupMembers.clear();
      Navigator.pop(context);
    }
  }


  getMembersData({String? val})async{
    avilableMembers.clear();
    late var userC;
    if (atFirst) {
      userC= await firestore.collection('users').get();
    }else{
      userC= await firestore.collection('users').where('name',isEqualTo:val ).get();
    }
    if (userC.docs.isNotEmpty && userC.docs[0].exists) {
      avilableMembers=List.generate(userC.docs.length, (i) => userC.docs[i].data());
    }

    // if (userC.docs.isNotEmpty && userC.docs[0].exists) {
    //   avilableMembers=List.generate(userC.docs.length, (i) => userC.docs[i].data());
    //   // allMembers=List.generate(userC.docs.length, (i) => userC.docs[i].data()['name']);
    //   // allUids=List.generate(userC.docs.length, (i) => userC.docs[i].data()['uid']);
    // }
    print(avilableMembers.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                image == null
                    ? const CircleAvatar(
                  backgroundImage: NetworkImage(
                    AssetManager.defaultImg,
                  ),
                  radius: 64,
                )
                    : CircleAvatar(
                  backgroundImage: FileImage(
                    image!,
                  ),
                  radius: 64,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: groupNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Group Name',
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Select Contacts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            buildTextFormField(
              controller: nameController,
                labelTitle: 'select member'.toUpperCase(),
              suffix: Icons.clear,
              suffixPressed: () => nameController.clear(),
              OnTap: () {
                setState(() {
                  atFirst=false;
                });
              },
              onChange: (val){
                getMembersData(val: val);
              } ,
            ),
            ListView.separated(
                scrollDirection:Axis.horizontal,
                itemBuilder: (context, index) => Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                          selectedGroupMembers[index]['name']),
                    ),
                    IconButton(onPressed: (){
                      selectedGroupMembers.removeAt(index);
                    }, icon: const Icon(Icons.clear))
                  ],
                ),
                separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                itemCount: selectedGroupMembers.length),

            ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                  onTap:  () {
                    selectedGroupMembers.add(avilableMembers[index]);
                    selectedGroupUids.add(avilableMembers[index]['uid']);
                    setState(() {});
                  },
                  child: Text(
                      avilableMembers[index]['name']),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                itemCount: avilableMembers.length)
            // const SelectContactsGroup(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createGroup,
        backgroundColor: AppColors.tabColor,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }

}
void creatGroup(BuildContext context, String name, File profilePic,
    List selectedContact) async {
  try {
    var groupId = const Uuid().v1();

    String profileUrl = await Provider.of<AuthProv>(context,listen: false).storeFileToFirebase(
      'group/$groupId',
      profilePic,
    );
    model.Group group = model.Group(
      senderId: fAuth.currentUser!.uid,
      name: name,
      groupId: groupId,
      lastMessage: '',
      groupPic: profileUrl,
      membersUid: [fAuth.currentUser!.uid, ...selectedGroupUids],
      timeSent: DateTime.now(),
    );

    await firestore.collection('groups').doc(groupId).set(group.toMap());
  } catch (e) {
    debugPrint(e.toString());
    showSnackBar(context: context, content: e.toString());
  }
}


// getMembersData()async{
//   allMembers.clear();
//   // var userC= await firestore.collection('users').get();
//   //
//   // if (userC.docs.isNotEmpty && userC.docs[0].exists) {
//   //   allMembers=List.generate(userC.docs.length, (i) => userC.docs[i].data());
//   // }
//   var userC= await firestore.collection('users').get();
//
//   if (userC.docs.isNotEmpty && userC.docs[0].exists) {
//     allMembers=List.generate(userC.docs.length, (i) => userC.docs[i].data());
//     // allMembers=List.generate(userC.docs.length, (i) => userC.docs[i].data()['name']);
//     // allUids=List.generate(userC.docs.length, (i) => userC.docs[i].data()['uid']);
//   }
//   print(allMembers.toString());
// }