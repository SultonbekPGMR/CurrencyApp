import 'package:flutter/cupertino.dart';

class ExpandableCardContainer extends StatefulWidget {
  final bool isExpanded;
  final Widget collapsedChild;
  final Widget expandedChild;

  const ExpandableCardContainer({
    required Key key,
    required this.isExpanded,
    required this.collapsedChild,
    required this.expandedChild,
  }) : super(key: key);

  @override
  State<ExpandableCardContainer> createState() =>
      _ExpandableCardContainerState();
}

class _ExpandableCardContainerState extends State<ExpandableCardContainer> {
  @override
  Widget build(BuildContext context) {
    return // In ExpandableCardContainer
      AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        key: ValueKey(widget.isExpanded),
        child: widget.isExpanded
            ? widget.expandedChild
            : widget.collapsedChild, // Force animation on state change
      );
  }
}
