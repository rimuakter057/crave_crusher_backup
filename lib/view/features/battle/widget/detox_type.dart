import 'package:crave_crusher/utils/app_strings/app_strings.dart';

import 'active_battle_card.dart';

checkDetoxType(String addictionType) {
  if (addictionType == AppText.junkFoodBattle) {
    return DetoxType.junkFood;
  } else if (addictionType == AppText.drugDetox) {
    return DetoxType.drugDetox;
  } else if (addictionType == AppText.socialMediaDetox) {
    return DetoxType.socialMedia;
  } else if (addictionType == AppText.toxicRelationship) {
    return DetoxType.love;
  } else if (addictionType == AppText.shoppingDetox) {
    return DetoxType.shopping;
  } else if (addictionType == AppText.smokingDetox) {
    return DetoxType.smoke;
  } else {
    return DetoxType.smoke;
  }
}
