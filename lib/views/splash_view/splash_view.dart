import 'package:base_project/core/utils/app_exports.dart';

class SplashView extends StatelessWidget {
  static Widget builder(BuildContext context) {
    return const SplashView();
  }

  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).customColors.transparentColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Theme.of(context).customColors.primaryColor,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).customColors.primaryColor,
        body: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                  color: Theme.of(context).customColors.primaryColor,
                  height: 1.sh,
                  width: 1.sw,
                ),
                AnimatedSplashScreen(
                  backgroundColor: Colors.transparent,
                  splash: Text("Base Project"),
                  nextScreen: SizedBox(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
