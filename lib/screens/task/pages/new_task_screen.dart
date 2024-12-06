import 'package:fb_taskmanager/screens/task/cubit/task_cubit.dart';
import 'package:fb_taskmanager/screens/task/model/task_model.dart';
import 'package:fb_taskmanager/screens/task/pages/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  static const String path = '/new_task';

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  final DateFormat _dateFromat = DateFormat('dd MMMM yyyy');

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  void setData(DateTime date) => setState(() => _selectedDate = date);

  bool get canSave =>
      _titleController.text.isNotEmpty &&
      _descriptionController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go(TaskScreen.path),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Новая задача'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              if (!canSave) {
                const SnackBar(
                  content: Text('Ошибка'),
                );
                return;
              }

              final newTask = TaskModel(
                title: _titleController.text,
                description: _descriptionController.text,
                dueDate: _selectedDate,
              );

              TaskCubit.i(context).createTask(newTask);
              context.go(TaskScreen.path);
            },
            icon: const Icon(Icons.check),
            color: Colors.green,
          )
        ],
      ),
      body: ListView(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(label: Text('Имя задачи')),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(label: Text('Описание задачи')),
          ),
          ListTile(
            leading: IconButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
              },
              icon: const Icon(Icons.calendar_month),
            ),
            title: const Text('Дата выполнения: '),
            subtitle: Text(_dateFromat.format(_selectedDate)),
          )
        ],
      ),
    );
  }
}
