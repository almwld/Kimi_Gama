import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  final double size;
  
  const LoadingWidget({
    super.key,
    this.color,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppTheme.goldColor,
          ),
          strokeWidth: 3,
        ),
      ),
    );
  }
}
