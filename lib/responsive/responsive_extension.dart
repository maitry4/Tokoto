import 'package:tokoto/responsive/size_config.dart';

extension GetHeight on int {
  double sh() {
    return (SizeConfig.safeBlockVertical ?? 0.0) * this;
  }

  double sr() {
    return 0.9 * sh().clamp(0.0, sw());
  }

  double sw() {
    return (SizeConfig.safeBlockHorizontal ?? 0.0) * this;
  }
}