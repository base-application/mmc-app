// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i41;
import 'package:flutter/cupertino.dart' as _i45;
import 'package:flutter/material.dart' as _i42;
import 'package:flutter/rendering.dart' as _i53;

import '../bean/event_data_item_info_entity.dart' as _i49;
import '../bean/group_item_info_entity.dart' as _i46;
import '../bean/guide_line_entity.dart' as _i51;
import '../bean/network_item_info_entity.dart' as _i47;
import '../bean/newest_item_info_entity.dart' as _i48;
import '../bean/notification_entity.dart' as _i52;
import '../bean/personal_profile_info_entity.dart' as _i50;
import '../bean/referral_entity.dart' as _i44;
import '../screens/advertisement_page.dart' as _i1;
import '../screens/business_profile_create_page.dart' as _i23;
import '../screens/business_profile_set_page.dart' as _i22;
import '../screens/change_password_page.dart' as _i24;
import '../screens/check_history.dart' as _i31;
import '../screens/checkin_page.dart' as _i40;
import '../screens/confirm_password.dart' as _i38;
import '../screens/create_event_page.dart' as _i18;
import '../screens/event_listing_page.dart' as _i9;
import '../screens/event_listing_page_detail.dart' as _i10;
import '../screens/group_page.dart' as _i3;
import '../screens/group_page_detail.dart' as _i4;
import '../screens/guideline_detail_page.dart' as _i26;
import '../screens/guideline_page.dart' as _i25;
import '../screens/home.dart' as _i2;
import '../screens/language_set_page.dart' as _i27;
import '../screens/most_referral_sent_page.dart' as _i17;
import '../screens/my_inbox_detail_page.dart' as _i32;
import '../screens/my_inbox_page.dart' as _i19;
import '../screens/my_network_page.dart' as _i34;
import '../screens/network_page.dart' as _i33;
import '../screens/network_person_page.dart' as _i6;
import '../screens/newest_detail_page.dart' as _i8;
import '../screens/personal_profile_set_page.dart' as _i21;
import '../screens/phone_number_verification.dart' as _i39;
import '../screens/referral_received_contacted_page.dart' as _i12;
import '../screens/referral_received_page.dart' as _i11;
import '../screens/send_thank_you_note_page.dart' as _i13;
import '../screens/sending_referral_page.dart' as _i5;
import '../screens/setting_page.dart' as _i20;
import '../screens/shining_board_detail_page.dart' as _i16;
import '../screens/shining_board_page.dart' as _i15;
import '../screens/sign_in_page.dart' as _i36;
import '../screens/sign_up_page.dart' as _i37;
import '../screens/thank_you_note_received_page.dart' as _i14;
import '../screens/today_newest_page.dart' as _i7;
import '../screens/web_page.dart' as _i30;
import '../screens/welcome_page.dart' as _i35;
import '../screens/your_pic_page.dart' as _i28;
import '../utils/qr_view.dart' as _i29;
import 'auth_guard.dart' as _i43;

