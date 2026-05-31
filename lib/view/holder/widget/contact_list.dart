import 'package:card_swift/view/holder/widget/visiting_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/card_list_controller.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CardListController());

    return Obx(() {
      if (controller.isListLoading.value && controller.allCards.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (controller.allCards.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("No business cards saved yet."),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.allCards.length,
        separatorBuilder: (_, _) => const Divider(),
        itemBuilder: (_, index) {
          final cardModel = controller.allCards[index];

          return VisitingCard(contact: cardModel);
        },
      );
    });
  }
}
