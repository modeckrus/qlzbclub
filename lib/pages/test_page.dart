
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../localization/localizations.dart';
import '../service/db_service.dart';
import '../service/user_service.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String logStr = '';
  void log(String l) {
    setState(() {
      logStr += l + '\n';
    });
  }

  void clearLog() {
    setState(() {
      logStr = '';
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _usernameController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).test),
              actions: [
                IconButton(
                    icon: Icon(Icons.clear_all),
                    onPressed: () {
                      clearLog();
                    })
              ],
            ),
            body: CupertinoScrollbar(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.graphic_eq),
                    trailing: Icon(Icons.straighten_rounded),
                    title: Text('Init GraphQl'),
                    onTap: () {},
                  ),
                  Divider(),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'User Name'),
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  ListTile(
                    title: Text('Add User'),
                    leading: Icon(Icons.account_circle),
                    trailing: Icon(Icons.run_circle_outlined),
                    onTap: () async {
                      final client =
                          GetIt.I.get<GraphQLClient>(instanceName: 'graphql');
                      final inputStr = r'''
mutation AddUser($username: String!, $name: String!){
  addUser(input: {
    username: $username,
    name: $name
  }){
    user{
      username
      name
      tasks{
        id
        title
        completed
      }
    }
  }
}
                ''';
                      final res = await client.mutate(
                          MutationOptions(document: gql(inputStr), variables: {
                        'username': _usernameController.text,
                        'name': _nameController.text
                      }));
                      log(res.data.toString());
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Query User'),
                    leading: Icon(Icons.search),
                    trailing: Icon(Icons.run_circle_outlined),
                    onTap: () async {
                      final client =
                          GetIt.I.get<GraphQLClient>(instanceName: 'graphql');
                      final inputStr = r'''
query GetUser($username: String!){
  queryUser(filter:  {username: {eq: $username} }){
    username
    name
    tasks{
      id
      title
      completed
    }
  }
}
                ''';
                      final res = await client.query(
                          QueryOptions(document: gql(inputStr), variables: {
                        'username': _usernameController.text,
                      }));
                      log(res.data.toString());
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Run addUserClaims'),
                    leading: Icon(Icons.cloud),
                    trailing: Icon(Icons.run_circle_outlined),
                    onTap: () async {
                      final jwt = await GetIt.I.get<UserService>().getJwtToken();
                      log(jwt);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Get User Info'),
                    leading: Icon(Icons.account_circle_outlined),
                    trailing: Icon(Icons.info),
                    onTap: () async {
                      final user = await GetIt.I.get<Db>().getUser();
                      if(user == null){
                        log('User null');
                      }
                      log(user!.toJson());
                    },
                  ),
                  // ListTile(
                  //   title: Text('Get Tasks'),
                  //   leading: Icon(Icons.calendar_view_day),
                  //   trailing: Icon(Icons.info),
                  //   onTap: () async {
                  //     final todos = await Dgraph.getTodos();
                  //     todos.forEach((element) {
                  //       print(jsonEncode(element.toJson()));
                  //     });
                  //   },
                  // ),
                  ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.logout),
                    trailing: Icon(Icons.info),
                    onTap: () async {
                      await GetIt.I.get<UserService>().logOut();
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                  // ListTile(
                  //   title: Text('Sub Tasks'),
                  //   leading: Icon(Icons.subscriptions),
                  //   trailing: Icon(Icons.run_circle_outlined),
                  //   onTap: () async {
                  //     final stream = Dgraph.subTodos();

                  //     stream.listen((event) {
                  //       if (event.hasException) {
                  //         print('Exeption: ' + event.exception.toString());
                  //       }
                  //       if (event.isLoading) {
                  //         print('Event loading');
                  //       }
                  //       print(event.data);
                  //     }, onError: (e) {
                  //       print('Error while stream: ' + e.toString());
                  //     }, onDone: () {
                  //       print('Stream Done');
                  //     });
                  //   },
                  // ),
                  Container(
                    child: SelectableText(
                      logStr,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
