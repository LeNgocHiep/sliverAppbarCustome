import 'dart:async';
import 'package:flutter/material.dart';
import 'header.dart';

class SliverAppbarCustom extends StatefulWidget {
  final double height;
  final Widget child;
  final Widget title;
  final List<Widget> actions;
  final Widget body;

  const SliverAppbarCustom(
      {Key key, this.height, this.title, this.actions, this.body, this.child})
      : super(key: key);

  @override
  _SliverAppbarCustomState createState() => _SliverAppbarCustomState();
}

class _SliverAppbarCustomState extends State<SliverAppbarCustom> {
  ScrollController scrollController = ScrollController();
  StreamController streamHeight = StreamController<double>();

  @override
  void initState() {
    scrollController.addListener(() {
      streamHeight.sink.add(widget.height - scrollController.offset);
      print(scrollController.offset);
    });
    super.initState();
  }

  @override
  void dispose() {
    streamHeight?.close();
    scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            ListView(
              controller: scrollController,
              children: [
                Container(
                  margin: EdgeInsets.only(top: widget.height),
                  child: widget.body,
                )
              ],
            ),
            StreamBuilder(
                stream: streamHeight.stream,
                initialData: widget.height,
                builder: (context, snapshot) {
                  return HeaderWidget(
                    height: snapshot.data,
                    title: widget.title,
                    child: widget.child,
                    actions: widget.actions??[],
                  );
                })
          ],
        ),
      ),
    );
  }
}
