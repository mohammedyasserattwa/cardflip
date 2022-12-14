import 'package:cardflip/screens/DeckScreen.dart';
import 'package:cardflip/screens/FlashcardScreen.dart';
import 'package:cardflip/screens/Leaderboard.dart';
import 'package:cardflip/screens/Profile.dart';
import 'package:cardflip/screens/add_flashcards.dart';
import 'package:cardflip/screens/adddeck.dart';
import 'package:cardflip/screens/adminReports.dart';
import 'package:cardflip/screens/adminUsers.dart';
import 'package:cardflip/screens/category.dart';
import 'package:cardflip/screens/editprofile.dart';
import 'package:cardflip/screens/library.dart';
import 'package:cardflip/screens/register.dart';
import 'package:cardflip/screens/search.dart';
import 'package:cardflip/screens/settings.dart';
import 'package:cardflip/screens/Test.dart';
import 'package:cardflip/screens/adminDeck.dart';
import 'package:cardflip/widgets/navibar.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/Login.dart';
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

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  late bool home, library, profile;
  @override
  void initState() {
    home = true;
    library = false;
    profile = false;
    super.initState();
  }

  Widget getScreen() {
    if (home)
      return Home();
    else if (library)
      return Library();
    else
      return Profile();
  }

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
          '/home': (context) => Navigator(),
          '/admin': (context) => Admin(),
          '/adminUsers': (context) => AdminUsers(),
          '/adminReports': (context) => AdminReports(),
          '/deck': (context) => DeckScreen(id: data!["deckID"]),
          '/category': (context) => Category(id: data!["categoryID"]),
          '/flashcards': (context) => Flashcard(id: data!["deckID"]),
          '/leaderboard': (context) => Leaderboard(id: data!["deckID"]),
          '/test': (context) => Test(id: data!["deckID"]),
          '/search': (context) => Search(),
          '/settings': (context) => const Settings(),
          '/addFlashcards': (context) => const AddFlashcards(),
          '/editprofile': (context) => const EditProfile(),
          '/adddeck': (context) => const Adddeck(),
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(builder: (context) => builder(context));
      },
    );
  }

  Scaffold Navigator() {
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
