import 'package:firebase_core/firebase_core.dart';
import 'package:user_repository/user_repository.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulapedia/app.dart';
import 'package:gulapedia/simple_bloc_observer.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'Gulakupedia');
  OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
    OpenFoodFactsLanguage.INDONESIAN,
  ];

  Bloc.observer = SimpleBlocObserver();
  runApp(MainApp(FirebaseUserRepo()));
}
