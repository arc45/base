import 'package:base_project/core/themes/bloc/theme_bloc.dart';
import 'package:base_project/core/utils/app_exports.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()
            ..add(
              InitializeTheme(isDarkThemeOn: false, followSystemTheme: true),
            ),
        ),
        BlocProvider<LocaleBloc>(
          create: (context) =>
              LocaleBloc()..add(SetLocale(locale: Locale('en'))),
        ),
        BlocProvider(
          create: (_) => CheckConnectionCubit()..initializeConnectivity(),
        ),
        BlocProvider<SplashBloc>(create: (context) => SplashBloc()),
      ],
      child: child,
    );
  }
}
