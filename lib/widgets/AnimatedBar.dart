import 'package:flutter/material.dart';
import '../constants/colors.dart';

class IconModel {
  final int id;
  final IconData icon;

  IconModel({required this.id, required this.icon});
}

class AnimatedBar extends StatelessWidget {
  final int currentIcon;
  final List<IconModel> icons;
  final ValueChanged<int>? onTabTap;

  const AnimatedBar({
    required this.currentIcon,
    required this.icons,
    required this.onTabTap,
    super.key,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: blacks,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: icons.map((icon) {
            final isSelected = currentIcon == icon.id;
            return GestureDetector(
              onTap: () => onTabTap?.call(icon.id),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Icon(
                  icon.icon,
                  size: isSelected ? 26 : 20,
                  color: isSelected ? yellows : backGroundClr,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
