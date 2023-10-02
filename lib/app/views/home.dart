import 'package:flutter/material.dart';
import 'package:habit_tracker/app/components/my_alert_box.dart';
import 'package:habit_tracker/app/components/habit_tile.dart';
import 'package:habit_tracker/app/components/my_floating_action_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List habitList = [
    ['Morning run', false],
    ['Read book', false],
    ['Code app', false],
  ];

  void changedBoxTapped(bool? value, int index) {
    setState(() {
      habitList[index][1] = value;
    });
  }

  final _newHabitController = TextEditingController();
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          hintText: 'New Habit',
          controller: _newHabitController,
          onSave: saveHabit,
          onCancel: canelDialogBox,
        );
      },
    );
  }

  void saveHabit() {
    setState(() {
      habitList.add([_newHabitController.text, false]);
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  void canelDialogBox() {
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          hintText: habitList[index][0],
          controller: _newHabitController,
          onSave: () => saveExistingHabit(index),
          onCancel: canelDialogBox,
        );
      },
    );
  }

  void saveExistingHabit(int index) {
    setState(() {
      habitList[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  void deleteHabit(int index) {
    setState(() {
      habitList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(
        onPressed: () => createNewHabit(),
      ),
      backgroundColor: Colors.grey[300],
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: habitList[index][0],
            habitCompleted: habitList[index][1],
            onChanged: (value) => changedBoxTapped(value, index),
            settingsTapped: (context) => openHabitSettings(index),
            deleteTapped: (context) => deleteHabit(index),
          );
        },
      ),
    );
  }
}
