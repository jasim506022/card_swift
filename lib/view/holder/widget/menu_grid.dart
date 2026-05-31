import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/menu_model.dart';
import 'menu_grid_item.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      // why use ShrinkWrap
      itemCount: menuItems.length,
      physics: const NeverScrollableScrollPhysics(),
      // prevents scroll conflict
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 25.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return MenuGridItem(menuItem: item);
      },
    );
  }
}
