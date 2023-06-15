import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:to_do/constants/constants.dart';
import 'package:to_do/utils/localizations.dart';
import '../models/global.dart';
import '../models/task.dart';

class AddTask extends StatefulWidget {
  final Task? task;
  final Function(int)? deleteTask;
  const AddTask({super.key, this.task, this.deleteTask});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  String _importance = 'none';
  late bool _deadlineExist;
  late DateTime _selectedDate;

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  void initState() {
    _deadlineExist = widget.task?.deadline != null;
    _selectedDate = widget.task?.deadline ?? DateTime.now();
    _titleController.text = widget.task?.title ?? '';
    _importance = widget.task?.importance ?? 'none';
    super.initState();
  }

  void _changeSelected(String imp) {
    setState(() {
      _importance = imp;
    });
  }

  void _toggleDeadline() {
    setState(() {
      _deadlineExist = !_deadlineExist;
    });
  }

  Future<void> _confirmDelete() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: AppConstants.backSecondary(context),
          content: Container(
            height: 170,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)?.translate('confirm') ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)?.translate('no') ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppConstants.blue(context),
                            ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.deleteTask!(widget.task!.id);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)?.translate('yes') ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppConstants.red(context),
                            ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String formatDate(String inputDate) {
    final parsedDate = DateFormat('dd MM yyyy').parse(inputDate);
    final formattedDate = DateFormat('dd MMMM yyyy', 'ru').format(parsedDate);
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
                if (widget.task?.id == null) {
                  Globals().increaseCount();
                }
                final task = Task(
                  id: widget.task?.id ?? Globals().count,
                  title: _titleController.text,
                  importance: _importance,
                  deadline: _deadlineExist ? _selectedDate : null,
                  status: widget.task?.status ?? 'in doing',
                );
                logger.d('Saved task: ${task.title}');
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
                    title(),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    importance(),
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
              delete(),
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    //TODO: Сделать TextField растягивающимся
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppConstants.backSecondary(context),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextField(
        controller: _titleController,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)?.translate('obscure'),
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppConstants.tertiary(context),
              ),
          border: InputBorder.none,
        ),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget importance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)?.translate('importance') ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
              ),
        ),
        PopupMenuButton(
          initialValue: AppLocalizations.of(context)?.translate(_importance),
          itemBuilder: (context) {
            return [
              item(AppLocalizations.of(context)?.translate('none') ?? '',
                  'none'),
              item(AppLocalizations.of(context)?.translate('low') ?? '', 'low'),
              item(AppLocalizations.of(context)?.translate('high') ?? '',
                  'high'),
            ];
          },
          onSelected: (value) => _changeSelected(value),
          icon: Text(
            (AppLocalizations.of(context)?.translate(_importance)) ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: _importance == 'high'
                      ? AppConstants.red(context)
                      : AppConstants.tertiary(context),
                ),
          ),
          padding: const EdgeInsets.only(left: 0),
          color: AppConstants.backElevated(context),
        ),
      ],
    );
  }

  PopupMenuItem item(String title, String imp) {
    return PopupMenuItem<String>(
      value: imp,
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: imp == 'high'
                  ? AppConstants.red(context)
                  : AppConstants.primary(context),
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
          // trackColor:
          //     MaterialStateProperty.all<Color>(AppConstants.overlay(context)),
          thumbColor: MaterialStateProperty.all(_deadlineExist
              ? AppConstants.blue(context)
              : AppConstants.backElevated(context)),
          inactiveTrackColor: AppConstants.overlay(context),
        ),
      ],
    );
  }

  Widget delete() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              await _confirmDelete();
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: AppConstants.red(context),
                    size: 25,
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Text(
                    AppLocalizations.of(context)?.translate('delete') ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppConstants.red(context),
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
