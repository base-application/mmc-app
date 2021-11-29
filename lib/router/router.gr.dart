// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i33;
import 'package:flutter/cupertino.dart' as _i37;
import 'package:flutter/material.dart' as _i34;

import '../bean/event_data_item_info_entity.dart' as _i41;
import '../bean/group_item_info_entity.dart' as _i38;
import '../bean/guide_line_entity.dart' as _i43;
import '../bean/network_item_info_entity.dart' as _i39;
import '../bean/newest_item_info_entity.dart' as _i40;
import '../bean/notification_entity.dart' as _i44;
import '../bean/personal_profile_info_entity.dart' as _i42;
import '../bean/referral_entity.dart' as _i36;
import '../screens/business_profile_create_page.dart' as _i22;
import '../screens/business_profile_set_page.dart' as _i21;
import '../screens/change_password_page.dart' as _i23;
import '../screens/check_history.dart' as _i31;
import '../screens/create_event_page.dart' as _i17;
import '../screens/event_listing_page.dart' as _i8;
import '../screens/event_listing_page_detail.dart' as _i9;
import '../screens/group_page.dart' as _i2;
import '../screens/group_page_detail.dart' as _i3;
import '../screens/guideline_detail_page.dart' as _i25;
import '../screens/guideline_page.dart' as _i24;
import '../screens/home.dart' as _i1;
import '../screens/language_set_page.dart' as _i26;
import '../screens/login.dart' as _i28;
import '../screens/most_referral_sent_page.dart' as _i16;
import '../screens/my_inbox_detail_page.dart' as _i32;
import '../screens/my_inbox_page.dart' as _i18;
import '../screens/network_person_page.dart' as _i5;
import '../screens/newest_detail_page.dart' as _i7;
import '../screens/personal_profile_set_page.dart' as _i20;
import '../screens/referral_received_contacted_page.dart' as _i11;
import '../screens/referral_received_page.dart' as _i10;
import '../screens/send_thank_you_note_page.dart' as _i12;
import '../screens/sending_referral_page.dart' as _i4;
import '../screens/setting_page.dart' as _i19;
import '../screens/shining_board_detail_page.dart' as _i15;
import '../screens/shining_board_page.dart' as _i14;
import '../screens/thank_you_note_received_page.dart' as _i13;
import '../screens/today_newest_page.dart' as _i6;
import '../screens/web_page.dart' as _i30;
import '../screens/your_pic_page.dart' as _i27;
import '../utils/qr_view.dart' as _i29;
import 'auth_guard.dart' as _i35;

