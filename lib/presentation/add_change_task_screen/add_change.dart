import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/constants/constants.dart';
import 'package:to_do/utils/localizations.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/task.dart';
import 'widgets/task_delete.dart';
import 'widgets/task_importance.dart';
import 'widgets/task_title.dart';

class AddTask extends StatefulWidget {
  final Task? task;
  const AddTask({super.key, this.task});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  Priority _importance = Priority.basic;
  late bool _deadlineExist;
  late DateTime _selectedDate;
  bool _isAdding = false;

  @override
  void initState() {
    _deadlineExist = widget.task?.deadline != null;
    _selectedDate = widget.task?.deadline ?? DateTime.now();
    _titleController.text = widget.task?.title ?? '';
    _importance = widget.task?.importance ?? Priority.basic;
    if (widget.task == null) {
      setState(() {
        _isAdding = true;
      });
    }
    super.initState();
  }

  void _changeSelected(String imp) {
    setState(() {
      if (imp == 'important') {
        _importance = Priority.important;
        return;
      }
      if (imp == 'low') {
        _importance = Priority.low;
        return;
      }
      _importance = Priority.basic;
    });
  }

  void _toggleDeadline() {
    setState(() {
      _deadlineExist = !_deadlineExist;
    });
  }

  String formatDate(String inputDate) {
    final parsedDate = DateFormat('dd MM yyyy').parse(inputDate);
    final formattedDate = DateFormat(
      'dd MMMM yyyy',
      Localizations.localeOf(context).languageCode,
    ).format(parsedDate);
    return formattedDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            cardColor: AppConstants.blue(context),
            primaryColor: AppConstants.backPrimary(context),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.backPrimary(context),
          surfaceTintColor: AppConstants.backPrimary(context),
          leading: IconButton(
            icon: Icon(
              Icons.close_rounded,
              size: 30,
              color: AppConstants.primary(context),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final task = Task(
                  id: widget.task?.id ?? const Uuid().v4(),
                  title: _titleController.text,
                  importance: _importance,
                  deadline: _deadlineExist ? _selectedDate : null,
                  isCompleted: widget.task?.isCompleted ?? false,
                );
                Navigator.pop(context, task);
              },
              child: Text(
                AppLocalizations.of(context)?.translate('save') ?? '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppConstants.blue(context),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskTitle(titleController: _titleController),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    TaskImportance(
                      importance: _importance,
                      changeSelected: _changeSelected,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: AppConstants.separator(context),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    deadline(),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Container(
                width: double.infinity,
                height: 1,
                color: AppConstants.separator(context),
              ),
              TaskDelete(
                task: widget.task,
                isAdding: _isAdding,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget deadline() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.translate('doneTill') ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                  ),
            ),
            _deadlineExist
                ? TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero)),
                    onPressed: () => _selectDate(context),
                    child: Text(
                      formatDate(
                          '${_selectedDate.day} ${_selectedDate.month} ${_selectedDate.year}'),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppConstants.blue(context),
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : Container(),
          ],
        ),
        Switch(
          value: _deadlineExist,
          onChanged: (value) => _toggleDeadline(),
          activeColor: AppConstants.blue(context),
          thumbColor: MaterialStateProperty.all(_deadlineExist
              ? AppConstants.blue(context)
              : AppConstants.backElevated(context)),
          inactiveTrackColor: AppConstants.overlay(context),
        ),
      ],
    );
  }
}
