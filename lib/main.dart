import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/bloc/ticket_bloc.dart';
import 'package:movie_app/entities/ticket.dart';
import 'package:movie_app/services/auth_services.dart';
import 'package:movie_app/wrapper.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                MovieBloc()..add(const MovieEvent.started(0))),
        BlocProvider(
            create: (BuildContext context) =>
                TicketBloc()..add(TicketEvent.started(Ticket()))),
      ],
      child: StreamProvider.value(
        value: AuthServices.userStream,
        initialData: null,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie Application',
          theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            scaffoldBackgroundColor: kBackgroundColor,
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const Wrapper(),
        ),
      ),
    );
  }
}
