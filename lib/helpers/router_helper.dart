import 'package:cardflip/screens/user/login.dart';
import 'package:cardflip/screens/user/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:cardflip/screens/deck/deck_screen.dart';
import 'package:cardflip/screens/flashcards/flashcard_screen.dart';
import 'package:cardflip/screens/deck/leaderboard.dart';
import 'package:cardflip/screens/flashcards/add_flashcards.dart';
import 'package:cardflip/screens/deck/add_deck.dart';
import 'package:cardflip/screens/admin/admin_reports.dart';
import 'package:cardflip/screens/admin/admin_users.dart';
import 'package:cardflip/screens/deck/category_screen.dart';
import 'package:cardflip/screens/profile/edit_profile.dart';
import 'package:cardflip/screens/user/edit_credential_screen.dart';
import 'package:cardflip/screens/user/navigation.dart';
import 'package:cardflip/screens/user/register.dart';
import 'package:cardflip/screens/deck/search.dart';
import 'package:cardflip/screens/user/settings.dart';
import 'package:cardflip/screens/test/test_results.dart';
import 'package:cardflip/screens/profile/others_profile.dart';
import 'package:cardflip/screens/test/test.dart';
import 'package:cardflip/screens/admin/admin_deck.dart';
import 'package:cardflip/widgets/badges/badges.dart';

class RouterHelper {
  static generateRoute(RouteSettings settings) {
    Map<String, dynamic>? data;
    if (settings.arguments != null) {
      data = settings.arguments as Map<String, dynamic>;
    }
    var routes = <String, WidgetBuilder>{
      '/': (context) => const Login(),
      '/register': (context) => const Register(),
      '/home': (context) => Navigation(nav: data?["nav"] ?? 0),
      '/deck': (context) => DeckScreen(
            deck: data!["deck"],
            backhome: data["backhome"] ?? false,
          ),
      '/category': (context) => CategoryScreen(
          data: data!["category"], backhome: data["backhome"] ?? false),
      '/flashcards': (context) => Flashcard(deck: data!["deck"]),
      '/leaderboard': (context) => Leaderboard(deck: data!["deck"]),
      '/test': (context) => Test(deck: data!["deck"]),
      '/testresults': (context) => TestResults(model: data!["model"]),
      '/search': (context) => Search(),
      '/settings': (context) => const Settings(),
      '/addFlashcards': (context) => AddFlashcards(deck: data!["deck"]),
      '/editprofile': (context) => const EditProfile(),
      '/adddeck': (context) => const Adddeck(
            screens: 'add',
          ),
      '/editCredentials': (context) => const EditCredentials(),
      '/editdeck': (context) => Adddeck(
            screens: 'edit',
            deck: data!["deck"],
          ),
      '/adminUsers': (context) => AdminUsers(),
      '/adminReports': (context) => AdminReports(),
      '/adminDeck': (context) => const Admin(),
      '/othersProfile': (context) => OthersProfile(id: data!["id"]),
      '/badges': (context) => BadgePopUp(
          badgecheck: data!["badgecheck"],
          badge: data["badge"],
          deck: data["deck"]),
      "/verifyEmail": (context) => const VerifyEmail(),
    };
    WidgetBuilder builder = routes[settings.name]!;
    return MaterialPageRoute(builder: (context) => builder(context));
  }
}