class AppRouter extends _i41.RootStackRouter {
  AppRouter(
      {_i42.GlobalKey<_i42.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i43.AuthGuard authGuard;

  @override
  final Map<String, _i41.PageFactory> pagesMap = {
    AdvertisementRoute.name: (routeData) {
      return _i41.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.AdvertisementPage());
    },
    HomeRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i2.HomePage());
    },
    GroupRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i3.GroupPage());
    },
    GroupDetailRoute.name: (routeData) {
      final args = routeData.argsAs<GroupDetailRouteArgs>();
      return _i41.MaterialPageX<String>(
          routeData: routeData,
          child: _i4.GroupDetailPage(key: args.key, info: args.info));
    },
    SendingReferralRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i5.SendingReferralPage());
    },
    NetworkPersonRoute.name: (routeData) {
      final args = routeData.argsAs<NetworkPersonRouteArgs>();
      return _i41.MaterialPageX<String>(
          routeData: routeData,
          child: _i6.NetworkPersonPage(key: args.key, itemInfo: args.itemInfo));
    },
    TodayNewestRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i7.TodayNewestPage());
    },
    NewestDetailRoute.name: (routeData) {
      final args = routeData.argsAs<NewestDetailRouteArgs>();
      return _i41.MaterialPageX<String>(
          routeData: routeData,
          child: _i8.NewestDetailPage(key: args.key, info: args.info));
    },
    EventListingRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i9.EventListingPage());
    },
    EventListingDetailRoute.name: (routeData) {
      final args = routeData.argsAs<EventListingDetailRouteArgs>();
      return _i41.MaterialPageX<String>(
          routeData: routeData,
          child: _i10.EventListingDetailPage(
              key: args.key, eventInfo: args.eventInfo, source: args.source));
    },
    ReferralReceivedRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i11.ReferralReceivedPage());
    },
    ReferralReceivedContactedRoute.name: (routeData) {
      final args = routeData.argsAs<ReferralReceivedContactedRouteArgs>();
      return _i41.MaterialPageX<_i44.ReferralEntity>(
          routeData: routeData,
          child: _i12.ReferralReceivedContactedPage(
              key: args.key, referralEntity: args.referralEntity));
    },
    SendThankYouNoteRoute.name: (routeData) {
      final args = routeData.argsAs<SendThankYouNoteRouteArgs>();
      return _i41.MaterialPageX<bool>(
          routeData: routeData,
          child: _i13.SendThankYouNotePage(
              key: args.key, referralId: args.referralId));
    },
    ThankYouNoteReceivedRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i14.ThankYouNoteReceivedPage());
    },
    ShiningBoardRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i15.ShiningBoardPage());
    },
    ShiningBoardDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ShiningBoardDetailRouteArgs>();
      return _i41.MaterialPageX<String>(
          routeData: routeData,
          child: _i16.ShiningBoardDetailPage(key: args.key, about: args.about));
    },
    MostReferralSentRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i17.MostReferralSentPage());
    },
    CreateEventRoute.name: (routeData) {
      final args = routeData.argsAs<CreateEventRouteArgs>();
      return _i41.MaterialPageX<String>(
          routeData: routeData,
          child: _i18.CreateEventPage(key: args.key, entity: args.entity));
    },
    MyInboxRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i19.MyInboxPage());
    },
    SettingRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i20.SettingPage());
    },
    PersonalProfileSetRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i21.PersonalProfileSetPage());
    },
    BusinessProfileSetRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i22.BusinessProfileSetPage());
    },
    BusinessProfileCreateRoute.name: (routeData) {
      final args = routeData.argsAs<BusinessProfileCreateRouteArgs>(
          orElse: () => const BusinessProfileCreateRouteArgs());
      return _i41.MaterialPageX<String>(
          routeData: routeData,
          child:
              _i23.BusinessProfileCreatePage(key: args.key, info: args.info));
    },
    ChangePasswordRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i24.ChangePasswordPage());
    },
    GuidelineRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i25.GuidelinePage());
    },
    GuidelineDetailRoute.name: (routeData) {
      final args = routeData.argsAs<GuidelineDetailRouteArgs>();
      return _i41.MaterialPageX<String>(
          routeData: routeData,
          child: _i26.GuidelineDetailPage(
              key: args.key, guideLineEntity: args.guideLineEntity));
    },
    LanguageSetRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i27.LanguageSetPage());
    },
    YourPicRoute.name: (routeData) {
      return _i41.MaterialPageX<String>(
          routeData: routeData, child: const _i28.YourPicPage());
    },
    QrViewRoute.name: (routeData) {
      final args = routeData.argsAs<QrViewRouteArgs>();
      return _i41.MaterialPageX<String>(
          routeData: routeData,
          child: _i29.QrViewPage(key: args.key, type: args.type));
    },
    WebRoute.name: (routeData) {
      final args = routeData.argsAs<WebRouteArgs>();
      return _i41.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i30.WebPage(
              key: args.key, title: args.title, initUrl: args.initUrl));
    },
    CheckHistoryRoute.name: (routeData) {
      return _i41.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i31.CheckHistoryPage());
    },
    InboxDetailRoute.name: (routeData) {
      final args = routeData.argsAs<InboxDetailRouteArgs>();
      return _i41.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i32.InboxDetailPage(
              key: args.key, notification: args.notification));
    },
    NetworkRoute.name: (routeData) {
      final args = routeData.argsAs<NetworkRouteArgs>();
      return _i41.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i33.NetworkPage(
              key: args.key,
              pageScrollDirectionChange: args.pageScrollDirectionChange,
              onlyMy: args.onlyMy,
              title: args.title));
    },
    MyNetworkRoute.name: (routeData) {
      return _i41.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i34.MyNetworkPage());
    },
    WelcomeRoute.name: (routeData) {
      return _i41.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i35.WelcomePage());
    },
    SignInRoute.name: (routeData) {
      return _i41.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i36.SignInPage());
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>();
      return _i41.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i37.SignUpPage(key: args.key, type: args.type));
    },
    ConfirmPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ConfirmPasswordRouteArgs>();
      return _i41.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i38.ConfirmPasswordPage(
              key: args.key,
              phoneNumber: args.phoneNumber,
              countryCode: args.countryCode,
              verificationCode: args.verificationCode,
              type: args.type));
    },
    PhoneNumberVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<PhoneNumberVerificationRouteArgs>();
      return _i41.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i39.PhoneNumberVerificationPage(
              key: args.key,
              phoneNumber: args.phoneNumber,
              countryCode: args.countryCode,
              type: args.type));
    },
    CheckInRoute.name: (routeData) {
      final args = routeData.argsAs<CheckInRouteArgs>(
          orElse: () => const CheckInRouteArgs());
      return _i41.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i40.CheckInPage(
              key: args.key,
              pageScrollDirectionChange: args.pageScrollDirectionChange));
    }
  };

  @override
  List<_i41.RouteConfig> get routes => [
        _i41.RouteConfig('/#redirect',
            path: '/', redirectTo: '/advertisement', fullMatch: true),
        _i41.RouteConfig(AdvertisementRoute.name, path: '/advertisement'),
        _i41.RouteConfig(HomeRoute.name, path: '/home'),
        _i41.RouteConfig(GroupRoute.name, path: '/group'),
        _i41.RouteConfig(GroupDetailRoute.name, path: '/groupDetail'),
        _i41.RouteConfig(SendingReferralRoute.name,
            path: '/sendingReferral', guards: [authGuard]),
        _i41.RouteConfig(NetworkPersonRoute.name,
            path: '/networkPerson', guards: [authGuard]),
        _i41.RouteConfig(TodayNewestRoute.name, path: '/todayNewest'),
        _i41.RouteConfig(NewestDetailRoute.name, path: '/newestDetail'),
        _i41.RouteConfig(EventListingRoute.name, path: '/eventListing'),
        _i41.RouteConfig(EventListingDetailRoute.name,
            path: '/eventListingDetail'),
        _i41.RouteConfig(ReferralReceivedRoute.name,
            path: '/referralReceived', guards: [authGuard]),
        _i41.RouteConfig(ReferralReceivedContactedRoute.name,
            path: '/referralReceivedContacted', guards: [authGuard]),
        _i41.RouteConfig(SendThankYouNoteRoute.name,
            path: '/sendThankYouNote', guards: [authGuard]),
        _i41.RouteConfig(ThankYouNoteReceivedRoute.name,
            path: '/thankYouNoteReceived', guards: [authGuard]),
        _i41.RouteConfig(ShiningBoardRoute.name, path: '/shiningBoardPage'),
        _i41.RouteConfig(ShiningBoardDetailRoute.name,
            path: '/shiningBoardDetail', guards: [authGuard]),
        _i41.RouteConfig(MostReferralSentRoute.name, path: '/mostReferralSent'),
        _i41.RouteConfig(CreateEventRoute.name,
            path: '/createEvent', guards: [authGuard]),
        _i41.RouteConfig(MyInboxRoute.name,
            path: '/myInbox', guards: [authGuard]),
        _i41.RouteConfig(SettingRoute.name, path: '/setting'),
        _i41.RouteConfig(PersonalProfileSetRoute.name,
            path: '/personalProfileSet', guards: [authGuard]),
        _i41.RouteConfig(BusinessProfileSetRoute.name,
            path: '/businessProfileSet', guards: [authGuard]),
        _i41.RouteConfig(BusinessProfileCreateRoute.name,
            path: '/businessProfileCreate', guards: [authGuard]),
        _i41.RouteConfig(ChangePasswordRoute.name,
            path: '/changePassword', guards: [authGuard]),
        _i41.RouteConfig(GuidelineRoute.name, path: '/guideline'),
        _i41.RouteConfig(GuidelineDetailRoute.name, path: '/guidelineDetail'),
        _i41.RouteConfig(LanguageSetRoute.name, path: '/languageSet'),
        _i41.RouteConfig(YourPicRoute.name,
            path: '/yourPic', guards: [authGuard]),
        _i41.RouteConfig(QrViewRoute.name,
            path: '/qrview', guards: [authGuard]),
        _i41.RouteConfig(WebRoute.name, path: '/webpage'),
        _i41.RouteConfig(CheckHistoryRoute.name,
            path: '/checkHistory', guards: [authGuard]),
        _i41.RouteConfig(InboxDetailRoute.name,
            path: '/inboxDetail', guards: [authGuard]),
        _i41.RouteConfig(NetworkRoute.name, path: '/network'),
        _i41.RouteConfig(MyNetworkRoute.name,
            path: '/myNetwork', guards: [authGuard]),
        _i41.RouteConfig(WelcomeRoute.name, path: '/welcome'),
        _i41.RouteConfig(SignInRoute.name, path: '/signIn'),
        _i41.RouteConfig(SignUpRoute.name, path: '/signUp'),
        _i41.RouteConfig(ConfirmPasswordRoute.name, path: '/confirmPassword'),
        _i41.RouteConfig(PhoneNumberVerificationRoute.name,
            path: 'phoneNumberVerification'),
        _i41.RouteConfig(CheckInRoute.name,
            path: 'CheckIn', guards: [authGuard])
      ];
}