class AppRouter extends _i33.RootStackRouter {
  AppRouter(
      {_i34.GlobalKey<_i34.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i35.AuthGuard authGuard;

  @override
  final Map<String, _i33.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i1.HomePage());
    },
    GroupRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i2.GroupPage());
    },
    GroupDetailRoute.name: (routeData) {
      final args = routeData.argsAs<GroupDetailRouteArgs>();
      return _i33.MaterialPageX<String>(
          routeData: routeData,
          child: _i3.GroupDetailPage(key: args.key, info: args.info));
    },
    SendingReferralRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i4.SendingReferralPage());
    },
    NetworkPersonRoute.name: (routeData) {
      final args = routeData.argsAs<NetworkPersonRouteArgs>();
      return _i33.MaterialPageX<String>(
          routeData: routeData,
          child: _i5.NetworkPersonPage(key: args.key, itemInfo: args.itemInfo));
    },
    TodayNewestRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i6.TodayNewestPage());
    },
    NewestDetailRoute.name: (routeData) {
      final args = routeData.argsAs<NewestDetailRouteArgs>();
      return _i33.MaterialPageX<String>(
          routeData: routeData,
          child: _i7.NewestDetailPage(key: args.key, info: args.info));
    },
    EventListingRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i8.EventListingPage());
    },
    EventListingDetailRoute.name: (routeData) {
      final args = routeData.argsAs<EventListingDetailRouteArgs>();
      return _i33.MaterialPageX<String>(
          routeData: routeData,
          child: _i9.EventListingDetailPage(
              key: args.key, eventInfo: args.eventInfo));
    },
    ReferralReceivedRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i10.ReferralReceivedPage());
    },
    ReferralReceivedContactedRoute.name: (routeData) {
      final args = routeData.argsAs<ReferralReceivedContactedRouteArgs>();
      return _i33.MaterialPageX<_i36.ReferralEntity>(
          routeData: routeData,
          child: _i11.ReferralReceivedContactedPage(
              key: args.key, referralEntity: args.referralEntity));
    },
    SendThankYouNoteRoute.name: (routeData) {
      final args = routeData.argsAs<SendThankYouNoteRouteArgs>();
      return _i33.MaterialPageX<bool>(
          routeData: routeData,
          child: _i12.SendThankYouNotePage(
              key: args.key, referralId: args.referralId));
    },
    ThankYouNoteReceivedRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i13.ThankYouNoteReceivedPage());
    },
    ShiningBoardRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i14.ShiningBoardPage());
    },
    ShiningBoardDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ShiningBoardDetailRouteArgs>();
      return _i33.MaterialPageX<String>(
          routeData: routeData,
          child: _i15.ShiningBoardDetailPage(key: args.key, about: args.about));
    },
    MostReferralSentRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i16.MostReferralSentPage());
    },
    CreateEventRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i17.CreateEventPage());
    },
    MyInboxRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i18.MyInboxPage());
    },
    SettingRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i19.SettingPage());
    },
    PersonalProfileSetRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i20.PersonalProfileSetPage());
    },
    BusinessProfileSetRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i21.BusinessProfileSetPage());
    },
    BusinessProfileCreateRoute.name: (routeData) {
      final args = routeData.argsAs<BusinessProfileCreateRouteArgs>(
          orElse: () => const BusinessProfileCreateRouteArgs());
      return _i33.MaterialPageX<String>(
          routeData: routeData,
          child:
              _i22.BusinessProfileCreatePage(key: args.key, info: args.info));
    },
    ChangePasswordRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i23.ChangePasswordPage());
    },
    GuidelineRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i24.GuidelinePage());
    },
    GuidelineDetailRoute.name: (routeData) {
      final args = routeData.argsAs<GuidelineDetailRouteArgs>();
      return _i33.MaterialPageX<String>(
          routeData: routeData,
          child: _i25.GuidelineDetailPage(
              key: args.key, guideLineEntity: args.guideLineEntity));
    },
    LanguageSetRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i26.LanguageSetPage());
    },
    YourPicRoute.name: (routeData) {
      return _i33.MaterialPageX<String>(
          routeData: routeData, child: const _i27.YourPicPage());
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i33.MaterialPageX<String>(
          routeData: routeData,
          child: _i28.LoginPage(
              key: args.key, onLoginSuccess: args.onLoginSuccess));
    },
    QrViewRoute.name: (routeData) {
      final args = routeData.argsAs<QrViewRouteArgs>();
      return _i33.MaterialPageX<String>(
          routeData: routeData,
          child: _i29.QrViewPage(key: args.key, type: args.type));
    },
    WebRoute.name: (routeData) {
      final args = routeData.argsAs<WebRouteArgs>();
      return _i33.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i30.WebPage(
              key: args.key, title: args.title, initUrl: args.initUrl));
    },
    CheckHistoryRoute.name: (routeData) {
      return _i33.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i31.CheckHistoryPage());
    },
    InboxDetailRoute.name: (routeData) {
      final args = routeData.argsAs<InboxDetailRouteArgs>();
      return _i33.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i32.InboxDetailPage(
              key: args.key, notification: args.notification));
    }
  };

  @override
  List<_i33.RouteConfig> get routes => [
        _i33.RouteConfig(HomeRoute.name, path: '/', guards: [authGuard]),
        _i33.RouteConfig(GroupRoute.name, path: '/group'),
        _i33.RouteConfig(GroupDetailRoute.name, path: '/groupDetail'),
        _i33.RouteConfig(SendingReferralRoute.name, path: '/sendingReferral'),
        _i33.RouteConfig(NetworkPersonRoute.name, path: '/networkPerson'),
        _i33.RouteConfig(TodayNewestRoute.name, path: '/todayNewest'),
        _i33.RouteConfig(NewestDetailRoute.name, path: '/newestDetail'),
        _i33.RouteConfig(EventListingRoute.name, path: '/eventListing'),
        _i33.RouteConfig(EventListingDetailRoute.name,
            path: '/eventListingDetail'),
        _i33.RouteConfig(ReferralReceivedRoute.name, path: '/referralReceived'),
        _i33.RouteConfig(ReferralReceivedContactedRoute.name,
            path: '/referralReceivedContacted'),
        _i33.RouteConfig(SendThankYouNoteRoute.name, path: '/sendThankYouNote'),
        _i33.RouteConfig(ThankYouNoteReceivedRoute.name,
            path: '/thankYouNoteReceived'),
        _i33.RouteConfig(ShiningBoardRoute.name, path: '/shiningBoardPage'),
        _i33.RouteConfig(ShiningBoardDetailRoute.name,
            path: '/shiningBoardDetail'),
        _i33.RouteConfig(MostReferralSentRoute.name, path: '/mostReferralSent'),
        _i33.RouteConfig(CreateEventRoute.name, path: '/createEvent'),
        _i33.RouteConfig(MyInboxRoute.name, path: '/myInbox'),
        _i33.RouteConfig(SettingRoute.name, path: '/setting'),
        _i33.RouteConfig(PersonalProfileSetRoute.name,
            path: '/personalProfileSet'),
        _i33.RouteConfig(BusinessProfileSetRoute.name,
            path: '/businessProfileSet'),
        _i33.RouteConfig(BusinessProfileCreateRoute.name,
            path: '/businessProfileCreate'),
        _i33.RouteConfig(ChangePasswordRoute.name, path: '/changePassword'),
        _i33.RouteConfig(GuidelineRoute.name, path: '/guideline'),
        _i33.RouteConfig(GuidelineDetailRoute.name, path: '/guidelineDetail'),
        _i33.RouteConfig(LanguageSetRoute.name, path: '/languageSet'),
        _i33.RouteConfig(YourPicRoute.name, path: '/yourPic'),
        _i33.RouteConfig(LoginRoute.name, path: '/login'),
        _i33.RouteConfig(QrViewRoute.name, path: '/qrview'),
        _i33.RouteConfig(WebRoute.name, path: '/webpage'),
        _i33.RouteConfig(CheckHistoryRoute.name, path: '/checkHistory'),
        _i33.RouteConfig(InboxDetailRoute.name, path: '/inboxDetail')
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i33.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.GroupPage]
class GroupRoute extends _i33.PageRouteInfo<void> {
  const GroupRoute() : super(name, path: '/group');

