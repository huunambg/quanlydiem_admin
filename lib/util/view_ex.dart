

import 'check_network.dart';

void tapAndCheckInternet(Function onPress){
  CheckNetwork().checkInternet((isNetwork) {
    if (isNetwork) {
      onPress();
    } else {
     // Get.to(const NoInternetScreen());
    }
  });
}