import 'package:flutter/material.dart';
import 'package:todooo/utils/app_string.dart';

class repTextField extends StatelessWidget {
  const repTextField({
    super.key,
    required this.controller,
    this.isForDescription = false,
  });

  final TextEditingController controller;
  final bool isForDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: TextFormField(
          controller: controller,
          maxLines: !isForDescription ? 6 : null,
          cursorHeight: isForDescription ? 30 : null,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: isForDescription ? AppString.addNote : null,
            border: isForDescription ? InputBorder.none : null,
            counter: Container(),
            prefixIcon: isForDescription
                ? Icon(
                    Icons.bookmark_border,
                    color: Colors.grey,
                  )
                : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
          ),
          onFieldSubmitted: (value) {},
          onChanged: (value) {},
        ),
      ),
    );
  }
}
