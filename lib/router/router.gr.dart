// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i29;
import 'package:flutter/material.dart' as _i30;

import '../bean/event_data_item_info_entity.dart' as _i36;
import '../bean/group_item_info_entity.dart' as _i33;
import '../bean/network_item_info_entity.dart' as _i34;
import '../bean/newest_item_info_entity.dart' as _i35;
import '../bean/personal_profile_info_entity.dart' as _i37;
import '../bean/referral_entity.dart' as _i32;
import '../screens/business_profile_create_page.dart' as _i22;
import '../screens/business_profile_set_page.dart' as _i21;
import '../screens/change_password_page.dart' as _i23;
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
import '../screens/your_pic_page.dart' as _i27;
import 'auth_guard.dart' as _i31;

class AppRouter extends _i29.RootStackRouter {
  AppRouter(
      {_i30.GlobalKey<_i30.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i31.AuthGuard authGuard;

  @override
  final Map<String, _i29.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i1.HomePage());
    },
    GroupRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i2.GroupPage());
    },
    GroupDetailRoute.name: (routeData) {
      final args = routeData.argsAs<GroupDetailRouteArgs>();
      return _i29.MaterialPageX<String>(
          routeData: routeData,
          child: _i3.GroupDetailPage(key: args.key, info: args.info));
    },
    SendingReferralRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i4.SendingReferralPage());
    },
    NetworkPersonRoute.name: (routeData) {
      final args = routeData.argsAs<NetworkPersonRouteArgs>();
      return _i29.MaterialPageX<String>(
          routeData: routeData,
          child: _i5.NetworkPersonPage(key: args.key, itemInfo: args.itemInfo));
    },
    TodayNewestRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i6.TodayNewestPage());
    },
    NewestDetailRoute.name: (routeData) {
      final args = routeData.argsAs<NewestDetailRouteArgs>();
      return _i29.MaterialPageX<String>(
          routeData: routeData,
          child: _i7.NewestDetailPage(key: args.key, info: args.info));
    },
    EventListingRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i8.EventListingPage());
    },
    EventListingDetailRoute.name: (routeData) {
      final args = routeData.argsAs<EventListingDetailRouteArgs>();
      return _i29.MaterialPageX<String>(
          routeData: routeData,
          child: _i9.EventListingDetailPage(
              key: args.key, eventInfo: args.eventInfo));
    },
    ReferralReceivedRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i10.ReferralReceivedPage());
    },
    ReferralReceivedContactedRoute.name: (routeData) {
      final args = routeData.argsAs<ReferralReceivedContactedRouteArgs>();
      return _i29.MaterialPageX<_i32.ReferralEntity>(
          routeData: routeData,
          child: _i11.ReferralReceivedContactedPage(
              key: args.key, referralEntity: args.referralEntity));
    },
    SendThankYouNoteRoute.name: (routeData) {
      final args = routeData.argsAs<SendThankYouNoteRouteArgs>();
      return _i29.MaterialPageX<bool>(
          routeData: routeData,
          child: _i12.SendThankYouNotePage(
              key: args.key, referralId: args.referralId));
    },
    ThankYouNoteReceivedRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i13.ThankYouNoteReceivedPage());
    },
    ShiningBoardRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i14.ShiningBoardPage());
    },
    ShiningBoardDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ShiningBoardDetailRouteArgs>();
      return _i29.MaterialPageX<String>(
          routeData: routeData,
          child: _i15.ShiningBoardDetailPage(key: args.key, about: args.about));
    },
    MostReferralSentRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i16.MostReferralSentPage());
    },
    CreateEventRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i17.CreateEventPage());
    },
    MyInboxRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i18.MyInboxPage());
    },
    SettingRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i19.SettingPage());
    },
    PersonalProfileSetRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i20.PersonalProfileSetPage());
    },
    BusinessProfileSetRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i21.BusinessProfileSetPage());
    },
    BusinessProfileCreateRoute.name: (routeData) {
      final args = routeData.argsAs<BusinessProfileCreateRouteArgs>(
          orElse: () => const BusinessProfileCreateRouteArgs());
      return _i29.MaterialPageX<String>(
          routeData: routeData,
          child:
              _i22.BusinessProfileCreatePage(key: args.key, info: args.info));
    },
    ChangePasswordRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i23.ChangePasswordPage());
    },
    GuidelineRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i24.GuidelinePage());
    },
    GuidelineDetailRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i25.GuidelineDetailPage());
    },
    LanguageSetRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i26.LanguageSetPage());
    },
    YourPicRoute.name: (routeData) {
      return _i29.MaterialPageX<String>(
          routeData: routeData, child: const _i27.YourPicPage());
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i29.MaterialPageX<String>(
          routeData: routeData,
          child: _i28.LoginPage(
              key: args.key, onLoginSuccess: args.onLoginSuccess));
    }
  };

  @override
  List<_i29.RouteConfig> get routes => [
        _i29.RouteConfig(HomeRoute.name, path: '/', guards: [authGuard]),
        _i29.RouteConfig(GroupRoute.name, path: '/group'),
        _i29.RouteConfig(GroupDetailRoute.name, path: '/groupDetail'),
        _i29.RouteConfig(SendingReferralRoute.name, path: '/sendingReferral'),
        _i29.RouteConfig(NetworkPersonRoute.name, path: '/networkPerson'),
        _i29.RouteConfig(TodayNewestRoute.name, path: '/todayNewest'),
        _i29.RouteConfig(NewestDetailRoute.name, path: '/newestDetail'),
        _i29.RouteConfig(EventListingRoute.name, path: '/eventListing'),
        _i29.RouteConfig(EventListingDetailRoute.name,
            path: '/eventListingDetail'),
        _i29.RouteConfig(ReferralReceivedRoute.name, path: '/referralReceived'),
        _i29.RouteConfig(ReferralReceivedContactedRoute.name,
            path: '/referralReceivedContacted'),
        _i29.RouteConfig(SendThankYouNoteRoute.name, path: '/sendThankYouNote'),
        _i29.RouteConfig(ThankYouNoteReceivedRoute.name,
            path: '/thankYouNoteReceived'),
        _i29.RouteConfig(ShiningBoardRoute.name, path: '/shiningBoardPage'),
        _i29.RouteConfig(ShiningBoardDetailRoute.name,
            path: '/shiningBoardDetail'),
        _i29.RouteConfig(MostReferralSentRoute.name, path: '/mostReferralSent'),
        _i29.RouteConfig(CreateEventRoute.name, path: '/createEvent'),
        _i29.RouteConfig(MyInboxRoute.name, path: '/myInbox'),
        _i29.RouteConfig(SettingRoute.name, path: '/setting'),
        _i29.RouteConfig(PersonalProfileSetRoute.name,
            path: '/personalProfileSet'),
        _i29.RouteConfig(BusinessProfileSetRoute.name,
            path: '/businessProfileSet'),
        _i29.RouteConfig(BusinessProfileCreateRoute.name,
            path: '/businessProfileCreate'),
        _i29.RouteConfig(ChangePasswordRoute.name, path: '/changePassword'),
        _i29.RouteConfig(GuidelineRoute.name, path: '/guideline'),
        _i29.RouteConfig(GuidelineDetailRoute.name, path: '/guidelineDetail'),
        _i29.RouteConfig(LanguageSetRoute.name, path: '/languageSet'),
        _i29.RouteConfig(YourPicRoute.name, path: '/yourPic'),
        _i29.RouteConfig(LoginRoute.name, path: '/login')
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i29.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.GroupPage]
class GroupRoute extends _i29.PageRouteInfo<void> {
  const GroupRoute() : super(name, path: '/group');

