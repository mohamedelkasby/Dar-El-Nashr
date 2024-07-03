import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ////////////////////    this for customize the color for status bar     ///////////////////////////

    ColorScheme darkTheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor,
      onPrimary: secondryColorDark,
      secondary: primaryColor,
      onSecondary: white,
      error: Colors.red,
      onError: white,
      background: backgroundColorDark,
      onBackground: white,
      surface: backgroundColorDark,
      onSurface: white,
      outlineVariant: goldColor,
    );
    ///////////     end      ////////////
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: AppCubit.get(context).themeMode == ThemeMode.light
                  ? white
                  : backgroundColorDark,
              statusBarIconBrightness:
                  AppCubit.get(context).themeMode == ThemeMode.light
                      ? Brightness.dark
                      : Brightness.light,
            ),
          );
          return MaterialApp(
            ////         for language        ..................
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('ar', ''), // Arabic, no country code
              Locale('en', ''), // english, no country code
            ],
            locale: Locale(AppCubit.get(context).lang, ''), // Force RTL layout

            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.from(colorScheme: darkTheme),
            themeMode: AppCubit.get(context).themeMode,

            routes: {
              "/SplashScreen": (context) => const SplashScreen(),
              "/homepage": (context) => const HomePage(),
              "/loginScreen": (context) => const LoginScreen(),
              "/signUpScreen": (context) => const SignUpScreen(),
              "/basicScreen": (context) => const BasicScreen(),
            },
            initialRoute: "/SplashScreen",
          );
        },
      ),
    );
  }
}
