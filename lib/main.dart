import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tripiz_app/common/common_scaffold.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/cubits/location/location_cubit.dart';
import 'package:tripiz_app/home/cubits/bus-position/bus_position_cubit.dart';
import 'package:tripiz_app/home/cubits/map-station/map_station_cubit.dart';
import 'package:tripiz_app/wallet/cubits/wallet/wallet_cubit.dart';
import 'package:tripiz_app/welcome/screens/onboarding_screen.dart';
import 'package:tripiz_app/welcome/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => WelcomeScreen()),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => OnBoardingScreen(),
        ),
        GoRoute(path: '/app', builder: (context, state) => CommonScaffold()),
      ],
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  LocationCubit()
                    ..fetchLocation()
                    ..startTracking(),
        ),
        BlocProvider(create: (context) => WalletCubit()),
        BlocProvider(create: (context) => MapStationCubit()),
        BlocProvider(create: (context) => BusPositionCubit()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          useMaterial3: true,
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        ),
      ),
    );
  }
}
