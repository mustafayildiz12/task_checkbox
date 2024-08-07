class TopTaskCategoryModel {
  bool isChecked;
  double progressValue;
  List<SubTaskCategoryModel> subTasks;
  String title;

  TopTaskCategoryModel(
      {required this.isChecked,
      required this.progressValue,
      required this.subTasks,
      required this.title});
}

class SubTaskCategoryModel {
  bool isChecked;
  String title;

  SubTaskCategoryModel({required this.isChecked, required this.title});
}
