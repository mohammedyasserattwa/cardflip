import '../data/card.dart';
import '../data/category.dart';
import '../data/deck.dart';

class UserModel {
  // TODO: Get the user document ID
  // TODO: Get the user personal Information
  // TODO: Get the user favourite decks
  // Get the user chosen Categories
  List<List<Deck>> categoryDecks = [
    [
      Deck(
          name: "Meteorology",
          description:
              "Some vocabulary terms and definitions related to meteorology",
          author: "Lara",
          id: "1",
          rating: 4099,
          cards: [
            Card(
                id: 0,
                term: "Air Mass",
                definition:
                    "a huge body of air that has similar temperature, humidity, and air pressure at any given height"),
            Card(
                id: 1,
                term: "Continental Polar",
                definition: "cold, dry air mass that forms over land"),
            Card(
                id: 2,
                term: "Continental Tropical",
                definition: "warm, dry air mass that forms over land"),
            Card(
                id: 3,
                term: "Maritime Polar",
                definition: "cold, moist air mass that forms over cold oceans"),
            Card(
                id: 4,
                term: "Maritime Tropical",
                definition: "warm, moist air mass that is formed over water"),
            Card(
                id: 5,
                term: "Continental Arctic",
                definition: "very cold, very dry air mass"),
          ]),
      Deck(
          name: "Astronomy",
          description:
              "Some vocabulary terms and definitions related to astronomy",
          author: "Yasser",
          id: "2",
          rating: 2949,
          cards: [
            Card(
                id: 0,
                term: "Satellite",
                definition:
                    "An object that revolves around another object in space"),
            Card(
                id: 1,
                term: "Orbiter",
                definition:
                    "The main part of the space shuttle that has wings like an airplane."),
            Card(
                id: 2,
                term: "Astronaut milestones",
                definition:
                    "Having a goal that is out of the ordinary, or will be extremely hard to accomplish, or having the milestone goal for more than five years."),
            Card(
                id: 3,
                term: "Revolution",
                definition: "The movement of an object around another object"),
            Card(
                id: 4,
                term: "Horizon",
                definition:
                    "the line at which the sky and Earth appear to meet"),
          ]),
      Deck(
          name: "Computer Science",
          description:
              "Some vocabulary terms and definitions related to Computer Science",
          author: "Omar",
          id: "3",
          userID: "01f4bll5",
          rating: 3000,
          cards: [
            Card(
                id: 0,
                term: "Central Processing Unit (CPU)",
                definition:
                    "Brain of the computer that performs instructions defined by software"),
            Card(
                id: 1,
                term: "Operating System (OS)",
                definition:
                    "Software used to control the computer and its peripheral equipment."),
            Card(
                id: 2,
                term: "Software",
                definition:
                    "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
            Card(
                id: 3,
                term: "Hardware",
                definition:
                    "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
            Card(
                id: 4,
                term: "Machine Language",
                definition: "Programs written in binary code"),
          ])
    ],
    [
      Deck(
          name: "Meteorology",
          description:
              "Some vocabulary terms and definitions related to meteorology",
          author: "Lara",
          id: "1",
          rating: 4099,
          cards: [
            Card(
                id: 0,
                term: "Air Mass",
                definition:
                    "a huge body of air that has similar temperature, humidity, and air pressure at any given height"),
            Card(
                id: 1,
                term: "Continental Polar",
                definition: "cold, dry air mass that forms over land"),
            Card(
                id: 2,
                term: "Continental Tropical",
                definition: "warm, dry air mass that forms over land"),
            Card(
                id: 3,
                term: "Maritime Polar",
                definition: "cold, moist air mass that forms over cold oceans"),
            Card(
                id: 4,
                term: "Maritime Tropical",
                definition: "warm, moist air mass that is formed over water"),
            Card(
                id: 5,
                term: "Continental Arctic",
                definition: "very cold, very dry air mass"),
          ]),
      Deck(
          name: "Astronomy",
          description:
              "Some vocabulary terms and definitions related to astronomy",
          author: "Yasser",
          id: "2",
          rating: 2949,
          cards: [
            Card(
                id: 0,
                term: "Satellite",
                definition:
                    "An object that revolves around another object in space"),
            Card(
                id: 1,
                term: "Orbiter",
                definition:
                    "The main part of the space shuttle that has wings like an airplane."),
            Card(
                id: 2,
                term: "Astronaut milestones",
                definition:
                    "Having a goal that is out of the ordinary, or will be extremely hard to accomplish, or having the milestone goal for more than five years."),
            Card(
                id: 3,
                term: "Revolution",
                definition: "The movement of an object around another object"),
            Card(
                id: 4,
                term: "Horizon",
                definition:
                    "the line at which the sky and Earth appear to meet"),
          ]),
      Deck(
          name: "Computer Science",
          description:
              "Some vocabulary terms and definitions related to Computer Science",
          author: "Omar",
          id: "3",
          userID: "01f4bll5",
          rating: 3000,
          cards: [
            Card(
                id: 0,
                term: "Central Processing Unit (CPU)",
                definition:
                    "Brain of the computer that performs instructions defined by software"),
            Card(
                id: 1,
                term: "Operating System (OS)",
                definition:
                    "Software used to control the computer and its peripheral equipment."),
            Card(
                id: 2,
                term: "Software",
                definition:
                    "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
            Card(
                id: 3,
                term: "Hardware",
                definition:
                    "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
            Card(
                id: 4,
                term: "Machine Language",
                definition: "Programs written in binary code"),
          ])
    ],
    [
      Deck(
          name: "Meteorology",
          description:
              "Some vocabulary terms and definitions related to meteorology",
          author: "Lara",
          id: "1",
          rating: 4099,
          cards: [
            Card(
                id: 0,
                term: "Air Mass",
                definition:
                    "a huge body of air that has similar temperature, humidity, and air pressure at any given height"),
            Card(
                id: 1,
                term: "Continental Polar",
                definition: "cold, dry air mass that forms over land"),
            Card(
                id: 2,
                term: "Continental Tropical",
                definition: "warm, dry air mass that forms over land"),
            Card(
                id: 3,
                term: "Maritime Polar",
                definition: "cold, moist air mass that forms over cold oceans"),
            Card(
                id: 4,
                term: "Maritime Tropical",
                definition: "warm, moist air mass that is formed over water"),
            Card(
                id: 5,
                term: "Continental Arctic",
                definition: "very cold, very dry air mass"),
          ]),
      Deck(
          name: "Astronomy",
          description:
              "Some vocabulary terms and definitions related to astronomy",
          author: "Yasser",
          id: "2",
          rating: 2949,
          cards: [
            Card(
                id: 0,
                term: "Satellite",
                definition:
                    "An object that revolves around another object in space"),
            Card(
                id: 1,
                term: "Orbiter",
                definition:
                    "The main part of the space shuttle that has wings like an airplane."),
            Card(
                id: 2,
                term: "Astronaut milestones",
                definition:
                    "Having a goal that is out of the ordinary, or will be extremely hard to accomplish, or having the milestone goal for more than five years."),
            Card(
                id: 3,
                term: "Revolution",
                definition: "The movement of an object around another object"),
            Card(
                id: 4,
                term: "Horizon",
                definition:
                    "the line at which the sky and Earth appear to meet"),
          ]),
      Deck(
          name: "Computer Science",
          description:
              "Some vocabulary terms and definitions related to Computer Science",
          author: "Omar",
          id: "3",
          userID: "01f4bll5",
          rating: 3000,
          cards: [
            Card(
                id: 0,
                term: "Central Processing Unit (CPU)",
                definition:
                    "Brain of the computer that performs instructions defined by software"),
            Card(
                id: 1,
                term: "Operating System (OS)",
                definition:
                    "Software used to control the computer and its peripheral equipment."),
            Card(
                id: 2,
                term: "Software",
                definition:
                    "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
            Card(
                id: 3,
                term: "Hardware",
                definition:
                    "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
            Card(
                id: 4,
                term: "Machine Language",
                definition: "Programs written in binary code"),
          ])
    ],
    [
      Deck(
          name: "Meteorology",
          description:
              "Some vocabulary terms and definitions related to meteorology",
          author: "Lara",
          id: "1",
          rating: 4099,
          cards: [
            Card(
                id: 0,
                term: "Air Mass",
                definition:
                    "a huge body of air that has similar temperature, humidity, and air pressure at any given height"),
            Card(
                id: 1,
                term: "Continental Polar",
                definition: "cold, dry air mass that forms over land"),
            Card(
                id: 2,
                term: "Continental Tropical",
                definition: "warm, dry air mass that forms over land"),
            Card(
                id: 3,
                term: "Maritime Polar",
                definition: "cold, moist air mass that forms over cold oceans"),
            Card(
                id: 4,
                term: "Maritime Tropical",
                definition: "warm, moist air mass that is formed over water"),
            Card(
                id: 5,
                term: "Continental Arctic",
                definition: "very cold, very dry air mass"),
          ]),
      Deck(
          name: "Astronomy",
          description:
              "Some vocabulary terms and definitions related to astronomy",
          author: "Yasser",
          id: "2",
          rating: 2949,
          cards: [
            Card(
                id: 0,
                term: "Satellite",
                definition:
                    "An object that revolves around another object in space"),
            Card(
                id: 1,
                term: "Orbiter",
                definition:
                    "The main part of the space shuttle that has wings like an airplane."),
            Card(
                id: 2,
                term: "Astronaut milestones",
                definition:
                    "Having a goal that is out of the ordinary, or will be extremely hard to accomplish, or having the milestone goal for more than five years."),
            Card(
                id: 3,
                term: "Revolution",
                definition: "The movement of an object around another object"),
            Card(
                id: 4,
                term: "Horizon",
                definition:
                    "the line at which the sky and Earth appear to meet"),
          ]),
      Deck(
          name: "Computer Science",
          description:
              "Some vocabulary terms and definitions related to Computer Science",
          author: "Omar",
          id: "3",
          userID: "01f4bll5",
          rating: 3000,
          cards: [
            Card(
                id: 0,
                term: "Central Processing Unit (CPU)",
                definition:
                    "Brain of the computer that performs instructions defined by software"),
            Card(
                id: 1,
                term: "Operating System (OS)",
                definition:
                    "Software used to control the computer and its peripheral equipment."),
            Card(
                id: 2,
                term: "Software",
                definition:
                    "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
            Card(
                id: 3,
                term: "Hardware",
                definition:
                    "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
            Card(
                id: 4,
                term: "Machine Language",
                definition: "Programs written in binary code"),
          ])
    ],
    [
      Deck(
          name: "Meteorology",
          description:
              "Some vocabulary terms and definitions related to meteorology",
          author: "Lara",
          id: "1",
          rating: 4099,
          cards: [
            Card(
                id: 0,
                term: "Air Mass",
                definition:
                    "a huge body of air that has similar temperature, humidity, and air pressure at any given height"),
            Card(
                id: 1,
                term: "Continental Polar",
                definition: "cold, dry air mass that forms over land"),
            Card(
                id: 2,
                term: "Continental Tropical",
                definition: "warm, dry air mass that forms over land"),
            Card(
                id: 3,
                term: "Maritime Polar",
                definition: "cold, moist air mass that forms over cold oceans"),
            Card(
                id: 4,
                term: "Maritime Tropical",
                definition: "warm, moist air mass that is formed over water"),
            Card(
                id: 5,
                term: "Continental Arctic",
                definition: "very cold, very dry air mass"),
          ]),
      Deck(
          name: "Astronomy",
          description:
              "Some vocabulary terms and definitions related to astronomy",
          author: "Yasser",
          id: "2",
          rating: 2949,
          cards: [
            Card(
                id: 0,
                term: "Satellite",
                definition:
                    "An object that revolves around another object in space"),
            Card(
                id: 1,
                term: "Orbiter",
                definition:
                    "The main part of the space shuttle that has wings like an airplane."),
            Card(
                id: 2,
                term: "Astronaut milestones",
                definition:
                    "Having a goal that is out of the ordinary, or will be extremely hard to accomplish, or having the milestone goal for more than five years."),
            Card(
                id: 3,
                term: "Revolution",
                definition: "The movement of an object around another object"),
            Card(
                id: 4,
                term: "Horizon",
                definition:
                    "the line at which the sky and Earth appear to meet"),
          ]),
      Deck(
          name: "Computer Science",
          description:
              "Some vocabulary terms and definitions related to Computer Science",
          author: "Omar",
          id: "3",
          userID: "01f4bll5",
          rating: 3000,
          cards: [
            Card(
                id: 0,
                term: "Central Processing Unit (CPU)",
                definition:
                    "Brain of the computer that performs instructions defined by software"),
            Card(
                id: 1,
                term: "Operating System (OS)",
                definition:
                    "Software used to control the computer and its peripheral equipment."),
            Card(
                id: 2,
                term: "Software",
                definition:
                    "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
            Card(
                id: 3,
                term: "Hardware",
                definition:
                    "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
            Card(
                id: 4,
                term: "Machine Language",
                definition: "Programs written in binary code"),
          ])
    ],
    [
      Deck(
          name: "Meteorology",
          description:
              "Some vocabulary terms and definitions related to meteorology",
          author: "Lara",
          id: "1",
          rating: 4099,
          cards: [
            Card(
                id: 0,
                term: "Air Mass",
                definition:
                    "a huge body of air that has similar temperature, humidity, and air pressure at any given height"),
            Card(
                id: 1,
                term: "Continental Polar",
                definition: "cold, dry air mass that forms over land"),
            Card(
                id: 2,
                term: "Continental Tropical",
                definition: "warm, dry air mass that forms over land"),
            Card(
                id: 3,
                term: "Maritime Polar",
                definition: "cold, moist air mass that forms over cold oceans"),
            Card(
                id: 4,
                term: "Maritime Tropical",
                definition: "warm, moist air mass that is formed over water"),
            Card(
                id: 5,
                term: "Continental Arctic",
                definition: "very cold, very dry air mass"),
          ]),
      Deck(
          name: "Astronomy",
          description:
              "Some vocabulary terms and definitions related to astronomy",
          author: "Yasser",
          id: "2",
          rating: 2949,
          cards: [
            Card(
                id: 0,
                term: "Satellite",
                definition:
                    "An object that revolves around another object in space"),
            Card(
                id: 1,
                term: "Orbiter",
                definition:
                    "The main part of the space shuttle that has wings like an airplane."),
            Card(
                id: 2,
                term: "Astronaut milestones",
                definition:
                    "Having a goal that is out of the ordinary, or will be extremely hard to accomplish, or having the milestone goal for more than five years."),
            Card(
                id: 3,
                term: "Revolution",
                definition: "The movement of an object around another object"),
            Card(
                id: 4,
                term: "Horizon",
                definition:
                    "the line at which the sky and Earth appear to meet"),
          ]),
      Deck(
          name: "Computer Science",
          description:
              "Some vocabulary terms and definitions related to Computer Science",
          author: "Omar",
          id: "3",
          userID: "01f4bll5",
          rating: 3000,
          cards: [
            Card(
                id: 0,
                term: "Central Processing Unit (CPU)",
                definition:
                    "Brain of the computer that performs instructions defined by software"),
            Card(
                id: 1,
                term: "Operating System (OS)",
                definition:
                    "Software used to control the computer and its peripheral equipment."),
            Card(
                id: 2,
                term: "Software",
                definition:
                    "Set of instructions that tells the hardware what to do. It is what guides the hardware and tells it how to accomplish each task."),
            Card(
                id: 3,
                term: "Hardware",
                definition:
                    "Physical elements of a computing systems (printer, circuit boards, wires, keyboard, etc)"),
            Card(
                id: 4,
                term: "Machine Language",
                definition: "Programs written in binary code"),
          ])
    ]
  ];
  late List<Category> categories;
  // TODO: Get the user badges
  // TODO: Get the user created decks
  // TODO: Local Database to get previously left over decks

  UserModel() {
    categories = [
      Category(
        name: "Astrology",
        vector: "Images/vectors/astro.png",
        decks: categoryDecks[0],
        id: "0",
        background: "Images/backgrounds/Categoryast.png",
      ),
      Category(
        name: "Geography",
        vector: "Images/vectors/geography.png",
        decks: categoryDecks[1],
        id: "1",
        background: "Images/backgrounds/Categorygeography.png",
      ),
      Category(
        name: "Law",
        vector: "Images/vectors/law.png",
        decks: categoryDecks[2],
        id: "2",
        background: "Images/backgrounds/Categorylaw.png",
      ),
      Category(
        name: "Math",
        vector: "Images/vectors/math.png",
        decks: categoryDecks[3],
        background: "Images/backgrounds/Categorymath.png",
        id: "3",
      ),
      Category(
        name: "Pharmacy",
        vector: "Images/vectors/pharm.png",
        decks: categoryDecks[4],
        background: "Images/backgrounds/Categorypharm.png",
        id: "4",
      ),
      Category(
        name: "Programming",
        vector: "Images/vectors/prog.png",
        decks: categoryDecks[5],
        background: "Images/backgrounds/Categoryprog.png",
        id: "5",
      ),
    ];
  }
}
