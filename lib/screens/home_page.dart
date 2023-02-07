import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/list_movie_page.dart';
import 'package:movie_app/screens/profile_page.dart';
import 'package:movie_app/services/movie_services.dart';
import 'package:movie_app/widgets/carousel_widget.dart';
import 'package:movie_app/widgets/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users = firestore.collection('users');
  final userId = FirebaseAuth.instance.currentUser?.uid;
  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: FutureBuilder(
          future:users.doc(userId).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  height: 40,
                  width: double.infinity,
                  
                  child: Text("Welcome, ${snapshot.data!['name']}")
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(builder: (_) => ProfilePage()));
                },
                child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: const Icon(
                      Icons.person,
                      size: 25,
                      color: kBackgroundColor,
                    )),
              )
            ],
          );
            } else {
              return const SizedBox();
            }
          },

        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: FutureBuilder(
                future: MovieServices.getTrendingMovies(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 200.0,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentPos = index;
                              });
                            },
                          ),
                          items: (snapshot.data ?? [])
                              .map((e) {
                                return CarouselWidget(movie: e);
                              })
                              .toList()
                              .sublist(0, 5),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                5,
                                (index) => Container(
                                      width: 8,
                                      height: 8,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: currentPos == index
                                            ? Colors.white
                                            : Colors.grey.shade800,
                                      ),
                                    ))),
                      ],
                    );
                  } else {
                    return const SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ));
                  }
                }),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Now Playing",
                style: kHeadline2,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (_) => const ListMoviePage()));
                },
                child: Row(
                  children: const [
                    Text(
                      "See all",
                      style: kBodyText,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.grey,
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 250,
            child: FutureBuilder(
                future: MovieServices.getListMovie(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Wrap(
                            spacing: 20,
                            children: (snapshot.data ?? [])
                                .map((e) => MovieWidget(movie: e))
                                .toList(),
                          )
                        ]);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ]),
      ),
    );
  }
}
