import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectivityCheck {
/*  I found that just using the connectivity package was not enough to tell if the internet was available or not. In Android it only checks if there is WIFI or if mobile data is turned on, it does not check for an actual internet connection . During my testing, even with no mobile signal ConnectivityResult.mobile would return true.

  With IOS my testing found that the connectivity plugin does correctly detect if there is an internet connection when the phone has no signal, the issue was only with Android.

  The solution I found was to use the data_connection_checker package along with the connectivity package. This just makes sure there is an internet connection by making requests to a few reliable addresses, the default timeout for the check is around 10 seconds.

  My finished isInternet function looked a bit like this:*/

  Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      if (await InternetConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        print(' Mobile data detected & internet connection confirmed.');
        return true;
      } else {
        // Mobile data detected but no internet connection found.
        print(' Mobile data detected but no internet connection found.');
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      if (await InternetConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        print(' Wifi detected & internet connection confirmed.');
        return true;
      } else {
        // Wifi detected but no internet connection found.
        print(' Wifi detected but no internet connection found.');
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      print(
          ' Neither mobile data or WIFI detected, not internet connection found.');
      return false;
    }
  }
  // if (await InternetConnectionChecker().hasConnection)
  //part is the same for both mobile and wifi connections and should probably be moved to a separate function. I've not done that here to leave it more readable.
}
