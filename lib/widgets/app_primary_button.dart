import 'package:flutter/material.dart';
import 'package:flutter_anim/config/app_colors.dart';
import 'dart:math' as Math;

///
/// Created by Auro on 20/09/23 at 1:48 AM
///

class AppPrimaryButton extends StatefulWidget {
  const AppPrimaryButton(
      {required this.child,
      Key? key,
      this.onPressed,
      this.height,
      this.width,
      this.color,
      this.shape,
      this.padding,
      this.radius,
      this.gradient = true,
      this.textStyle})
      : super(key: key);

  final ShapeBorder? shape;
  final Widget child;
  final VoidCallback? onPressed;
  final double? height, width, radius;
  final Color? color;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final bool gradient;

  @override
  AppPrimaryButtonState createState() => AppPrimaryButtonState();
}

class AppPrimaryButtonState extends State<AppPrimaryButton> {
  bool _isLoading = false;

  void showLoader() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _isLoading
        ? const AppProgress(color: AppColors.brightPrimary)
        : Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: widget.onPressed == null  ? const Color(0xffA1AAAD)  : widget.color ?? AppColors.brightPrimary,
              borderRadius: BorderRadius.circular(widget.radius ?? 30),
              gradient: null,
            ),
            child: ElevatedButton(
              // style: ButtonStyle(
              //   padding: MaterialStateProperty.all(
              //     widget.padding ??
              //         const EdgeInsets.symmetric(vertical: 14, horizontal: 48),
              //   ),
              //   textStyle: MaterialStateProperty.resolveWith(
              //       (Set<MaterialState> states) {
              //     if (states.contains(MaterialState.disabled))
              //       return TextStyle(color: Colors.grey.shade500);

              //     return TextStyle(color: AppColors.brightPrimary);
              //   }),
              //   foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              //     (Set<MaterialState> states) {
              //       if (states.contains(MaterialState.pressed))
              //         return AppColors.brightPrimary.shade800;
              //       else if (states.contains(MaterialState.disabled))
              //         return Colors.grey.shade500;
              //         return AppColors.brightPrimary;
              //     },
              //   )
              // ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: widget.padding ??
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                textStyle: widget.textStyle ??
                    const TextStyle(
                      fontSize: 16,
                      // fontFamily: Environment.fontFamily,
                      letterSpacing: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      // shadows: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.16),
                      //     offset: Offset(0, 2),
                      //     blurRadius: 3,
                      //     spreadRadius: 0,
                      //   )
                      // ],
                    ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 15),
                ),
              ),
              onPressed: widget.onPressed,
              child: widget.child,
            ),
          );
  }
}

class AppProgress extends StatefulWidget {
  final Color? color;
  final double? strokeWidth;
  final Size? size;

  const AppProgress(
      {Key? key, this.strokeWidth, this.color, this.size = const Size(50, 50)})
      : super(key: key);

  @override
  _AppProgressState createState() => _AppProgressState();
}

class _AppProgressState extends State<AppProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    this._controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    this._controller.repeat();
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.size,
      child: AspectRatio(
        aspectRatio: 1,
        child: AnimatedBuilder(
          animation: this._controller,
          builder: (ctx, child) => CustomPaint(
            child: Container(),
            foregroundPainter: _CircleProgressBarPainter(
                color: widget.color ?? Theme.of(context).primaryColor,
                percentage: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(CurvedAnimation(
                        curve: Curves.fastOutSlowIn, parent: _controller))
                    .value,
                strokeWidth: this.widget.strokeWidth),
          ),
        ),
      ),
    );
  }
}

class _CircleProgressBarPainter extends CustomPainter {
  final double? percentage;
  final double strokeWidth;
  final Color? color;

  _CircleProgressBarPainter({
    @required this.color,
    @required this.percentage,
    double? strokeWidth,
  }) : this.strokeWidth = strokeWidth ?? 6;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);

    final shortestSide = Math.min(size.width, size.height);
    final foregroundPaint = Paint()
      ..color = this.color!
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final radius = (shortestSide / 2) - ((this.strokeWidth) / 2).ceil();

    final double startAngle = 2 * Math.pi * (percentage ?? 0);

    final count = 8;
    final gapSize = 20;
    final double gap = Math.pi / 180 * gapSize;
    final double singleAngle = (Math.pi * 2) / count;

    final Paint paint = Paint()
      ..color = color!
      ..strokeWidth = strokeWidth - 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < count; i++) {
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          gap + singleAngle * i, singleAngle - gap * 2, false, paint);
    }
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      singleAngle - gap * 5,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as _CircleProgressBarPainter);
    return oldPainter.percentage != this.percentage;
  }
}
