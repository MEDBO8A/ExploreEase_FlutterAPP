import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityServices{
  Future<bool> getConnectivity() async{
    final result = await Connectivity().checkConnectivity();;
    switch(result) {
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.bluetooth:
        return true;
      default:
        return false;
    }
  }

}