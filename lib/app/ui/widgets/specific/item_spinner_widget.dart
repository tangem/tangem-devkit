import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SpinnerWidget extends StatelessWidget {
  final String keyName;
  final String title;
  final String description;
  final List<Pair>? items;
  final BehaviorSubject<Pair> subject;

  const SpinnerWidget(
    this.keyName,
    this.items,
    this.subject,
    this.title,
    this.description,
  );

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: AppDimen.itemMinHeight),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: <Widget>[
              TitleWidget(title),
              StreamBuilder<Pair>(
                stream: subject,
                initialData: items?.firstOrNull(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) return StubWidget();

                  final data = snapshot.data!;
                  return ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<Pair>(
                      key: ItemId.from(keyName),
                      itemHeight: null,
                      isExpanded: true,
                      underline:
                          Container(margin: EdgeInsets.only(bottom: 8), height: 1, color: AppColor.dropDownUnderline),
                      value: data,
                      items: items
                          ?.map((Pair pair) => DropdownMenuItem<Pair>(
                                value: pair,
                                child: Text(Transl.of(context).get(pair.a)),
                              ))
                          .toList(),
                      onChanged: (pair) {
                        if (pair != null) subject.add(pair);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          DescriptionWidget(description)
        ],
      ),
    ).padding16();
  }
}
