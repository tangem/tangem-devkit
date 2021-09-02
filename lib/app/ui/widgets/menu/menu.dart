import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/resources/localization.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app/ui/widgets/basic/text_widget.dart';
import 'package:devkit/commons/global/show_description.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum MenuItem {
  share,
  switchDescription,
  personalizationConfigs,
  personalizationImport,
  personalizationExport,
  navigateToTestScreen,
  navigateToJsonTestAssembler,
  navigateToJsonTestLauncher,
}

class Menu {
  static PopupMenuButton popupDescription() {
    late BuildContext temporaryContext;
    return PopupMenuButton<MenuItem>(
      key: ItemId.btnFrom(ItemName.menu),
      onSelected: (MenuItem item) {
        switch (item) {
          case MenuItem.switchDescription:
            DescriptionState.toggle();
            break;
          case MenuItem.navigateToTestScreen:
            Navigator.of(temporaryContext).pushNamed(Routes.TEST);
            break;
          case MenuItem.navigateToJsonTestAssembler:
            Navigator.of(temporaryContext).pushNamed(Routes.JSON_TEST_ASSEMBLER);
            break;
            case MenuItem.navigateToJsonTestLauncher:
            Navigator.of(temporaryContext).pushNamed(Routes.JSON_TEST_LAUNCHER);
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        temporaryContext = context;
        final menuItemList = <PopupMenuItem<MenuItem>>[];
        menuItemList.add(Menu.descriptionItem());
        if (!kReleaseMode) {
          final testScreenItem = PopupMenuItem(
            key: ItemId.btnFrom(ItemName.navigateToTestScreen),
            value: MenuItem.navigateToTestScreen,
            child: TextWidget("Command auto tester"),
          );
          menuItemList.add(testScreenItem);
        }
        final jsonTestAssemblerScreenItem = PopupMenuItem(
          key: ItemId.btnFrom(ItemName.navigateToJsonTestAssembler),
          value: MenuItem.navigateToJsonTestAssembler,
          child: TextWidget("Json tests assembler"),
        );
        final cardTesterScreenItem = PopupMenuItem(
          key: ItemId.btnFrom(ItemName.navigateToJsonTestLauncher),
          value: MenuItem.navigateToJsonTestLauncher,
          child: TextWidget("Json tests launcher"),
        );
        menuItemList.add(jsonTestAssemblerScreenItem);
        menuItemList.add(cardTesterScreenItem);
        return menuItemList;
      },
    );
  }

  static PopupMenuItem<MenuItem> descriptionItem() {
    return PopupMenuItem<MenuItem>(
      value: MenuItem.switchDescription,
      child: StreamBuilder<bool>(
        initialData: DescriptionState.state,
        stream: DescriptionState.listen(),
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