/// generated route for
/// [_i1.AdvertisementPage]
class AdvertisementRoute extends _i41.PageRouteInfo<void> {
  const AdvertisementRoute()
      : super(AdvertisementRoute.name, path: '/advertisement');

  static const String name = 'AdvertisementRoute';
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i41.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.GroupPage]
class GroupRoute extends _i41.PageRouteInfo<void> {
  const GroupRoute() : super(GroupRoute.name, path: '/group');

  static const String name = 'GroupRoute';
}

/// generated route for
/// [_i4.GroupDetailPage]
class GroupDetailRoute extends _i41.PageRouteInfo<GroupDetailRouteArgs> {
  GroupDetailRoute({_i45.Key? key, required _i46.GroupItemInfoEntity info})
      : super(GroupDetailRoute.name,
            path: '/groupDetail',
            args: GroupDetailRouteArgs(key: key, info: info));

  static const String name = 'GroupDetailRoute';
}

class GroupDetailRouteArgs {
  const GroupDetailRouteArgs({this.key, required this.info});

  final _i45.Key? key;

  final _i46.GroupItemInfoEntity info;

  @override
  String toString() {
    return 'GroupDetailRouteArgs{key: $key, info: $info}';
  }
}

/// generated route for
/// [_i5.SendingReferralPage]
class SendingReferralRoute extends _i41.PageRouteInfo<void> {
  const SendingReferralRoute()
      : super(SendingReferralRoute.name, path: '/sendingReferral');

