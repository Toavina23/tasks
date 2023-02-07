import 'package:flutter/material.dart';

class AppSelect<T> extends StatelessWidget {
  final void Function(T?) _setSelected;
  final String _label;
  final String? Function(T?) _validator;
  final List<T> items;
  final String Function(T) _displayValue;
  const AppSelect(this._label, this._setSelected, this._validator, this.items,
      this._displayValue,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      validator: _validator,
      decoration: InputDecoration(
        label: Text(_label),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                _displayValue(item),
              ),
            ),
          )
          .toList(),
      onChanged: (selectedItem) {
        _setSelected(selectedItem);
      },
    );
  }
}
