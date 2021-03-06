import 'package:flutter/material.dart';

import '../localization/localizations.dart';

class TagsEditor extends StatefulWidget {
  final Function? onAddTag;
  final Function? onRemoveTag;
  final Function? onStart;
  const TagsEditor(
      {Key? key,
      required this.onAddTag,
      required this.onRemoveTag,
      this.onStart})
      : super(key: key);
  @override
  _TagsEditorState createState() => _TagsEditorState();
}

class _TagsEditorState extends State<TagsEditor> {
  List<String> tags = [];
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    if (widget.onStart != null) {
      tags.addAll(widget.onStart!());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tagsWidget = [];
    tags.forEach((element) {
      tagsWidget.add(GestureDetector(
          onTap: () {
            final index = tags.indexOf(element);
            tagsWidget.removeAt(index);
            tags.remove(element);
            if(widget.onRemoveTag != null){
            widget.onRemoveTag!(element);
            }
            setState(() {});
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.black45,
                  border:
                      Border.fromBorderSide(BorderSide(color: Colors.black54)),
                  borderRadius: BorderRadius.circular(25)),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    element,
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(
                    Icons.close,
                    size: 16,
                  )
                ],
              ))));
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (tagsWidget.length != 0)
          Container(
            child: Wrap(
              children: tagsWidget,
            ),
          )
        else
          Text(
            AppLocalizations().addTags,
            style: TextStyle(fontSize: 24),
          ),
        TextField(
          controller: _controller,
          maxLength: 50,
          decoration: InputDecoration(labelText: AppLocalizations().tag),
          onChanged: (ntag) {
            print(ntag);
            if (ntag[ntag.length - 1].contains(' ')) {
              print('its ok');
              if (tags.length < 40) {
                ntag.replaceAll(' ', '');
                tags.add(ntag);
                if(widget.onAddTag != null ){
                  widget.onAddTag!(ntag);
                }
                
              } else {}

              _controller.text = '';
              setState(() {});
            }
          },
          onSubmitted: (ntag){
            print(ntag);
              if (tags.length < 40) {
                
                tags.add(ntag);
                if(widget.onAddTag != null ){
                  widget.onAddTag!(ntag);
                }
              } else {}
              _controller.text = '';
              setState(() {});
            
          },
        )
      ],
    );
  }
}
