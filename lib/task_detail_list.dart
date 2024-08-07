// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'top_task_category_model.dart';

class TaskDetailList extends StatefulWidget {
  const TaskDetailList({
    super.key,
    required this.subTaskList,
  });

  final List<SubTaskCategoryModel> subTaskList;

  @override
  State<TaskDetailList> createState() => _TaskDetailListState();
}

class _TaskDetailListState extends State<TaskDetailList> {
  List<SubTaskCategoryModel> taskList = [];

  @override
  void initState() {
    setState(() {
      taskList = widget.subTaskList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, taskList);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text("Detay Sayfası"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
            onPressed: () {
              setState(() {
                taskList.add(SubTaskCategoryModel(
                  title: "Detail Task ${taskList.length}",
                  isChecked: false,
                ));
              });
            },
            icon: const Icon(Icons.add)),
      ),
      body: taskList.isNotEmpty
          ? ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                SubTaskCategoryModel taskModel = taskList[index];
                return InkWell(
                  onTap: () {},
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
                        Text(taskModel.title),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text("Hiç görev detayı eklemediniz"),
            ),
    );
  }

  int getCheckedTaskCount() {
    int checkedCount = 0;

    int value =
        taskList.where((element) => element.isChecked == true).toList().length;

    checkedCount = value;
    return checkedCount;
  }
}
