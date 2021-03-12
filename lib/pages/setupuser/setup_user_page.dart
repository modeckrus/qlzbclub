import '../../entities/user.dart';
import '../../localization/localizations.dart';
import '../../service/dgraph_service.dart';
import '../../service/user_service.dart';
import '../../widgets/choose_avatar_widget.dart';
import '../../widgets/tags_editor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SetupUserPage extends StatefulWidget {
  @override
  _SetupUserPageState createState() => _SetupUserPageState();
}

class _SetupUserPageState extends State<SetupUserPage> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _bioController= TextEditingController();
  TextEditingController _linkController= TextEditingController();
  List<String> tags = [];
  @override
  void initState() {
    _nameController.addListener(check);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _bioController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void onAvatar(String photoUrl) {}
  bool isOk = false;
  void check() {
    final name = _nameController.text;
    if (name.length < 2 || tags.length < 1) {
      if (isOk) {
        setState(() {
          print('SetState');
          isOk = false;
        });
      }
    } else {
      if (!isOk) {
        setState(() {
          print('SetState');
          isOk = true;
        });
      }
    }
  }

  void updateUser(){
    GetIt.I.get<UserService>().updateUser(GetIt.I.get<User>().copyWith(
      name: _nameController.text,
      bio: _bioController.text,
      lastLogin: DateTime.now(),
      link: _linkController.text,
      tags: tags,
    
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Setup User'),
        actions: [
          IconButton(icon: Icon(Icons.ac_unit), onPressed: (){
            print(DateTime.now().toIso8601String());
          },)
        ],
      ),
      floatingActionButton: isOk
          ? FloatingActionButton(
              onPressed: () {
                updateUser();
              },
              child: Icon(
                Icons.check,
              ),
            )
          : FloatingActionButton(
              onPressed: null,
              child: Icon(
                Icons.close,
              ),
              backgroundColor: Colors.red,
            ),
      body: CupertinoScrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: ChooseAvatarWidget(
                    onAvatarAdd: onAvatar,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: TextFormField(
                    controller: _nameController,
                    maxLength: 50,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).name),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, right: 10),
                        child: Text('qlzb.ed/@'),
                      ),
                      Expanded(
                                              child: TextFormField(
                    controller: _linkController,
                    maxLength: 50,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (String? value){
                      
                      final regExp = RegExp(r'[a-z]');
                      return (value != null && regExp.hasMatch(value))? null : 'Use only latin letters';
                    },
                  ),
                      ),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: 
                  TextFormField(
                          controller: _bioController,
                          maxLength: 1200,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).bio),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Container(
                    constraints: BoxConstraints(maxWidth: 600),
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: TagsEditor(onAddTag: (tag) {
                      tags.add(tag);
                      check();
                    }, onRemoveTag: (tag) {
                      tags.remove(tag);
                      check();
                    })),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
