import 'package:clubhouse/entities/open_club.dart';
import 'package:clubhouse/localization/localizations.dart';
import 'package:clubhouse/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';

class OpenClubWidget extends StatefulWidget {
  final OpenClub club;

  const OpenClubWidget({Key? key, required this.club}) : super(key: key);
  @override
  _OpenClubWidgetState createState() => _OpenClubWidgetState();
}

class _OpenClubWidgetState extends State<OpenClubWidget> {
  OpenClub get club => widget.club;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: EdgeInsets.all(8),
            color: Theme.of(context).appBarTheme.backgroundColor,
        child: Column(
          children: [
            ListTile(
              leading: AvatarWidget(avatarUrl: club.avatarUrl),
              title: Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Text(club.title, overflow: TextOverflow.ellipsis,),
              ),
              subtitle: Text(club.description, overflow: TextOverflow.ellipsis, maxLines: 6,),
              trailing: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: RawMaterialButton(
                  onPressed: () {},
                  // fillColor: Theme.of(context).buttonColor,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(AppLocalizations.of(context).connect),
                        Padding(
                          padding: const EdgeInsets.only(bottom:8.0),
                          child: Icon(Icons.navigate_next),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                      title: Text(club.owner.name, textAlign: TextAlign.end,),
                      trailing: AvatarWidget(avatarUrl: club.owner.photoUrl,),
                      subtitle: Text(club.owner.status??AppLocalizations.of(context).unknow, textAlign: TextAlign.end, overflow: TextOverflow.ellipsis,),
                      leading: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: (){},
                  ),
                ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
