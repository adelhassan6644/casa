import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

import '../app/core/utils/methods.dart';

class CalenderProvider extends ChangeNotifier {
  WeekdayCount? counts;
  EventList<Event>? _markedDateMap;
  final Widget _eventIcon = Container(
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(.5),
      borderRadius: const BorderRadius.all(Radius.circular(1000)),
    ),
  );
  Map<DateTime, List<Event>> eventsMAP = {};
  EventList<Event>? eventList;
  List<int> days=[];
  bool isLoad = false;
  getEventsList({required DateTime startDate,required DateTime endDate}) {
    isLoad = true;
    eventList = null;
    eventsMAP = {};
    notifyListeners();

    counts = Methods.getWeekdayCount(
        startDate: startDate, endDate: endDate, weekdays: days);

    for (var element in counts!.daysList) {
      {
        eventsMAP[DateTime(element.year, element.month, element.day)] = [
          Event(date: element, icon: _eventIcon)
        ];
      }
    }
    print("&&"+eventsMAP.toString());
    eventList = EventList<Event>(events: eventsMAP);
    isLoad = false;
    notifyListeners();
  }
}
