import 'package:flutter/material.dart';

import '../../domain/entity/report.dart';

class AddReportDialog extends StatefulWidget {
  const AddReportDialog({Key? key}) : super(key: key);

  @override
  State<AddReportDialog> createState() => _AddReportDialogState();
}

class _AddReportDialogState extends State<AddReportDialog> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String server = '';
  bool isOk = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Tytuł'),
                validator: (value) => value?.isNotEmpty == true ? null : 'Pola nie może być puste',
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'Opis'),
                validator: (value) => value?.isNotEmpty == true ? null : 'Pola nie może być puste',
              ),
              DropdownButtonFormField<String>(
                  validator: (value) => value?.isNotEmpty == true ? null : 'Pola nie może być puste',
                  decoration: InputDecoration(hintText: 'Server'),
                  items: ['127.0.1', 'localhost:8080', 'google.pl']
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    server = (value ?? '');
                  }),
              CheckboxListTile(
                title: Text('Czy jest dobrze?'),
                value: isOk,
                onChanged: (value) {
                  setState(() {
                    isOk = value == true;
                  });
                },
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() == true) {
                    final title = titleController.text;
                    final description = descriptionController.text;
                    final date = DateTime.now();
                    final report = Report(
                      title: title,
                      date: date,
                      description: description,
                      isOk: isOk,
                      server: server,
                      id: -1,
                    );
                    Navigator.of(context).pop(report);
                  }
                },
                child: Text('Zatwierdź'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