  static const String name = 'SendingReferralRoute';
}

/// generated route for
/// [_i6.NetworkPersonPage]
class NetworkPersonRoute extends _i41.PageRouteInfo<NetworkPersonRouteArgs> {
  NetworkPersonRoute(
      {_i45.Key? key, required _i47.NetworkItemInfoEntity itemInfo})
      : super(NetworkPersonRoute.name,
            path: '/networkPerson',
            args: NetworkPersonRouteArgs(key: key, itemInfo: itemInfo));

  static const String name = 'NetworkPersonRoute';
}

class NetworkPersonRouteArgs {
  const NetworkPersonRouteArgs({this.key, required this.itemInfo});

  final _i45.Key? key;

  final _i47.NetworkItemInfoEntity itemInfo;

  @override
  String toString() {
    return 'NetworkPersonRouteArgs{key: $key, itemInfo: $itemInfo}';
  }
}

/// generated route for
/// [_i7.TodayNewestPage]
class TodayNewestRoute extends _i41.PageRouteInfo<void> {
  const TodayNewestRoute() : super(TodayNewestRoute.name, path: '/todayNewest');

  static const String name = 'TodayNewestRoute';
}

/// generated route for
/// [_i8.NewestDetailPage]
class NewestDetailRoute extends _i41.PageRouteInfo<NewestDetailRouteArgs> {
  NewestDetailRoute({_i45.Key? key, required _i48.NewestItemInfoEntity info})
      : super(NewestDetailRoute.name,
            path: '/newestDetail',
            args: NewestDetailRouteArgs(key: key, info: info));

  static const String name = 'NewestDetailRoute';
}

class NewestDetailRouteArgs {
  const NewestDetailRouteArgs({this.key, required this.info});

  final _i45.Key? key;

  final _i48.NewestItemInfoEntity info;

  @override
  String toString() {
    return 'NewestDetailRouteArgs{key: $key, info: $info}';
  }
}

