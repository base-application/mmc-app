import 'package:auto_route/annotations.dart';
import 'package:mmc/bean/referral_entity.dart';
import 'package:mmc/screens/business_profile_create_page.dart';
import 'package:mmc/screens/business_profile_set_page.dart';
import 'package:mmc/screens/change_password_page.dart';
import 'package:mmc/screens/check_history.dart';
import 'package:mmc/screens/create_event_page.dart';
import 'package:mmc/screens/event_listing_page.dart';
import 'package:mmc/screens/event_listing_page_detail.dart';
import 'package:mmc/screens/group_page.dart';
import 'package:mmc/screens/group_page_detail.dart';
import 'package:mmc/screens/guideline_detail_page.dart';
import 'package:mmc/screens/guideline_page.dart';
import 'package:mmc/screens/home.dart';
import 'package:mmc/screens/language_set_page.dart';
import 'package:mmc/screens/login.dart';
import 'package:mmc/screens/most_referral_sent_page.dart';
import 'package:mmc/screens/my_inbox_detail_page.dart';
import 'package:mmc/screens/my_inbox_page.dart';
import 'package:mmc/screens/my_network_page.dart';
import 'package:mmc/screens/network_page.dart';
import 'package:mmc/screens/network_person_page.dart';
import 'package:mmc/screens/newest_detail_page.dart';
import 'package:mmc/screens/personal_profile_set_page.dart';
import 'package:mmc/screens/referral_received_contacted_page.dart';
import 'package:mmc/screens/referral_received_page.dart';
import 'package:mmc/screens/send_thank_you_note_page.dart';
import 'package:mmc/screens/sending_referral_page.dart';
import 'package:mmc/screens/setting_page.dart';
import 'package:mmc/screens/shining_board_detail_page.dart';
import 'package:mmc/screens/shining_board_page.dart';
import 'package:mmc/screens/thank_you_note_received_page.dart';
import 'package:mmc/screens/today_newest_page.dart';
import 'package:mmc/screens/web_page.dart';
import 'package:mmc/screens/your_pic_page.dart';
import 'package:mmc/utils/qr_view.dart';

import 'auth_guard.dart';

/// flutter packages pub run build_runner build
/// flutter packages pub run build_runner watch
@MaterialAutoRouter(
  replaceInRouteName: 'Page|Dialog,Route',
  routes: <AutoRoute>[
    AutoRoute<String>(
      path: '/',
      page: HomePage,
      guards: [
        AuthGuard,
      ],
    ),
    AutoRoute<String>(page: GroupPage, path: '/group'),
    AutoRoute<String>(page: GroupDetailPage, path: '/groupDetail'),
    AutoRoute<String>(page: SendingReferralPage, path: '/sendingReferral'),
    AutoRoute<String>(page: NetworkPersonPage, path: '/networkPerson'),
    AutoRoute<String>(page: TodayNewestPage, path: '/todayNewest'),
    AutoRoute<String>(page: NewestDetailPage, path: '/newestDetail'),
    AutoRoute<String>(page: EventListingPage, path: '/eventListing'),
    AutoRoute<String>(page: EventListingDetailPage, path: '/eventListingDetail'),
    AutoRoute<String>(page: ReferralReceivedPage, path: '/referralReceived'),
    AutoRoute<ReferralEntity>(page: ReferralReceivedContactedPage, path: '/referralReceivedContacted'),
    AutoRoute<bool>(page: SendThankYouNotePage, path: '/sendThankYouNote'),
    AutoRoute<String>(page: ThankYouNoteReceivedPage, path: '/thankYouNoteReceived'),
    AutoRoute<String>(page: ShiningBoardPage, path: '/shiningBoardPage'),
    AutoRoute<String>(page: ShiningBoardDetailPage, path: '/shiningBoardDetail'),
    AutoRoute<String>(page: MostReferralSentPage, path: '/mostReferralSent'),
    AutoRoute<String>(page: CreateEventPage, path: '/createEvent'),
    AutoRoute<String>(page: MyInboxPage, path: '/myInbox'),
    AutoRoute<String>(page: SettingPage, path: '/setting'),
    AutoRoute<String>(page: PersonalProfileSetPage, path: '/personalProfileSet'),
    AutoRoute<String>(page: BusinessProfileSetPage, path: '/businessProfileSet'),
    AutoRoute<String>(page: BusinessProfileCreatePage, path: '/businessProfileCreate'),
    AutoRoute<String>(page: ChangePasswordPage, path: '/changePassword'),
    AutoRoute<String>(page: GuidelinePage, path: '/guideline'),
    AutoRoute<String>(page: GuidelineDetailPage, path: '/guidelineDetail'),
    AutoRoute<String>(page: LanguageSetPage, path: '/languageSet'),
    AutoRoute<String>(page: YourPicPage, path: '/yourPic'),
    // auth
    AutoRoute<String>(page: LoginPage, path: '/login'),
    AutoRoute<String>(page: QrViewPage, path: '/qrview'),
    AutoRoute(page: WebPage, path: '/webpage'),
    AutoRoute(page: CheckHistoryPage, path: '/checkHistory'),
    AutoRoute(page: InboxDetailPage, path: '/inboxDetail'),
    AutoRoute(page: NetworkPage, path: '/network'),
    AutoRoute(page: MyNetworkPage, path: '/myNetwork'),
  ],
)
class $AppRouter {}
