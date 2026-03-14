import 'package:flutter/material.dart';

/// Simple responsive helper that exposes three breakpoints: mobile, tablet, desktop.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static bool isMobile(BoxConstraints c) => c.maxWidth < 600;
  static bool isTablet(BoxConstraints c) =>
      c.maxWidth >= 600 && c.maxWidth < 1024;
  static bool isDesktop(BoxConstraints c) => c.maxWidth >= 1024;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isDesktop(constraints) && desktop != null) return desktop!;
        if (isTablet(constraints) && tablet != null) return tablet!;
        return mobile;
      },
    );
  }
}
