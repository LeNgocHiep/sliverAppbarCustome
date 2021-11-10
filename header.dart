import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:safetysigning/src/app/theme/theme_primary.dart';

class HeaderWidget extends StatefulWidget {
  final Widget title;
  final List<Widget> actions;
  final Widget child;
  final double height;

  const HeaderWidget(
      {Key key,
      this.title,
      this.actions,
      this.child,
      this.height})
      : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  // bool isLoginFormEnabled = false;

  @override
  void didUpdateWidget(covariant HeaderWidget oldWidget) {
    // TODO: implement didUpdateWidget
    if (oldWidget.height != widget.height) setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentWidget(
        widget.height, widget.title, widget.actions, widget.child);
  }
}

class ContentWidget extends StatelessWidget {
  final double height;
  final Widget title;
  final List<Widget> actions;
  final Widget child;

  ContentWidget(this.height, this.title, this.actions, this.child);

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(ThemePrimary.primaryColor);
    return SafeArea(
        child: CustomPaint(
            painter: ContentClipperCustom(),
            child: ClipPath(
              clipper: ContentClipper(), //my CustomClipper
              child: Container(
                height: height > 56.0 ? height : 56.0,
                child: Column(
                  children: [
                    Container(
                      height: 56.0,
                      color: ThemePrimary.primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context)),
                          Expanded(child: title),
                          ...actions
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                          color: ThemePrimary.primaryColor,
                          child: (height > 190)
                              ? child
                              : SingleChildScrollView(
                                  child: Container(
                                    height: 190 - 56.0,
                                    child: child,
                                  ),
                                )),
                    )
                  ],
                ),
              ), // my widgets inside
            )));
  }
}

double handleHeight(double height, double heightDefault) {
  return height > heightDefault ? height : heightDefault;
}

class ContentClipperCustom extends CustomPainter {
  ContentClipperCustom();

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    final heightDefault = 56.0;
    path.lineTo(0, handleHeight(size.height * 0.83, heightDefault));
    path.lineTo(
        size.width * 0.7, handleHeight(size.height * 0.98, heightDefault));
    path.cubicTo(
        size.width * 0.8,
        handleHeight(size.height, heightDefault),
        size.width * 0.87,
        handleHeight(size.height * 0.94, heightDefault),
        size.width,
        handleHeight(size.height * 0.83, heightDefault));
    path.lineTo(size.width, 0);
    // return path;
    canvas.drawShadow(path, Colors.black45, 3.0, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ContentClipper extends CustomClipper<Path> {
  ContentClipper();

  @override
  Path getClip(Size size) {
    Path path = Path();
    final heightDefault = 56.0;
    path.lineTo(0, handleHeight(size.height * 0.83, heightDefault));
    path.lineTo(
        size.width * 0.7, handleHeight(size.height * 0.98, heightDefault));
    path.cubicTo(
        size.width * 0.8,
        handleHeight(size.height, heightDefault),
        size.width * 0.87,
        handleHeight(size.height * 0.94, heightDefault),
        size.width,
        handleHeight(size.height * 0.83, heightDefault));
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
