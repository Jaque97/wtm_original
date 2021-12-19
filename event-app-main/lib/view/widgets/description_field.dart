import 'package:flutter/material.dart';

class DescriptionField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscure;
  final bool enable;
  final bool textAlignCenter;
  final int maxLines;
  final focusNode;

  DescriptionField(
      {this.focusNode,
      this.hint,
      this.icon,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.obscure = false,
      this.enable = true,
      this.textAlignCenter = false,
      this.maxLines});

  @override
  _DescriptionFieldFieldState createState() => _DescriptionFieldFieldState();
}

class _DescriptionFieldFieldState extends State<DescriptionField> {
  bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode ?? null,
      maxLines: widget.maxLines,
      enabled: widget.enable,
      controller: widget.controller,
      textAlign:
          widget.textAlignCenter == true ? TextAlign.center : TextAlign.start,
      style: TextStyle(color: Theme.of(context).accentColor, fontSize: 14),
      keyboardType: widget.keyboardType,
      obscureText: widget.obscure ? obscure : widget.obscure,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
        // filled: true,
        // fillColor: const Color(0xfffafafa),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.0),
          borderSide: BorderSide(width: 1.0, color: Colors.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.0),
          borderSide: BorderSide(width: 1.0, color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.0),
          borderSide: BorderSide(width: 1.0, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.0),
          borderSide: BorderSide(width: 1.0, color: Colors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.0),
          borderSide: BorderSide(width: 1.0, color: Colors.transparent),
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.width * 0.5,
          maxWidth: MediaQuery.of(context).size.width * 0.5,
        ),
        prefixIcon: widget.icon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        widget.icon,
                        color: IconTheme.of(context).color,
                      ),
                    ),
                  ),
                ),
              )
            : null,
        suffixIcon: !widget.obscure
            ? null
            : IconButton(
                icon: Icon(
                  obscure ? Icons.visibility : Icons.visibility_off,
                  color: IconTheme.of(context).color,
                ),
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
              ),
      ),
    );
  }
}
