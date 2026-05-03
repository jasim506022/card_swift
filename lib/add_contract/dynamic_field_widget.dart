
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/widget/custom_text_form_field.dart';

class DynamicFieldWidget extends StatelessWidget {
  final String title;
  final RxList<TextEditingController> controllers; // 🔥 change here
  final VoidCallback onAdd;
  final Function(int) onRemove;
  final TextInputType keyboard;

  const DynamicFieldWidget({
    super.key,
    required this.title,
    required this.controllers,
    required this.onAdd,
    required this.onRemove,
    required this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Row(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add_circle, color: Colors.green),
            ),
          ],
        ),

        /// 🔥 Only this part reactive
        Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controllers.length, // Rx used here
          itemBuilder: (context, i) {
            return Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    hintText: "$title ${i + 1}",
                    controller: controllers[i],
                    textInputType: keyboard,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () => onRemove(i),
                ),
              ],
            );
          },
        )),
      ],
    );
  }
}

