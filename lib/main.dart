import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/controller/bloc/task_bloc.dart';

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Home Page'),
      ),
      body: BlocProvider(
        create: (context) => TaskBloc(),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(hint: const Text('Enter a Task')),
                ),

                ElevatedButton(
                  onPressed: () {
                    context.read<TaskBloc>().add(
                      AddTaskEvent(_textEditingController.text),
                    );
                    _textEditingController.clear();
                  },
                  child: const Text('Add Task'),
                ),

                // List View
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      title: Text(state.taskList[index].title),
                      leading: Checkbox(
                        value: state.taskList[index].isCompleted,
                        onChanged: (value) {
                          context.read<TaskBloc>().add(
                            ToggleEvent(state.taskList[index].id),
                          );
                        },
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          context.read<TaskBloc>().add(
                            RemoveTaskEvent(state.taskList[index].id),
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                    itemCount: state.taskList.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
