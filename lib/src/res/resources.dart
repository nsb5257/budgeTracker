import 'package:flutter/cupertino.dart';
import 'colors/app_colors.dart';
import 'dimensions/app_dimensions.dart';
import 'drawable/app_drawables.dart';
import 'strings/strings.dart';
import 'style/app_style.dart';


class Resources {

  final BuildContext _context;
  Resources(this._context);

  Strings? get strings {
    return Localizations.of<Strings>(_context, Strings);
  }

  AppColors get color {
    return AppColors();
  }

  AppDimension get dimension {
    return AppDimension();
  }

  AppStyle get style {
    return AppStyle();
  }

  AppDrawable get drawable {
    return AppDrawable();
  }

  static Resources of(BuildContext context){
    return Resources(context);
  }
}