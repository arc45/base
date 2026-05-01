import 'package:base_project/core/utils/app_exports.dart';
import 'package:base_project/core/utils/local_storage/sqflite_storage_box.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    Logger.lOG("Error loading .env file: $e");
  }
  // Custom error widget
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return CustomErrorWidget(errorMessage: details.exception.toString());
  };
  // Get device info
  final deviceInfo = DeviceInfoPlugin();

  String? deviceId = '';
  int? deviceOs = 0;

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo.id;
    deviceOs = 1;
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    deviceId = iosInfo.identifierForVendor;
    deviceOs = 2;
  }

  EnvConfig stageConfig = EnvConfig(
    baseUrl: STAGE_SERVER_BASEURL,
    deviceId: deviceId ?? '',
    deviceOs: deviceOs,
    localIdentifier: '',
  );

  // Env config
  FlavorConfig.initialize(flavor: Flavor.stage, env: stageConfig);

  Logger.lOG(
    "FLAVOR             : ${FlavorConfig.instance.flavor}\n"
    "DEVICE ID          : $deviceId\n"
    "DEVICE OS          : $deviceOs\n"
    "BASE URL           : $STAGE_SERVER_BASEURL\n",
  );

  Logger.lOG("STAGE ENV: ${FlavorConfig.instance.flavor}");

  try {
    final KeyValueStore securePrefs = SqfliteStorageBox();
    await securePrefs.init();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(FlutterBlocBaseProject(prefs: securePrefs));
  } catch (e, stackTrace) {
    Logger.lOG('Error initializing app: $e\n$stackTrace');
  }
}
