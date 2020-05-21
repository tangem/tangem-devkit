import 'package:devkit/app/resources/localization.dart';
import 'package:devkit/app/ui/widgets/basic/text_widget.dart';
import 'package:devkit/commons/global/show_description.dart';
import 'package:flutter/material.dart';

enum MenuItem {
  share,
  switchDescription,
  personalizationReset,
  personalizationSavePreset,
  personalizationLoadPreset,
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
}
