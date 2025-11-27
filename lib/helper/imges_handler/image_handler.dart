import 'package:crave_crusher/utils/app_const/app_const.dart';


import '../../service/api_url.dart';

class ImageHandler {
  static String imagesHandle(String? url,{bool isProfile = false}) {
    if (url == null || url.isEmpty) {
      if(isProfile){
        return AppConstants.unknown;
      }
      return AppConstants.resturentImage;
    }

    if (url.startsWith('http')) {
      return url; // If the URL starts with 'http', return as is
    } else {
      return '${ApiUrl.baseUrl}/$url';
      //  return ApiUrl.imageUrl + url;
    }
  }
}
