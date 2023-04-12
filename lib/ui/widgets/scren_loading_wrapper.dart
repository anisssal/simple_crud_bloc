import 'package:flutter/material.dart';

import '../../utils/res_color.dart';
import '../../utils/size_config.dart';
import 'loading_ring.dart';

class ScreenLoadingWrapper extends StatelessWidget {
  const ScreenLoadingWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12.withOpacity(0.8),
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: const SpinKitRing(
        color: ResColor.colorPrimaryShades,
      ),
    );
  }
}
