import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';

import '../entities/closed_club.dart';
import '../entities/open_club.dart';
import '../entities/social_club.dart';
import '../localization/localizations.dart';
import '../service/db_service.dart';
import '../widgets/tags_editor.dart';

class ClubPage extends StatefulWidget {
  const ClubPage() : super();
  @override
  _ClubPageState createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).home),
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showBottomSheet(
                  context: context,
                  builder: (context) {
                    return CreateClubWidget();
                  });
            },
          );
        }),
        body: CreateClubWidget(),
      ),
    );
  }
}

class CreateClubWidget extends StatefulWidget {
  const CreateClubWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CreateClubWidgetState createState() => _CreateClubWidgetState();
}

class _CreateClubWidgetState extends State<CreateClubWidget> {
  int index = 0;
  double size = 150;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<String> tags = [];
  bool isOk(){
    final isTitle = _titleController.text.length > 3;
    final isTags = tags.length > 2;
    final isIndex = index != 0;
    return isTitle && isTags && isIndex;
  }
  @override
  void initState() {    
    super.initState();
  }
  void addClub(){
    final title = _titleController.text;
    if(index == 1){
      GetIt.I.get<Db>().createOpenClub(OpenClub.createOpenClub(title: title, description: _descriptionController.text, tags: tags));
    }
    if(index == 2){
      GetIt.I.get<Db>().createSocialClub(SocialClub.createSocialClub(title: title, description: _descriptionController.text, tags: tags));
    }
    if(index == 3){
      GetIt.I.get<Db>().createClosedClub(ClosedClub.createClosedClub(title: title, description: _descriptionController.text, tags: tags));
    }
  }
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width / 3;
    if(size > 350){
      size = 350;
    }
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: _titleController,
                maxLength: 120,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).addTitle,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: _descriptionController,
                maxLength: 120,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).shortDesc
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: TagsEditor(onAddTag: (tag){
                tags.add(tag);
              }, onRemoveTag: (tag){
                tags.remove(tag);
              }, onStart: (){
                return tags;
              },),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 600,
              ),
              child: Wrap(
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    mouseCursor: SystemMouseCursors.click,
                    child: Container(
                      width: size,
                      height: size,
                      constraints: BoxConstraints(
                        maxWidth: 200
                      ),
                      child: Column(children: [
                        Icon(
                          Icons.public,
                          size: size / 2,
                          color: index == 1
                              ? Theme.of(context).accentColor
                              : Theme.of(context).iconTheme.color,
                        ),
                        Text(
                          'Public Club',
                          style: TextStyle(
                            fontSize: size / 6,
                            color: index == 1
                                ? Theme.of(context).accentColor
                                : Theme.of(context).textTheme.bodyText1?.color,
                            decoration: index == 1
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        )
                      ]),
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        index = 2;
                      });
                    },
                    mouseCursor: SystemMouseCursors.click,
                    child: Container(
                      width: size,
                      height: size,
                      constraints: BoxConstraints(
                        maxWidth: 200
                      ),
                      child: Column(children: [
                        Icon(
                          Icons.subscriptions,
                          size: size / 2,
                          color: index == 2
                              ? Theme.of(context).accentColor
                              : Theme.of(context).iconTheme.color,
                        ),
                        Text(
                          'Social Club',
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: size / 7,

                            color: index == 2
                                ? Theme.of(context).accentColor
                                : Theme.of(context).textTheme.bodyText1?.color,
                            decoration: index == 2
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        )
                      ]),
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        index = 3;
                      });
                    },
                    
                    mouseCursor: SystemMouseCursors.click,
                    child: Container(
                      width: size,
                      height: size,
                      constraints: BoxConstraints(
                        maxWidth: 200
                      ),
                      child: Column(children: [
                        Icon(
                          Icons.public_off,
                          size: size / 2,
                          color: index == 3
                              ? Theme.of(context).accentColor
                              : Theme.of(context).iconTheme.color,
                        ),
                        Text(
                          'Closed Club',
                          style: TextStyle(
                            fontSize: size / 6,
                            color: index == 3
                                ? Theme.of(context).accentColor
                                : Theme.of(context).textTheme.bodyText1?.color,
                            decoration: index == 3
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: RawMaterialButton(
                onPressed: isOk()? () {
                  addClub();
                }:null,
                
                fillColor: isOk() ? Theme.of(context).buttonColor: Theme.of(context).scaffoldBackgroundColor,
                mouseCursor: SystemMouseCursors.click,
                child: Container(
                  width: size * 2,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.run_circle_outlined,
                        size: size / 2,
                      ),
                      Text(
                        isOk()?'Let\'s Go':'Add title\n2+ tags\nChoose type',
                        style: TextStyle(
                          fontSize: size / 6,
                        ),
                        overflow: TextOverflow.fade,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
