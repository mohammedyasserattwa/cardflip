import 'dart:collection';
import 'package:cardflip/data/badge.dart';
import 'package:cardflip/data/deck.dart';
import 'package:cardflip/models/badges_model.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:recase/recase.dart';

class BadgePopUp extends StatefulWidget {
  final Future<Map<String, bool>> badgecheck;
  BadgesModel badge;
  Deck? deck;

  BadgePopUp(
      {required this.badgecheck, required this.badge, required this.deck});
  BadgePopUp.nodeck({
    required this.badgecheck,
    required this.badge,
  });
  @override
  _BadgePopUpState createState() => _BadgePopUpState();
}

class _BadgePopUpState extends State<BadgePopUp> {
  Queue<Badge> badgeQueue = Queue();
  bool showingDialog = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.badgecheck,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          var badgeCheck = snapshot.data;
          for (var key in badgeCheck.keys) {
            if (badgeCheck[key] == true) {
              int id = widget.badge.badges.indexWhere((e) {
                return e.id == key;
              });
              if (id != -1) {
                badgeQueue.add(widget.badge.badges[id]);
              }
            }
          }
          if (badgeQueue.isNotEmpty && showingDialog) {
            showingDialog = false;
            Badge currentBadge = badgeQueue.removeFirst();
            widget.badgecheck.then((value) {
              value.removeWhere((key, value) {
                return key == currentBadge.id;
              });

              return value;
            });
            Future.delayed(Duration.zero, () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      title: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          (widget.deck != null)
                              ? Text("Achievement Unlocked!")
                              : SizedBox(height: 10),
                          SizedBox(height: 10),
                          Text(
                            currentBadge.title,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 5),
                          Image.asset(
                              'Images/vectors/badges/' +
                                  currentBadge.image +
                                  '.png',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover),
                          SizedBox(height: 15),
                          Center(
                              child: Text(
                                  currentBadge.description,
                                  textAlign: TextAlign.center)),
                          SizedBox(height: 25),
                          Center(
                              child: GestureDetector(
                            child: Container(
                              width: 100,
                              height: 40,
                              child: Text(
                                'Close',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () {
                              // if deck empty pop bs
                              Navigator.pop(context);
                              if (badgeQueue.isEmpty) {
                                if (widget.deck == null) {
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, '/deck',
                                      arguments: {"deck": widget.deck});
                                }
                                showingDialog = false;
                              } else {
                                if (widget.deck == null) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return BadgePopUp.nodeck(
                                            badgecheck: widget.badgecheck,
                                            badge: widget.badge);
                                      });
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return BadgePopUp(
                                            badgecheck: widget.badgecheck,
                                            badge: widget.badge,
                                            deck: widget.deck);
                                      });
                                }
                                setState(() {});
                              }
                            },
                          )),
                        ],
                      ),
                    );
                  });
            });
          }
        }
        return Container();
      },
    );
  }
}
