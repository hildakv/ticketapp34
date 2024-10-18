import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class CounterWidget extends StatefulWidget {
  int value;
  int maxValue;
  int minValue;
  Function(int) onChanged;

  CounterWidget(
      {required this.onChanged,
      this.maxValue = 99,
      this.minValue = 0,
      this.value = 0});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
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
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.secondary),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: InkWell(
                  onTap: () {
                    if (count > widget.minValue) {
                      setState(() {
                        --count;
                        controller.text = '$count';
                      });
                      widget.onChanged(count);
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 16,
                  ))),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3), color: Colors.white),
              child: Center(
                  child: Text(
                '${count}',
                style: TextStyle(color: Colors.black, fontSize: 16),
                //   FormBuilderTextField(
                // keyboardType: TextInputType.number,
                // name: '${count}',
                // style: TextStyle(color: Colors.black, fontSize: 16),
                // onTap: () {
                //   if (count < widget.maxValue) {
                //     setState(() {
                //       // ++count;
                //       controller.text = '$count';
                //     });
                //     widget.onChanged(count);
                //   }
                // },
              )),
              //   child: TextField(
              // keyboardType: TextInputType.number,
              // decoration: InputDecoration(
              //   border: OutlineInputBorder(),
              //   hintText: '',
              // ),
            ),
          ),
          Expanded(
              flex: 2,
              child: TextButton(
                  onPressed: () {
                    if (count < widget.maxValue) {
                      setState(() {
                        ++count;
                        controller.text = '$count';
                      });
                      widget.onChanged(count);
                    }
                  },
                  child: Center(
                    child: Text('+',
                        style: GoogleFonts.abel(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ))),
        ],
      ),
    );
  }
}
