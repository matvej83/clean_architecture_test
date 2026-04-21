import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
    this.counters,
    required this.selectedIndex,
    required this.onTap,
    this.barDecoration,
    this.useDifferentBorderForOuter = false,
    this.separator,
    this.barPadding,
    this.buttonPadding,
    this.buttonBorderRadius,
    this.buttonColor,
    this.selectedButtonColor,
    this.labelColor,
    this.selectedLabelColor,
    this.barBorderColor,
    this.useEqualsTabs = true,
    this.useScroll = false,
    this.separatorPadding,
    this.icons,
    this.fontSize,
    this.suffixIcons = const [],
  });

  final List<String> tabs;
  final List<String>? counters;
  final int selectedIndex;
  final void Function(int) onTap;
  final BoxDecoration? barDecoration;
  final bool useDifferentBorderForOuter;
  final Widget? separator;
  final EdgeInsets? barPadding;
  final EdgeInsets? buttonPadding;
  final double? buttonBorderRadius;
  final Color? buttonColor;
  final Color? selectedButtonColor;
  final Color? labelColor;
  final Color? selectedLabelColor;
  final Color? barBorderColor;
  final bool useEqualsTabs;
  final bool useScroll;
  final double? separatorPadding;
  final List<Widget>? icons;
  final List<Widget> suffixIcons;
  final double? fontSize;

  BorderRadiusGeometry getBorder(int index) {
    final borderRadius = buttonBorderRadius ?? 8;
    if (useDifferentBorderForOuter) {
      if (index == 0) {
        return BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
        );
      }
      if (index == tabs.length - 1) {
        return BorderRadius.only(
          topRight: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        );
      }
      return BorderRadius.circular(0);
    }
    return BorderRadius.circular(borderRadius);
  }

  @override
  Widget build(BuildContext context) {
    Widget row = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < tabs.length; i++) ...[
          useEqualsTabs
              ? Expanded(
                  child: CustomTab(
                    label: tabs[i],
                    counter: counters != null ? counters![i] : null,
                    icon: icons != null ? icons![i] : null,
                    buttonColor: selectedIndex == i
                        ? selectedButtonColor ?? const Color(0xFF222222)
                        : buttonColor ?? Colors.transparent,
                    labelColor: selectedIndex == i
                        ? selectedLabelColor ?? Colors.grey
                        : labelColor ?? const Color(0xFFA7A6AB),
                    onTap: () => onTap(i),
                    padding: buttonPadding,
                    borderRadius: getBorder(i),
                    fontSize: fontSize,
                    suffixIcon: suffixIcons.isNotEmpty ? suffixIcons[i] : null,
                  ),
                )
              : CustomTab(
                  label: tabs[i],
                  counter: counters != null ? counters![i] : null,
                  icon: icons != null ? icons![i] : null,
                  buttonColor: selectedIndex == i
                      ? selectedButtonColor ?? const Color(0xFF222222)
                      : buttonColor ?? Colors.transparent,
                  labelColor: selectedIndex == i
                      ? selectedLabelColor ?? Colors.grey
                      : labelColor ?? const Color(0xFFA7A6AB),
                  onTap: () => onTap(i),
                  padding: buttonPadding,
                  borderRadius: getBorder(i),
                  fontSize: fontSize,
                  suffixIcon: suffixIcons.isNotEmpty ? suffixIcons[i] : null,
                ),
          if (i != tabs.length - 1)
            separator ??
                Container(
                  width: 1,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF434343).withValues(alpha: 0),
                        const Color(0xFF434343),
                        const Color(0xFF434343).withValues(alpha: 0),
                      ],
                    ),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: separatorPadding ?? 4,
                  ),
                ),
        ],
      ],
    );

    if (useScroll) {
      row = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        child: row,
      );
    }

    return Container(
      width: double.infinity,
      padding: barPadding ?? const EdgeInsets.all(8),
      decoration:
          barDecoration ??
          BoxDecoration(
            color: const Color(0xFF191919),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: barBorderColor ?? const Color(0xFF222222),
            ),
          ),
      child: row,
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.label,
    this.counter,
    required this.onTap,
    required this.buttonColor,
    required this.labelColor,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.borderRadius,
    this.icon,
    this.suffixIcon,
  });

  final String label;
  final String? counter;
  final Color buttonColor;
  final Color labelColor;
  final VoidCallback onTap;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsets? padding;
  final BorderRadiusGeometry? borderRadius;
  final Widget? icon;
  final Widget? suffixIcon;

  Widget getContent(Widget labelWidget) {
    if (counter != null) {
      if (icon != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon!,
            Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                labelWidget,
                Text(
                  counter!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: labelColor,
                    height: 1.2,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ],
        );
      } else {
        return Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            labelWidget,
            Text(
              counter!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: labelColor,
                height: 1.2,
                letterSpacing: 0,
              ),
            ),
          ],
        );
      }
    } else {
      if (icon != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [icon!, labelWidget],
        );
      } else {
        if (suffixIcon != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4.0,
            children: [
              Flexible(child: labelWidget),
              suffixIcon!,
            ],
          );
        }
        return labelWidget;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final labelWidget = Text(
      label,
      textAlign: TextAlign.center,
      softWrap: false,
      style: TextStyle(
        fontSize: fontSize ?? 12,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: labelColor,
        height: 1.2,
        letterSpacing: 0,
        overflow: TextOverflow.fade,
      ),
    );

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding:
            padding ??
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: getContent(labelWidget),
      ),
    );
  }
}