  static const String name = 'GroupRoute';
}

/// generated route for [_i3.GroupDetailPage]
class GroupDetailRoute extends _i33.PageRouteInfo<GroupDetailRouteArgs> {
  GroupDetailRoute({_i37.Key? key, required _i38.GroupItemInfoEntity info})
      : super(name,
            path: '/groupDetail',
            args: GroupDetailRouteArgs(key: key, info: info));

  static const String name = 'GroupDetailRoute';
}

class GroupDetailRouteArgs {
  const GroupDetailRouteArgs({this.key, required this.info});

  final _i37.Key? key;

  final _i38.GroupItemInfoEntity info;
}

/// generated route for [_i4.SendingReferralPage]
class SendingReferralRoute extends _i33.PageRouteInfo<void> {
  const SendingReferralRoute() : super(name, path: '/sendingReferral');

  static const String name = 'SendingReferralRoute';
}

/// generated route for [_i5.NetworkPersonPage]
class NetworkPersonRoute extends _i33.PageRouteInfo<NetworkPersonRouteArgs> {
  NetworkPersonRoute(
      {_i37.Key? key, required _i39.NetworkItemInfoEntity itemInfo})
      : super(name,
            path: '/networkPerson',
            args: NetworkPersonRouteArgs(key: key, itemInfo: itemInfo));

