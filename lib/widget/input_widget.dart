import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/24 16:44
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述
class InputWidget extends StatefulWidget {
  String lable;
  String? text;
  int? maxLength;
  int? maxLines;
  int? minLines;
  Icon icon;
  double? maxWidth;
  double? minWidth;
  double? radius;
  ValueChanged<String>? onChanged;
  ValueChanged<String>? afterEdit;

  InputWidget({
    Key? key,
    required this.lable,
    this.text,
    this.maxWidth,
    this.minWidth,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.radius,
    required this.icon,
    this.onChanged,
    this.afterEdit,
  }) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  var _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
      if (!_focusNode.hasFocus) {
        widget.afterEdit!(_controller.text);
      }
    });
    _controller.text = widget.text ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth ?? double.infinity,
        minWidth: widget.minWidth ?? double.infinity,
      ),
      child: TextField(
        focusNode: _focusNode,
        controller: _controller,
        cursorColor: Theme.of(context).colorScheme.inversePrimary,
        style: TextStyle(
            fontSize: 14, color: Theme.of(context).colorScheme.inversePrimary),
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          filled: false,
          focusColor: Theme.of(context).colorScheme.inversePrimary,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
          icon: widget.icon,
          iconColor: _hasFocus
              ? Theme.of(context).primaryColor
              : Theme.of(context).colorScheme.inversePrimary,
          labelText: widget.lable,
          labelStyle: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.inversePrimary),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radius ?? 30),
            ),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radius ?? 30),
            ),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        onChanged: widget.onChanged,
        autofocus: false,
      ),
    );
  }
}