/// generated route for
/// [_i9.EventListingPage]
class EventListingRoute extends _i41.PageRouteInfo<void> {
  const EventListingRoute()
      : super(EventListingRoute.name, path: '/eventListing');

  static const String name = 'EventListingRoute';
}

/// generated route for
/// [_i10.EventListingDetailPage]
class EventListingDetailRoute
    extends _i41.PageRouteInfo<EventListingDetailRouteArgs> {
  EventListingDetailRoute(
      {_i45.Key? key,
      required _i49.EventDataItemInfoEntity eventInfo,
      required int source})
      : super(EventListingDetailRoute.name,
            path: '/eventListingDetail',
            args: EventListingDetailRouteArgs(
                key: key, eventInfo: eventInfo, source: source));

  static const String name = 'EventListingDetailRoute';
}

class EventListingDetailRouteArgs {
  const EventListingDetailRouteArgs(
      {this.key, required this.eventInfo, required this.source});

  final _i45.Key? key;

  final _i49.EventDataItemInfoEntity eventInfo;

  final int source;

  @override
  String toString() {
    return 'EventListingDetailRouteArgs{key: $key, eventInfo: $eventInfo, source: $source}';
  }
}

/// generated route for
/// [_i11.ReferralReceivedPage]
class ReferralReceivedRoute extends _i41.PageRouteInfo<void> {
  const ReferralReceivedRoute()
      : super(ReferralReceivedRoute.name, path: '/referralReceived');

  static const String name = 'ReferralReceivedRoute';
}

/// generated route for
/// [_i12.ReferralReceivedContactedPage]
class ReferralReceivedContactedRoute
    extends _i41.PageRouteInfo<ReferralReceivedContactedRouteArgs> {
  ReferralReceivedContactedRoute(
      {_i45.Key? key, required _i44.ReferralEntity referralEntity})
      : super(ReferralReceivedContactedRoute.name,
            path: '/referralReceivedContacted',
            args: ReferralReceivedContactedRouteArgs(
                key: key, referralEntity: referralEntity));

  static const String name = 'ReferralReceivedContactedRoute';
}

class ReferralReceivedContactedRouteArgs {
  const ReferralReceivedContactedRouteArgs(
      {this.key, required this.referralEntity});

  final _i45.Key? key;

  final _i44.ReferralEntity referralEntity;

  @override
  String toString() {
    return 'ReferralReceivedContactedRouteArgs{key: $key, referralEntity: $referralEntity}';
  }
}

/// generated route for
/// [_i13.SendThankYouNotePage]
class SendThankYouNoteRoute
    extends _i41.PageRouteInfo<SendThankYouNoteRouteArgs> {
  SendThankYouNoteRoute({_i45.Key? key, required int referralId})
      : super(SendThankYouNoteRoute.name,
            path: '/sendThankYouNote',
            args: SendThankYouNoteRouteArgs(key: key, referralId: referralId));

  static const String name = 'SendThankYouNoteRoute';
}

class SendThankYouNoteRouteArgs {
  const SendThankYouNoteRouteArgs({this.key, required this.referralId});

  final _i45.Key? key;

  final int referralId;

  @override
  String toString() {
    return 'SendThankYouNoteRouteArgs{key: $key, referralId: $referralId}';
  }
}

/// generated route for
/// [_i14.ThankYouNoteReceivedPage]
class ThankYouNoteReceivedRoute extends _i41.PageRouteInfo<void> {
  const ThankYouNoteReceivedRoute()
      : super(ThankYouNoteReceivedRoute.name, path: '/thankYouNoteReceived');

  static const String name = 'ThankYouNoteReceivedRoute';
}

/// generated route for
/// [_i15.ShiningBoardPage]
class ShiningBoardRoute extends _i41.PageRouteInfo<void> {
  const ShiningBoardRoute()
      : super(ShiningBoardRoute.name, path: '/shiningBoardPage');

  static const String name = 'ShiningBoardRoute';
}

/// generated route for
/// [_i16.ShiningBoardDetailPage]
class ShiningBoardDetailRoute
    extends _i41.PageRouteInfo<ShiningBoardDetailRouteArgs> {
  ShiningBoardDetailRoute({_i45.Key? key, required _i15.ShiningBoardInfo about})
      : super(ShiningBoardDetailRoute.name,
            path: '/shiningBoardDetail',
            args: ShiningBoardDetailRouteArgs(key: key, about: about));

  static const String name = 'ShiningBoardDetailRoute';
}