  static const String name = 'NetworkPersonRoute';
}

class NetworkPersonRouteArgs {
  const NetworkPersonRouteArgs({this.key, required this.itemInfo});

  final _i37.Key? key;

  final _i39.NetworkItemInfoEntity itemInfo;
}

/// generated route for [_i6.TodayNewestPage]
class TodayNewestRoute extends _i33.PageRouteInfo<void> {
  const TodayNewestRoute() : super(name, path: '/todayNewest');

  static const String name = 'TodayNewestRoute';
}

/// generated route for [_i7.NewestDetailPage]
class NewestDetailRoute extends _i33.PageRouteInfo<NewestDetailRouteArgs> {
  NewestDetailRoute({_i37.Key? key, required _i40.NewestItemInfoEntity info})
      : super(name,
            path: '/newestDetail',
            args: NewestDetailRouteArgs(key: key, info: info));

  static const String name = 'NewestDetailRoute';
}

class NewestDetailRouteArgs {
  const NewestDetailRouteArgs({this.key, required this.info});

  final _i37.Key? key;

  final _i40.NewestItemInfoEntity info;
}

/// generated route for [_i8.EventListingPage]
class EventListingRoute extends _i33.PageRouteInfo<void> {
  const EventListingRoute() : super(name, path: '/eventListing');

  static const String name = 'EventListingRoute';
}

/// generated route for [_i9.EventListingDetailPage]
class EventListingDetailRoute
    extends _i33.PageRouteInfo<EventListingDetailRouteArgs> {
  EventListingDetailRoute(
      {_i37.Key? key, required _i41.EventDataItemInfoEntity eventInfo})
      : super(name,
            path: '/eventListingDetail',
            args: EventListingDetailRouteArgs(key: key, eventInfo: eventInfo));

  static const String name = 'EventListingDetailRoute';
}

class EventListingDetailRouteArgs {
  const EventListingDetailRouteArgs({this.key, required this.eventInfo});

  final _i37.Key? key;

  final _i41.EventDataItemInfoEntity eventInfo;
}

/// generated route for [_i10.ReferralReceivedPage]
class ReferralReceivedRoute extends _i33.PageRouteInfo<void> {
  const ReferralReceivedRoute() : super(name, path: '/referralReceived');

  static const String name = 'ReferralReceivedRoute';
}

/// generated route for [_i11.ReferralReceivedContactedPage]
class ReferralReceivedContactedRoute
    extends _i33.PageRouteInfo<ReferralReceivedContactedRouteArgs> {
  ReferralReceivedContactedRoute(
      {_i37.Key? key, required _i36.ReferralEntity referralEntity})
      : super(name,
            path: '/referralReceivedContacted',
            args: ReferralReceivedContactedRouteArgs(
                key: key, referralEntity: referralEntity));

  static const String name = 'ReferralReceivedContactedRoute';
}

class ReferralReceivedContactedRouteArgs {
  const ReferralReceivedContactedRouteArgs(
      {this.key, required this.referralEntity});

  final _i37.Key? key;

  final _i36.ReferralEntity referralEntity;
}

/// generated route for [_i12.SendThankYouNotePage]
class SendThankYouNoteRoute
    extends _i33.PageRouteInfo<SendThankYouNoteRouteArgs> {
  SendThankYouNoteRoute({_i37.Key? key, required int referralId})
      : super(name,
            path: '/sendThankYouNote',
            args: SendThankYouNoteRouteArgs(key: key, referralId: referralId));

  static const String name = 'SendThankYouNoteRoute';
}

