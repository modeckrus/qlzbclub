import '../localization/localizations.dart';
import 'package:flutter/material.dart';

class SocialsEditor extends StatefulWidget {
  final Function? onAddSocial;
  final Function? onRemoveSocial;
  final Function? onStart;

  const SocialsEditor(
      {Key? key,
      required this.onAddSocial,
      required this.onRemoveSocial,
      this.onStart})
      : super(key: key);
  @override
  _SocialsEditorState createState() => _SocialsEditorState();
}

class _SocialsEditorState extends State<SocialsEditor> {
  List<String>? socials;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    if(widget.onStart != null){
      socials?.addAll(widget.onStart!());
    }
    super.initState();
  }
  Widget buildSocial(String text){
    return ListTile(
      title: Text(text),
      leading: buildIcon(text),
      trailing: IconButton(
        icon: Icon(Icons.close),
        onPressed: (){
          socials?.remove(text);
        },
      ),
    );
  }
  Widget buildIcon(String text){
    return Icon(Icons.public);
  }
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    if(socials == null || socials == []){
      return Container(
        child: CircularProgressIndicator(),
      );
    }
    for (var soc in socials!) {
      children.add(buildSocial(soc));
    }
    return Column(
      children: [
        Container(
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(labelText: AppLocalizations.of(context).link),
          ),
        ),
        ...children
      ],
    );
  }
}
