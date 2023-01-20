import 'package:cardflip/screens/deck/deck_screen.dart';
import 'package:cardflip/screens/flashcards/flashcard_screen.dart';
import 'package:cardflip/screens/deck/leaderboard.dart';
import 'package:cardflip/screens/profile/profile.dart';
import 'package:cardflip/screens/flashcards/add_flashcards.dart';
import 'package:cardflip/screens/deck/add_deck.dart';
import 'package:cardflip/screens/admin/admin_reports.dart';
import 'package:cardflip/screens/admin/admin_users.dart';
import 'package:cardflip/screens/deck/category_screen.dart';
import 'package:cardflip/screens/profile/edit_profile.dart';
import 'package:cardflip/screens/library.dart';
import 'package:cardflip/screens/user/register.dart';
import 'package:cardflip/screens/deck/search.dart';
import 'package:cardflip/screens/user/settings.dart';
import 'package:cardflip/screens/test/test_results.dart';
import 'package:cardflip/screens/others_profile.dart';
import 'package:cardflip/screens/test/test.dart';
import 'package:cardflip/screens/admin/admin_deck.dart';
import 'package:cardflip/widgets/badges/badges.dart';
import 'package:cardflip/widgets/navibar.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/user/login.dart';
import 'screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: Main()));
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        Map<String, dynamic>? data;
        if (settings.arguments != null) {
          data = settings.arguments as Map<String, dynamic>;
        }
        var routes = <String, WidgetBuilder>{
          '/': (context) => const Login(),
          '/register': (context) => const Register(),
          '/home': (context) => Navigation(nav: data?["nav"] ?? 0),
          '/deck': (context) => DeckScreen(deck: data!["deck"]),
          '/category': (context) => CategoryScreen(data: data!["category"]),
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
          '/editdeck': (context) => Adddeck(
                screens: 'edit',
                deck: data!["deck"],
              ),
          '/adminUsers': (context) => AdminUsers(),
          '/adminReports': (context) => AdminReports(),
          '/adminDeck': (context) => Admin(),
          '/othersProfile': (context) => OthersProfile(),
          '/badges': (context) => BadgePopUp(badgeIndex: data!["badgeIndex"]),
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(builder: (context) => builder(context));
      },
    );
  }
}

class Navigation extends StatefulWidget {
  Navigation({super.key, this.nav = 0});
  int nav = 0;
  @override
  State<Navigation> createState() => _NavigatorState();
}

class _NavigatorState extends State<Navigation> {
  late bool home, library, profile;
  @override
  void initState() {
    if (widget.nav == 0) {
      home = true;
      library = false;
      profile = false;
    } else if (widget.nav == 1) {
      home = false;
      library = true;
      profile = false;
    } else {
      home = false;
      library = false;
      profile = true;
    }
    super.initState();
  }

  Widget getScreen() {
    // print("Hena");
    if (home) {
      return Home();
    } else if (library) {
      return const Library();
    } else {
      return Profile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: getScreen(),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xff0D0B26),
        ),
        width: double.infinity,
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () {
                  if (!home) {
                    setState(() {
                      home = true;
                      library = false;
                      profile = false;
                    });
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: NavItem(
                    path: "Images/icons/svg/Home.svg",
                    name: "Home",
                    isActive: home,
                  ),
                )),
            GestureDetector(
                onTap: () {
                  if (!library) {
                    setState(() {
                      home = false;
                      library = true;
                      profile = false;
                    });
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: NavItem(
                    path: "Images/icons/svg/library.svg",
                    name: "Library",
                    isActive: library,
                  ),
                )),
            GestureDetector(
                onTap: () {
                  if (!profile) {
                    setState(() {
                      home = false;
                      library = false;
                      profile = true;
                    });
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: NavItem(
                    path: "Images/icons/svg/profile.svg",
                    name: "Profile",
                    isActive: profile,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
