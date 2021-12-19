import 'package:event_app/view/ui/event/event_viewmodel.dart';
import 'package:flutter/material.dart';

import 'event_tab.dart';

class EventTabBar extends StatelessWidget {
  final EventViewModel model;
  EventTabBar(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27.50),
        border:
            Border.all(color: Theme.of(context).primaryColorLight, width: 1.50),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => model.setIndex(0),
              child: EventTab(
                tabTitle: "Upcoming Events",
                currentIndex: model.currentIndex,
                tabIndex: 0,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => model.setIndex(1),
              child: EventTab(
                tabTitle: "Completed Events",
                currentIndex: model.currentIndex,
                tabIndex: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