class ShiningBoardDetailRouteArgs {
  const ShiningBoardDetailRouteArgs({this.key, required this.about});

  final _i45.Key? key;

  final _i15.ShiningBoardInfo about;

  @override
  String toString() {
    return 'ShiningBoardDetailRouteArgs{key: $key, about: $about}';
  }
}

/// generated route for
/// [_i17.MostReferralSentPage]
class MostReferralSentRoute extends _i41.PageRouteInfo<void> {
  const MostReferralSentRoute()
      : super(MostReferralSentRoute.name, path: '/mostReferralSent');

  static const String name = 'MostReferralSentRoute';
}

/// generated route for
/// [_i18.CreateEventPage]
class CreateEventRoute extends _i41.PageRouteInfo<CreateEventRouteArgs> {
  CreateEventRoute(
      {_i45.Key? key, required _i49.EventDataItemInfoEntity? entity})
      : super(CreateEventRoute.name,
            path: '/createEvent',
            args: CreateEventRouteArgs(key: key, entity: entity));

  static const String name = 'CreateEventRoute';
}

class CreateEventRouteArgs {
  const CreateEventRouteArgs({this.key, required this.entity});

  final _i45.Key? key;

  final _i49.EventDataItemInfoEntity? entity;

  @override
  String toString() {
    return 'CreateEventRouteArgs{key: $key, entity: $entity}';
  }
}

/// generated route for
/// [_i19.MyInboxPage]
class MyInboxRoute extends _i41.PageRouteInfo<void> {
  const MyInboxRoute() : super(MyInboxRoute.name, path: '/myInbox');

  static const String name = 'MyInboxRoute';
}

/// generated route for
/// [_i20.SettingPage]
class SettingRoute extends _i41.PageRouteInfo<void> {
  const SettingRoute() : super(SettingRoute.name, path: '/setting');

  static const String name = 'SettingRoute';
}

/// generated route for
/// [_i21.PersonalProfileSetPage]
class PersonalProfileSetRoute extends _i41.PageRouteInfo<void> {
  const PersonalProfileSetRoute()
      : super(PersonalProfileSetRoute.name, path: '/personalProfileSet');

  static const String name = 'PersonalProfileSetRoute';
}

/// generated route for
/// [_i22.BusinessProfileSetPage]
class BusinessProfileSetRoute extends _i41.PageRouteInfo<void> {
  const BusinessProfileSetRoute()
      : super(BusinessProfileSetRoute.name, path: '/businessProfileSet');

  static const String name = 'BusinessProfileSetRoute';
}

/// generated route for
/// [_i23.BusinessProfileCreatePage]
class BusinessProfileCreateRoute
    extends _i41.PageRouteInfo<BusinessProfileCreateRouteArgs> {
  BusinessProfileCreateRoute(
      {_i45.Key? key, _i50.PersonalProfileInfoCompanyVos? info})
      : super(BusinessProfileCreateRoute.name,
            path: '/businessProfileCreate',
            args: BusinessProfileCreateRouteArgs(key: key, info: info));

  static const String name = 'BusinessProfileCreateRoute';
}

class BusinessProfileCreateRouteArgs {
  const BusinessProfileCreateRouteArgs({this.key, this.info});

  final _i45.Key? key;

  final _i50.PersonalProfileInfoCompanyVos? info;

  @override
  String toString() {
    return 'BusinessProfileCreateRouteArgs{key: $key, info: $info}';
  }
}

/// generated route for
/// [_i24.ChangePasswordPage]
class ChangePasswordRoute extends _i41.PageRouteInfo<void> {
  const ChangePasswordRoute()
      : super(ChangePasswordRoute.name, path: '/changePassword');

  static const String name = 'ChangePasswordRoute';
}

/// generated route for
/// [_i25.GuidelinePage]
class GuidelineRoute extends _i41.PageRouteInfo<void> {
  const GuidelineRoute() : super(GuidelineRoute.name, path: '/guideline');

  static const String name = 'GuidelineRoute';
}

/// generated route for
/// [_i26.GuidelineDetailPage]
class GuidelineDetailRoute
    extends _i41.PageRouteInfo<GuidelineDetailRouteArgs> {
  GuidelineDetailRoute(
      {_i45.Key? key, required _i51.GuideLineEntity guideLineEntity})
      : super(GuidelineDetailRoute.name,
            path: '/guidelineDetail',
            args: GuidelineDetailRouteArgs(
                key: key, guideLineEntity: guideLineEntity));

  static const String name = 'GuidelineDetailRoute';
}

