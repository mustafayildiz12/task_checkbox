import 'package:flutter/material.dart';
import 'package:task_checkbox/task_detail_list.dart';

import 'top_task_category_model.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<TopTaskCategoryModel> taskList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ana Sayfa"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
            onPressed: () {
              setState(() {
                taskList.add(TopTaskCategoryModel(
                    title: "Task ${taskList.length}",
                    isChecked: false,
                    subTasks: [],
                    progressValue: 0));
              });
            },
            icon: const Icon(Icons.add)),
      ),
      body: taskList.isNotEmpty
          ? ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                TopTaskCategoryModel taskModel = taskList[index];
                return InkWell(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskDetailList(
                                  subTaskList: taskModel.subTasks,
                                ))).then((value) {
                      setState(() {
                        taskModel.subTasks = value;
                      });

                      int checkedSubTasks = taskModel.subTasks
                          .where((element) => element.isChecked == true)
                          .toList()
                          .length;

                      setState(() {
                        taskModel.progressValue =
                            checkedSubTasks / taskModel.subTasks.length;
                      });

                      // eğer progress 1 ise checki true yapıyoruz
                      if (taskModel.progressValue == 1) {
                        setState(() {
                          taskModel.isChecked = true;
                        });
                      }
                    });
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Checkbox(
                          value: taskModel.isChecked,
                          onChanged: (value) {
                            setState(() {
                              taskModel.isChecked = !taskModel.isChecked;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(child: Text(taskModel.title)),
                        CircleAvatar(
                            child: Text(
                                taskModel.progressValue.toStringAsFixed(2))),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text("Hiç görev eklemediniz"),
            ),
    );
  }
}