class SendThankYouNoteRouteArgs {
  const SendThankYouNoteRouteArgs({this.key, required this.referralId});

  final _i37.Key? key;

  final int referralId;
}

/// generated route for [_i13.ThankYouNoteReceivedPage]
class ThankYouNoteReceivedRoute extends _i33.PageRouteInfo<void> {
  const ThankYouNoteReceivedRoute()
      : super(name, path: '/thankYouNoteReceived');

  static const String name = 'ThankYouNoteReceivedRoute';
}

/// generated route for [_i14.ShiningBoardPage]
class ShiningBoardRoute extends _i33.PageRouteInfo<void> {
  const ShiningBoardRoute() : super(name, path: '/shiningBoardPage');

  static const String name = 'ShiningBoardRoute';
}

/// generated route for [_i15.ShiningBoardDetailPage]
class ShiningBoardDetailRoute
    extends _i33.PageRouteInfo<ShiningBoardDetailRouteArgs> {
  ShiningBoardDetailRoute({_i37.Key? key, required _i14.ShiningBoardInfo about})
      : super(name,
            path: '/shiningBoardDetail',
            args: ShiningBoardDetailRouteArgs(key: key, about: about));

  static const String name = 'ShiningBoardDetailRoute';
}

class ShiningBoardDetailRouteArgs {
  const ShiningBoardDetailRouteArgs({this.key, required this.about});

  final _i37.Key? key;

  final _i14.ShiningBoardInfo about;
}

/// generated route for [_i16.MostReferralSentPage]
class MostReferralSentRoute extends _i33.PageRouteInfo<void> {
  const MostReferralSentRoute() : super(name, path: '/mostReferralSent');

  static const String name = 'MostReferralSentRoute';
}

/// generated route for [_i17.CreateEventPage]
class CreateEventRoute extends _i33.PageRouteInfo<void> {
  const CreateEventRoute() : super(name, path: '/createEvent');

  static const String name = 'CreateEventRoute';
}

/// generated route for [_i18.MyInboxPage]
class MyInboxRoute extends _i33.PageRouteInfo<void> {
  const MyInboxRoute() : super(name, path: '/myInbox');

  static const String name = 'MyInboxRoute';
}

/// generated route for [_i19.SettingPage]
class SettingRoute extends _i33.PageRouteInfo<void> {
  const SettingRoute() : super(name, path: '/setting');

  static const String name = 'SettingRoute';
}

/// generated route for [_i20.PersonalProfileSetPage]
class PersonalProfileSetRoute extends _i33.PageRouteInfo<void> {
  const PersonalProfileSetRoute() : super(name, path: '/personalProfileSet');

  static const String name = 'PersonalProfileSetRoute';
}

/// generated route for [_i21.BusinessProfileSetPage]
class BusinessProfileSetRoute extends _i33.PageRouteInfo<void> {
  const BusinessProfileSetRoute() : super(name, path: '/businessProfileSet');

  static const String name = 'BusinessProfileSetRoute';
}

/// generated route for [_i22.BusinessProfileCreatePage]
class BusinessProfileCreateRoute
    extends _i33.PageRouteInfo<BusinessProfileCreateRouteArgs> {
  BusinessProfileCreateRoute(
      {_i37.Key? key, _i42.PersonalProfileInfoCompanyVos? info})
      : super(name,
            path: '/businessProfileCreate',
            args: BusinessProfileCreateRouteArgs(key: key, info: info));

  static const String name = 'BusinessProfileCreateRoute';
}

class BusinessProfileCreateRouteArgs {
  const BusinessProfileCreateRouteArgs({this.key, this.info});

  final _i37.Key? key;

  final _i42.PersonalProfileInfoCompanyVos? info;
}

