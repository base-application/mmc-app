import 'package:event_bus/event_bus.dart';
import 'package:mmc/bean/event_data_item_info_entity.dart';

EventBus eventBus = EventBus();

class LoginOutTimeEvent {
  final int statusCode;

  const LoginOutTimeEvent({ required this.statusCode });
}

class AppLanguageChangeEvent {}

class EventItemDataChangeEvent {
  final int eventId;
  final List<EventDataItemInfoAttendance> list;

  const EventItemDataChangeEvent({ required this.eventId, required this.list });
}

class FollowUserStateChangeEvent {
  final bool isFollow;
  final int userId;

  const FollowUserStateChangeEvent({ required this.isFollow, required this.userId });
}

class CompanyListInfoChangeEvent {
}
