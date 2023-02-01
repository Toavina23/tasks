import 'package:flutter/material.dart';

class AppTextArea extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;
  final String? Function(String?) _validator;
  const AppTextArea(this._label, this._controller, this._validator,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      minLines: 2,
      maxLines: 4,
      controller: _controller,
      validator: _validator,
      decoration: InputDecoration(
        label: Text(_label),
      ),
    );
  }
}
