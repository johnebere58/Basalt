
import 'package:basalt/basalt.dart';

class ImageIconWidget extends StatelessWidget {
  final dynamic icon;
  final double size;
  final Color color;
  final bool ignoreWidth;
  const ImageIconWidget(this.icon, this.size, this.color, {this.ignoreWidth = false,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon is IconData
        ? Icon(
      icon,
      size: size,
      color: color,
    )
        : Image.asset(
      icon,
      width: ignoreWidth ? null : size,
      height: size,
      color: color,
    );
  }
}