class GuidelineDetailRouteArgs {
  const GuidelineDetailRouteArgs({this.key, required this.guideLineEntity});

  final _i45.Key? key;

  final _i51.GuideLineEntity guideLineEntity;

  @override
  String toString() {
    return 'GuidelineDetailRouteArgs{key: $key, guideLineEntity: $guideLineEntity}';
  }
}

/// generated route for
/// [_i27.LanguageSetPage]
class LanguageSetRoute extends _i41.PageRouteInfo<void> {
  const LanguageSetRoute() : super(LanguageSetRoute.name, path: '/languageSet');

  static const String name = 'LanguageSetRoute';
}

/// generated route for
/// [_i28.YourPicPage]
class YourPicRoute extends _i41.PageRouteInfo<void> {
  const YourPicRoute() : super(YourPicRoute.name, path: '/yourPic');

  static const String name = 'YourPicRoute';
}

/// generated route for
/// [_i29.QrViewPage]
class QrViewRoute extends _i41.PageRouteInfo<QrViewRouteArgs> {
  QrViewRoute({_i45.Key? key, required int type})
      : super(QrViewRoute.name,
            path: '/qrview', args: QrViewRouteArgs(key: key, type: type));

  static const String name = 'QrViewRoute';
}

class QrViewRouteArgs {
  const QrViewRouteArgs({this.key, required this.type});

  final _i45.Key? key;

  final int type;

  @override
  String toString() {
    return 'QrViewRouteArgs{key: $key, type: $type}';
  }
}

/// generated route for
/// [_i30.WebPage]
class WebRoute extends _i41.PageRouteInfo<WebRouteArgs> {
  WebRoute({_i45.Key? key, required String title, required String initUrl})
      : super(WebRoute.name,
            path: '/webpage',
            args: WebRouteArgs(key: key, title: title, initUrl: initUrl));

  static const String name = 'WebRoute';
}

class WebRouteArgs {
  const WebRouteArgs({this.key, required this.title, required this.initUrl});

  final _i45.Key? key;

  final String title;

  final String initUrl;

  @override
  String toString() {
    return 'WebRouteArgs{key: $key, title: $title, initUrl: $initUrl}';
  }
}

/// generated route for
/// [_i31.CheckHistoryPage]
class CheckHistoryRoute extends _i41.PageRouteInfo<void> {
  const CheckHistoryRoute()
      : super(CheckHistoryRoute.name, path: '/checkHistory');

  static const String name = 'CheckHistoryRoute';
}

/// generated route for
/// [_i32.InboxDetailPage]
class InboxDetailRoute extends _i41.PageRouteInfo<InboxDetailRouteArgs> {
  InboxDetailRoute(
      {_i45.Key? key, required _i52.NotificationEntity notification})
      : super(InboxDetailRoute.name,
            path: '/inboxDetail',
            args: InboxDetailRouteArgs(key: key, notification: notification));

  static const String name = 'InboxDetailRoute';
}

class InboxDetailRouteArgs {
  const InboxDetailRouteArgs({this.key, required this.notification});

  final _i45.Key? key;

  final _i52.NotificationEntity notification;

  @override
  String toString() {
    return 'InboxDetailRouteArgs{key: $key, notification: $notification}';
  }
}

/// generated route for
/// [_i33.NetworkPage]
class NetworkRoute extends _i41.PageRouteInfo<NetworkRouteArgs> {
  NetworkRoute(
      {_i45.Key? key,
      dynamic Function(_i53.ScrollDirection)? pageScrollDirectionChange,
      required bool onlyMy,
      required String title})
      : super(NetworkRoute.name,
            path: '/network',
            args: NetworkRouteArgs(
                key: key,
                pageScrollDirectionChange: pageScrollDirectionChange,
                onlyMy: onlyMy,
                title: title));

  static const String name = 'NetworkRoute';
}

class NetworkRouteArgs {
  const NetworkRouteArgs(
      {this.key,
      this.pageScrollDirectionChange,
      required this.onlyMy,
      required this.title});

  final _i45.Key? key;

  final dynamic Function(_i53.ScrollDirection)? pageScrollDirectionChange;

  final bool onlyMy;

  final String title;

