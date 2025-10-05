import 'package:flutter/material.dart';
import 'package:qube_project/utils/const.dart';

class GradientPoint extends StatelessWidget {
  const GradientPoint({
    this.isFilled = true,
    super.key,
  });

  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => qubeGradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: switch (isFilled) {
        true => const CircleAvatar(radius: gradientPointSize / 2),
        false => Container(
          height: gradientPointSize,
          width: gradientPointSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(),
          ),
        ),
      },
    );
  }
}
