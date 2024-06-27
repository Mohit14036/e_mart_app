import 'package:flutter/material.dart';

class AvaliableOption extends StatefulWidget {

  final String option;
  const AvaliableOption({Key? key,required this.option}):super(key: key);
  @override
  State<AvaliableOption> createState() => _AvaliableOptionState();
}

class _AvaliableOptionState extends State<AvaliableOption> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: (){
      setState(() {
        isSelected= !isSelected;
      });
    },
    child: Container(
        margin: const EdgeInsets.only(right: 16.0),
      width: 50,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected?Colors.red:Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.red)
      ),
      child: Text(widget.option,style: const TextStyle(fontWeight: FontWeight.bold),),
    ),
  );
}
