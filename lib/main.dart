import 'package:cafe/features/auth/presentaion/cubit/auth_cubit.dart';
import 'package:cafe/features/auth/services/firebase_auth_service.dart';
import 'package:cafe/features/menu/presentaion/cubit/items_cubit.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/widgets/auth_gate.dart';
import 'features/menu/data/services/item_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider(
        create: (context) => ItemsCubit(itemService: ItemService(dio: Dio()))..itemService,
        // child: NavigationScreen(),
      ),
      BlocProvider(
        create: (context) =>AuthCubit(FirebaseAuthService())..checkAuthStatus() ,
        // child: AuthScreen(),
      ),

      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),

          ),
          home: AuthGate()
        // BlocProvider(
        //   create: (context) => ItemsCubit(itemService: ItemService(dio: Dio()))..itemService,
        //   child: NavigationScreen(),
        // ),
        // BlocProvider(
        //   create: (context) =>AuthCubit(FirebaseAuthService()) ,
        //   child: AuthScreen(),
        // ),
      ),
    );
  }
}