  @override
  String toString() {
    return 'NetworkRouteArgs{key: $key, pageScrollDirectionChange: $pageScrollDirectionChange, onlyMy: $onlyMy, title: $title}';
  }
}

/// generated route for
/// [_i34.MyNetworkPage]
class MyNetworkRoute extends _i41.PageRouteInfo<void> {
  const MyNetworkRoute() : super(MyNetworkRoute.name, path: '/myNetwork');

  static const String name = 'MyNetworkRoute';
}

/// generated route for
/// [_i35.WelcomePage]
class WelcomeRoute extends _i41.PageRouteInfo<void> {
  const WelcomeRoute() : super(WelcomeRoute.name, path: '/welcome');

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i36.SignInPage]
class SignInRoute extends _i41.PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/signIn');

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i37.SignUpPage]
class SignUpRoute extends _i41.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({_i45.Key? key, required int type})
      : super(SignUpRoute.name,
            path: '/signUp', args: SignUpRouteArgs(key: key, type: type));

  static const String name = 'SignUpRoute';
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key, required this.type});

  final _i45.Key? key;

  final int type;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key, type: $type}';
  }
}

/// generated route for
/// [_i38.ConfirmPasswordPage]
class ConfirmPasswordRoute
    extends _i41.PageRouteInfo<ConfirmPasswordRouteArgs> {
  ConfirmPasswordRoute(
      {_i45.Key? key,
      required String phoneNumber,
      required String countryCode,
      required String verificationCode,
      required int type})
      : super(ConfirmPasswordRoute.name,
            path: '/confirmPassword',
            args: ConfirmPasswordRouteArgs(
                key: key,
                phoneNumber: phoneNumber,
                countryCode: countryCode,
                verificationCode: verificationCode,
                type: type));

  static const String name = 'ConfirmPasswordRoute';
}

class ConfirmPasswordRouteArgs {
  const ConfirmPasswordRouteArgs(
      {this.key,
      required this.phoneNumber,
      required this.countryCode,
      required this.verificationCode,
      required this.type});

  final _i45.Key? key;

  final String phoneNumber;

  final String countryCode;

  final String verificationCode;

  final int type;

  @override
  String toString() {
    return 'ConfirmPasswordRouteArgs{key: $key, phoneNumber: $phoneNumber, countryCode: $countryCode, verificationCode: $verificationCode, type: $type}';
  }
}

/// generated route for
/// [_i39.PhoneNumberVerificationPage]
class PhoneNumberVerificationRoute
    extends _i41.PageRouteInfo<PhoneNumberVerificationRouteArgs> {
  PhoneNumberVerificationRoute(
      {_i45.Key? key,
      required String phoneNumber,
      required String countryCode,
      required int type})
      : super(PhoneNumberVerificationRoute.name,
            path: 'phoneNumberVerification',
            args: PhoneNumberVerificationRouteArgs(
                key: key,
                phoneNumber: phoneNumber,
                countryCode: countryCode,
                type: type));

  static const String name = 'PhoneNumberVerificationRoute';
}

class PhoneNumberVerificationRouteArgs {
  const PhoneNumberVerificationRouteArgs(
      {this.key,
      required this.phoneNumber,
      required this.countryCode,
      required this.type});

  final _i45.Key? key;

  final String phoneNumber;

  final String countryCode;

  final int type;

  @override
  String toString() {
    return 'PhoneNumberVerificationRouteArgs{key: $key, phoneNumber: $phoneNumber, countryCode: $countryCode, type: $type}';
  }
}

/// generated route for
/// [_i40.CheckInPage]
class CheckInRoute extends _i41.PageRouteInfo<CheckInRouteArgs> {
  CheckInRoute(
      {_i45.Key? key,
      dynamic Function(_i53.ScrollDirection)? pageScrollDirectionChange})
      : super(CheckInRoute.name,
            path: 'CheckIn',
            args: CheckInRouteArgs(
                key: key,
                pageScrollDirectionChange: pageScrollDirectionChange));

  static const String name = 'CheckInRoute';
}

class CheckInRouteArgs {
  const CheckInRouteArgs({this.key, this.pageScrollDirectionChange});

  final _i45.Key? key;

  final dynamic Function(_i53.ScrollDirection)? pageScrollDirectionChange;

  @override
  String toString() {
    return 'CheckInRouteArgs{key: $key, pageScrollDirectionChange: $pageScrollDirectionChange}';
  }
}
