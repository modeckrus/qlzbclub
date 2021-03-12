import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class TodoPage extends StatefulWidget {
  const TodoPage(): super();
  @override
  _TodoPageState createState() => _TodoPageState();
}
class _TodoPageState extends State<TodoPage> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        actions: [IconButton(icon: Icon(Icons.clear_all), onPressed: () {})],
      ),
      body: const TodoBody(),
    ));
  }
}

class TodoBody extends StatefulWidget {
  const TodoBody():super();
  @override
  _TodoBodyState createState() => _TodoBodyState();
}

class _TodoBodyState extends State<TodoBody> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QueryResult>(
        // stream: Dgraph.subTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Icon(Icons.error);
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final result = snapshot.data;
          if(result == null){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (result.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (result.hasException) {
            print(result.exception);
            return Icon(Icons.error);
          }
          if(result.isConcrete){
          if(result.data['queryUser'] == null || (result.data['queryUser'] as List).length == 0){
            return Column(
              children: [
                Container(
                alignment: Alignment.center,
                child: TextFormField(
                  controller: _titleController,
                  onFieldSubmitted: (text) {
                    // Dgraph.createTodo(text).then((e) {
                    //   Dgraph.graph.cache.store.reset();
                    //   setState(() {});
                    // });
                  },
                  decoration:
                      InputDecoration(labelText: 'Что должно быть сделанно'),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text('Нет записей'),
              )
              ],
            );
          }
          final rtasks = result.data['queryUser'][0]['tasks'] as List<dynamic>;
          // final List<Task> todos = [];
          // rtasks.forEach((element) {
          //   final task = Task.fromJson(element as Map<String, dynamic>);
          //   todos.add(task);
          // });
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: TextFormField(
                  controller: _titleController,
                  onFieldSubmitted: (text) {
                    // Dgraph.createTodo(text).then((e) {
                    //   Dgraph.graph.cache.store.reset();
                    //   setState(() {
                    //     _titleController.text = '';
                    //   });
                    // });
                  },
                  decoration:
                      InputDecoration(labelText: 'Что должно быть сделанно'),
                ),
              ),
              Expanded(
                  child: CupertinoScrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    // final todo = todos[index];
                    return ListTile(
                      // leading: todo.completed
                      //     ? IconButton(icon:Icon(Icons.close), onPressed: (){
                      //       // Dgraph.uncompleteTodo(todo.id);
                      //     },)
                      //     : IconButton(icon:Icon(Icons.check), onPressed: (){
                      //       // Dgraph.completeTodo(todo.id);
                      //     },),
                      // title: Text(todo.title, style: todo.completed? TextStyle(
                      //   decoration: TextDecoration.lineThrough
                      // ):TextStyle(), ),
                      // trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
                      //   // Dgraph.deleteTodo(todo.id);
                      // },),
                    );
                  },
                  // itemCount: todos.length,
                ),
              ))
            ],
          );
          }
          return Container(
            child: Text('WTF'),
          );
        });
  }
}