  static const String name = 'GroupRoute';
}

/// generated route for [_i3.GroupDetailPage]
class GroupDetailRoute extends _i29.PageRouteInfo<GroupDetailRouteArgs> {
  GroupDetailRoute({_i30.Key? key, required _i33.GroupItemInfoEntity info})
      : super(name,
            path: '/groupDetail',
            args: GroupDetailRouteArgs(key: key, info: info));

  static const String name = 'GroupDetailRoute';
}

class GroupDetailRouteArgs {
  const GroupDetailRouteArgs({this.key, required this.info});

  final _i30.Key? key;

  final _i33.GroupItemInfoEntity info;
}

/// generated route for [_i4.SendingReferralPage]
class SendingReferralRoute extends _i29.PageRouteInfo<void> {
  const SendingReferralRoute() : super(name, path: '/sendingReferral');

  static const String name = 'SendingReferralRoute';
}

/// generated route for [_i5.NetworkPersonPage]
class NetworkPersonRoute extends _i29.PageRouteInfo<NetworkPersonRouteArgs> {
  NetworkPersonRoute(
      {_i30.Key? key, required _i34.NetworkItemInfoEntity itemInfo})
      : super(name,
            path: '/networkPerson',
            args: NetworkPersonRouteArgs(key: key, itemInfo: itemInfo));

