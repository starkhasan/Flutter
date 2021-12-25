import 'package:flutter/material.dart';

class PageViewLabelIndicator extends StatefulWidget {
  final double? labelFontSize;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;
  final MainAxisAlignment? mainAxisAlignment;
  final double? height;
  final ValueNotifier<int> currentPageNotifier;
  final List<String> label;
  const PageViewLabelIndicator({ 
    Key? key,
    required this.currentPageNotifier,
    required this.label,
    this.height,
    this.mainAxisAlignment,
    this.backgroundColor,
    this.unselectedColor,
    this.selectedColor,
    this.labelFontSize
  }) : super(key: key);

  @override
  _PageViewLabelIndicatorState createState() => _PageViewLabelIndicatorState();
}

class _PageViewLabelIndicatorState extends State<PageViewLabelIndicator> {

  int currentPageIndex = 0;

  @override
  void initState() {
    widget.currentPageNotifier.addListener(_handleLabelListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.currentPageNotifier.removeListener(_handleLabelListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Colors.white,
      height: widget.height ?? MediaQuery.of(context).size.height * 0.05,
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: List.generate(widget.label.length, (index) => Text(
          widget.label[index],
          style: TextStyle(
            fontSize: widget.labelFontSize ?? 14,
            color: currentPageIndex == index 
            ? widget.selectedColor ?? Colors.blue 
            : widget.unselectedColor ?? Colors.grey,
            fontWeight: FontWeight.bold
            )
          )
        )
      )
    );
  }

  _handleLabelListener() {
    setState(_readCurrentPageIndex);
  }

  _readCurrentPageIndex() {
    currentPageIndex = widget.currentPageNotifier.value;
  }
}