/// generated route for [_i23.ChangePasswordPage]
class ChangePasswordRoute extends _i33.PageRouteInfo<void> {
  const ChangePasswordRoute() : super(name, path: '/changePassword');

  static const String name = 'ChangePasswordRoute';
}

/// generated route for [_i24.GuidelinePage]
class GuidelineRoute extends _i33.PageRouteInfo<void> {
  const GuidelineRoute() : super(name, path: '/guideline');

  static const String name = 'GuidelineRoute';
}

/// generated route for [_i25.GuidelineDetailPage]
class GuidelineDetailRoute
    extends _i33.PageRouteInfo<GuidelineDetailRouteArgs> {
  GuidelineDetailRoute(
      {_i37.Key? key, required _i43.GuideLineEntity guideLineEntity})
      : super(name,
            path: '/guidelineDetail',
            args: GuidelineDetailRouteArgs(
                key: key, guideLineEntity: guideLineEntity));

  static const String name = 'GuidelineDetailRoute';
}

class GuidelineDetailRouteArgs {
  const GuidelineDetailRouteArgs({this.key, required this.guideLineEntity});

  final _i37.Key? key;

  final _i43.GuideLineEntity guideLineEntity;
}

/// generated route for [_i26.LanguageSetPage]
class LanguageSetRoute extends _i33.PageRouteInfo<void> {
  const LanguageSetRoute() : super(name, path: '/languageSet');

  static const String name = 'LanguageSetRoute';
}

/// generated route for [_i27.YourPicPage]
class YourPicRoute extends _i33.PageRouteInfo<void> {
  const YourPicRoute() : super(name, path: '/yourPic');

  static const String name = 'YourPicRoute';
}

/// generated route for [_i28.LoginPage]
class LoginRoute extends _i33.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i37.Key? key, void Function(_i37.BuildContext)? onLoginSuccess})
      : super(name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginSuccess: onLoginSuccess));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onLoginSuccess});

  final _i37.Key? key;

  final void Function(_i37.BuildContext)? onLoginSuccess;
}

/// generated route for [_i29.QrViewPage]
class QrViewRoute extends _i33.PageRouteInfo<QrViewRouteArgs> {
  QrViewRoute({_i37.Key? key, required int type})
      : super(name,
            path: '/qrview', args: QrViewRouteArgs(key: key, type: type));

  static const String name = 'QrViewRoute';
}

class QrViewRouteArgs {
  const QrViewRouteArgs({this.key, required this.type});

  final _i37.Key? key;

  final int type;
}

/// generated route for [_i30.WebPage]
class WebRoute extends _i33.PageRouteInfo<WebRouteArgs> {
  WebRoute({_i37.Key? key, required String title, required String initUrl})
      : super(name,
            path: '/webpage',
            args: WebRouteArgs(key: key, title: title, initUrl: initUrl));

  static const String name = 'WebRoute';
}

class WebRouteArgs {
  const WebRouteArgs({this.key, required this.title, required this.initUrl});

  final _i37.Key? key;

  final String title;

  final String initUrl;
}

/// generated route for [_i31.CheckHistoryPage]
class CheckHistoryRoute extends _i33.PageRouteInfo<void> {
  const CheckHistoryRoute() : super(name, path: '/checkHistory');

  static const String name = 'CheckHistoryRoute';
}

/// generated route for [_i32.InboxDetailPage]
class InboxDetailRoute extends _i33.PageRouteInfo<InboxDetailRouteArgs> {
  InboxDetailRoute(
      {_i37.Key? key, required _i44.NotificationEntity notification})
      : super(name,
            path: '/inboxDetail',
            args: InboxDetailRouteArgs(key: key, notification: notification));

  static const String name = 'InboxDetailRoute';
}

class InboxDetailRouteArgs {
  const InboxDetailRouteArgs({this.key, required this.notification});

  final _i37.Key? key;

  final _i44.NotificationEntity notification;
}
