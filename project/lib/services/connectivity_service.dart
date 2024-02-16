import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class ConnectivityService {

  Future<bool> checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Widget noConnectionAlert(){
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("NO CONNECTION, PLEASE CONNECT TO THE INTERNET AND TRY AGAIN")
    ],);
  }
}