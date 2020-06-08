import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/resources/localization.dart';
import 'package:devkit/app/ui/widgets/basic/text_widget.dart';
import 'package:devkit/commons/global/show_description.dart';
import 'package:flutter/material.dart';

enum MenuItem {
  share,
  switchDescription,
  personalizationConfigs,
  personalizationImport,
  personalizationExport,
}

class Menu {
  static PopupMenuButton popupDescription() {
    return PopupMenuButton<MenuItem>(
      onSelected: (MenuItem item) => DescriptionState.toggle(),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
        Menu.descriptionItem(),
      ],
    );
  }

  static PopupMenuItem<MenuItem> descriptionItem() {
    return PopupMenuItem<MenuItem>(
      value: MenuItem.switchDescription,
      child: StreamBuilder(
        stream: DescriptionState.listen(),
        initialData: DescriptionState.state,
        builder: (context, snapshot) {
          return CheckboxListTile(
            key: ItemId.btnFrom(ItemName.menuDescription),
            value: snapshot.data,
            onChanged: (isChecked) {
              DescriptionState.toggle();
              Navigator.of(context).pop();
            },
            title: TextWidget(Transl.of(context).menu_enable_description),
          );
        },
      ),
    );
  }

  static PopupMenuButton popupPersonalization(Function(MenuItem) callback) {
    return PopupMenuButton<MenuItem>(
      key: ItemId.btnFrom(ItemName.menu),
      onSelected: callback,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
        Menu.descriptionItem(),
        PopupMenuItem(
          key: ItemId.btnFrom(ItemName.menuConfigs),
          value: MenuItem.personalizationConfigs,
          child: TextWidget(Transl.of(context).menu_pers_configs),
        ),
        PopupMenuItem(
          key: ItemId.btnFrom(ItemName.menuImport),
          value: MenuItem.personalizationImport,
          child: TextWidget(Transl.of(context).menu_pers_import),
        ),
        PopupMenuItem(
          key: ItemId.btnFrom(ItemName.menuExport),
          value: MenuItem.personalizationExport,
          child: TextWidget(Transl.of(context).menu_pers_export),
        ),
      ],
    );
  }
}