  static const String name = 'NetworkPersonRoute';
}

class NetworkPersonRouteArgs {
  const NetworkPersonRouteArgs({this.key, required this.itemInfo});

  final _i30.Key? key;

  final _i34.NetworkItemInfoEntity itemInfo;
}

/// generated route for [_i6.TodayNewestPage]
class TodayNewestRoute extends _i29.PageRouteInfo<void> {
  const TodayNewestRoute() : super(name, path: '/todayNewest');

  static const String name = 'TodayNewestRoute';
}

/// generated route for [_i7.NewestDetailPage]
class NewestDetailRoute extends _i29.PageRouteInfo<NewestDetailRouteArgs> {
  NewestDetailRoute({_i30.Key? key, required _i35.NewestItemInfoEntity info})
      : super(name,
            path: '/newestDetail',
            args: NewestDetailRouteArgs(key: key, info: info));

  static const String name = 'NewestDetailRoute';
}

class NewestDetailRouteArgs {
  const NewestDetailRouteArgs({this.key, required this.info});

  final _i30.Key? key;

  final _i35.NewestItemInfoEntity info;
}

/// generated route for [_i8.EventListingPage]
class EventListingRoute extends _i29.PageRouteInfo<void> {
  const EventListingRoute() : super(name, path: '/eventListing');

  static const String name = 'EventListingRoute';
}

/// generated route for [_i9.EventListingDetailPage]
class EventListingDetailRoute
    extends _i29.PageRouteInfo<EventListingDetailRouteArgs> {
  EventListingDetailRoute(
      {_i30.Key? key, required _i36.EventDataItemInfoEntity eventInfo})
      : super(name,
            path: '/eventListingDetail',
            args: EventListingDetailRouteArgs(key: key, eventInfo: eventInfo));

  static const String name = 'EventListingDetailRoute';
}

class EventListingDetailRouteArgs {
  const EventListingDetailRouteArgs({this.key, required this.eventInfo});

  final _i30.Key? key;

  final _i36.EventDataItemInfoEntity eventInfo;
}

/// generated route for [_i10.ReferralReceivedPage]
class ReferralReceivedRoute extends _i29.PageRouteInfo<void> {
  const ReferralReceivedRoute() : super(name, path: '/referralReceived');

  static const String name = 'ReferralReceivedRoute';
}

/// generated route for [_i11.ReferralReceivedContactedPage]
class ReferralReceivedContactedRoute
    extends _i29.PageRouteInfo<ReferralReceivedContactedRouteArgs> {
  ReferralReceivedContactedRoute(
      {_i30.Key? key, required _i32.ReferralEntity referralEntity})
      : super(name,
            path: '/referralReceivedContacted',
            args: ReferralReceivedContactedRouteArgs(
                key: key, referralEntity: referralEntity));

  static const String name = 'ReferralReceivedContactedRoute';
}

class ReferralReceivedContactedRouteArgs {
  const ReferralReceivedContactedRouteArgs(
      {this.key, required this.referralEntity});

  final _i30.Key? key;

  final _i32.ReferralEntity referralEntity;
}

/// generated route for [_i12.SendThankYouNotePage]
class SendThankYouNoteRoute
    extends _i29.PageRouteInfo<SendThankYouNoteRouteArgs> {
  SendThankYouNoteRoute({_i30.Key? key, required int referralId})
      : super(name,
            path: '/sendThankYouNote',
            args: SendThankYouNoteRouteArgs(key: key, referralId: referralId));

  static const String name = 'SendThankYouNoteRoute';
}

class SendThankYouNoteRouteArgs {
  const SendThankYouNoteRouteArgs({this.key, required this.referralId});

  final _i30.Key? key;

  final int referralId;
}

/// generated route for [_i13.ThankYouNoteReceivedPage]
class ThankYouNoteReceivedRoute extends _i29.PageRouteInfo<void> {
  const ThankYouNoteReceivedRoute()
      : super(name, path: '/thankYouNoteReceived');

  static const String name = 'ThankYouNoteReceivedRoute';
}

/// generated route for [_i14.ShiningBoardPage]
class ShiningBoardRoute extends _i29.PageRouteInfo<void> {
  const ShiningBoardRoute() : super(name, path: '/shiningBoardPage');

  static const String name = 'ShiningBoardRoute';
}

