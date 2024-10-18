// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class CounterWidgetEx extends StatefulWidget {
  final int value;
  final int maxValue;
  final int minValue;
  final Color buttonColor;
  final Function(int) onChanged;

  CounterWidgetEx(
      {required this.onChanged,
      this.maxValue = 99,
      this.minValue = 0,
      this.value = 0,
      this.buttonColor = Colors.blue});

  @override
  State<CounterWidgetEx> createState() => _CounterWidgetExState();
}

class _CounterWidgetExState extends State<CounterWidgetEx> {
  int count = 0;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    count = widget.value;
    print("$count");
    controller.text = "$count";
  }

  @override
  Widget build(BuildContext context) {
    count = widget.value;
    controller.text = '$count';
    return KeyboardDismissOnTap(
      child: Container(
        padding: EdgeInsets.all(3),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(5),
        //     color: Theme.of(context).colorScheme.secondary),
        child: Row(
          children: [
            Expanded(
                flex: 5,
                child: TextButton(
                  style: TextButton.styleFrom(
                      // minimumSize: Size.fromWidth(50),
                      // fixedSize: Size(30, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: widget.buttonColor),
                  onPressed: () {
                    if (count > widget.minValue) {
                      setState(() {
                        --count;
                        controller.text = '$count';
                      });
                      widget.onChanged(count);
                    }
                  },
                  child: Center(
                    child: Text(" - ",
                        style: GoogleFonts.abel(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                )),
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3),
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white),
                child: Center(
                    child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  controller: controller,
                  onChanged: (value) {
                    print(
                        "----------------------------- onChanged : ${value} --------------->");
                    if (count < widget.maxValue && count != int.parse(value)) {
                      setState(() {
                        count = int.parse(controller.text);
                      });
                      widget.onChanged(count);
                    }
                  },
                  onEditingComplete: () {
                    print(
                        "-------------------------------onEditing completed --------------->");
                    if (count < widget.maxValue &&
                        count != int.parse(controller.text)) {
                      setState(() {
                        count = int.parse(controller.text);
                      });
                      widget.onChanged(count);
                    }
                  },
                )),
              ),
            ),
            Expanded(
                flex: 5,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      print("--------------------------> ");
                      if (count < widget.maxValue) {
                        setState(() {
                          ++count;
                          controller.text = '$count';
                        });
                        widget.onChanged(count);
                      }
                    },
                    child: Center(
                      child: Text(' + ',
                          style: GoogleFonts.abel(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ))),
            // Expanded(
            //     flex: 4,
            //     child: Container(
            //         color: Colors.blue.shade100,
            //         padding: EdgeInsets.all(2),
            //         child: Center(
            //           child: IconButton(
            //             color: Colors.amber,
            //             iconSize: 25,
            //             icon: Icon(Icons.add),
            //             onPressed: () {
            //               if (count < widget.maxValue) {
            //                 setState(() {
            //                   ++count;
            //                   controller.text = '$count';
            //                 });
            //                 widget.onChanged(count);
            //               }
            //             },
            //           ),
            //         ))),
          ],
        ),
      ),
    );
  }
}
