import 'package:connectivity_plus/connectivity_plus.dart';

import '../../utils/logger.dart';

class ConnectivityCheckerImpl implements ConnectivityChecker {
  @override
  Future<bool> networkChecker() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    logger.i('networkCheker: Connection: $connectivityResult');
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}

abstract class ConnectivityChecker {
  Future<bool> networkChecker();
}