/// generated route for [_i15.ShiningBoardDetailPage]
class ShiningBoardDetailRoute
    extends _i29.PageRouteInfo<ShiningBoardDetailRouteArgs> {
  ShiningBoardDetailRoute({_i30.Key? key, required _i14.ShiningBoardInfo about})
      : super(name,
            path: '/shiningBoardDetail',
            args: ShiningBoardDetailRouteArgs(key: key, about: about));

  static const String name = 'ShiningBoardDetailRoute';
}

class ShiningBoardDetailRouteArgs {
  const ShiningBoardDetailRouteArgs({this.key, required this.about});

  final _i30.Key? key;

  final _i14.ShiningBoardInfo about;
}

/// generated route for [_i16.MostReferralSentPage]
class MostReferralSentRoute extends _i29.PageRouteInfo<void> {
  const MostReferralSentRoute() : super(name, path: '/mostReferralSent');

  static const String name = 'MostReferralSentRoute';
}

/// generated route for [_i17.CreateEventPage]
class CreateEventRoute extends _i29.PageRouteInfo<void> {
  const CreateEventRoute() : super(name, path: '/createEvent');

  static const String name = 'CreateEventRoute';
}

/// generated route for [_i18.MyInboxPage]
class MyInboxRoute extends _i29.PageRouteInfo<void> {
  const MyInboxRoute() : super(name, path: '/myInbox');

  static const String name = 'MyInboxRoute';
}

/// generated route for [_i19.SettingPage]
class SettingRoute extends _i29.PageRouteInfo<void> {
  const SettingRoute() : super(name, path: '/setting');

  static const String name = 'SettingRoute';
}

/// generated route for [_i20.PersonalProfileSetPage]
class PersonalProfileSetRoute extends _i29.PageRouteInfo<void> {
  const PersonalProfileSetRoute() : super(name, path: '/personalProfileSet');

  static const String name = 'PersonalProfileSetRoute';
}

/// generated route for [_i21.BusinessProfileSetPage]
class BusinessProfileSetRoute extends _i29.PageRouteInfo<void> {
  const BusinessProfileSetRoute() : super(name, path: '/businessProfileSet');

  static const String name = 'BusinessProfileSetRoute';
}

/// generated route for [_i22.BusinessProfileCreatePage]
class BusinessProfileCreateRoute
    extends _i29.PageRouteInfo<BusinessProfileCreateRouteArgs> {
  BusinessProfileCreateRoute(
      {_i30.Key? key, _i37.PersonalProfileInfoCompanyVos? info})
      : super(name,
            path: '/businessProfileCreate',
            args: BusinessProfileCreateRouteArgs(key: key, info: info));

  static const String name = 'BusinessProfileCreateRoute';
}

class BusinessProfileCreateRouteArgs {
  const BusinessProfileCreateRouteArgs({this.key, this.info});

  final _i30.Key? key;

  final _i37.PersonalProfileInfoCompanyVos? info;
}

/// generated route for [_i23.ChangePasswordPage]
class ChangePasswordRoute extends _i29.PageRouteInfo<void> {
  const ChangePasswordRoute() : super(name, path: '/changePassword');

  static const String name = 'ChangePasswordRoute';
}

/// generated route for [_i24.GuidelinePage]
class GuidelineRoute extends _i29.PageRouteInfo<void> {
  const GuidelineRoute() : super(name, path: '/guideline');

  static const String name = 'GuidelineRoute';
}

/// generated route for [_i25.GuidelineDetailPage]
class GuidelineDetailRoute extends _i29.PageRouteInfo<void> {
  const GuidelineDetailRoute() : super(name, path: '/guidelineDetail');

  static const String name = 'GuidelineDetailRoute';
}

/// generated route for [_i26.LanguageSetPage]
class LanguageSetRoute extends _i29.PageRouteInfo<void> {
  const LanguageSetRoute() : super(name, path: '/languageSet');

  static const String name = 'LanguageSetRoute';
}

/// generated route for [_i27.YourPicPage]
class YourPicRoute extends _i29.PageRouteInfo<void> {
  const YourPicRoute() : super(name, path: '/yourPic');

  static const String name = 'YourPicRoute';
}

/// generated route for [_i28.LoginPage]
class LoginRoute extends _i29.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i30.Key? key, void Function(_i30.BuildContext)? onLoginSuccess})
      : super(name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginSuccess: onLoginSuccess));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onLoginSuccess});

  final _i30.Key? key;

  final void Function(_i30.BuildContext)? onLoginSuccess;
}
