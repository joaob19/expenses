import 'package:flutter/material.dart';

import 'adaptive_button.dart';
import 'adaptive_date_picker.dart';
import 'adaptive_text_field.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String title, double value, DateTime date) onSubmit;

  const TransactionForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;
    if (title.isEmpty || value == 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptiveTextField(
                controller: _titleController,
                labelText: 'Titulo',
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptiveTextField(
                controller: _valueController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                labelText: 'Valor (R\$)',
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptiveDatePicker(
                selectedDate: _selectedDate,
                onDateChange: _selectDate,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptiveButton(
                    onPressed: _submitForm,
                    label: 'Nova transação',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
