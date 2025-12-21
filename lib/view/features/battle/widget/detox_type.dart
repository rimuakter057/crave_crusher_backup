import 'package:crave_crusher/utils/app_strings/app_strings.dart';

import 'active_battle_card.dart';

checkDetoxType(String addictionType){

  if(addictionType == AppStrings.junkFoodBattle ){
    return DetoxType.junkFood;
  }else if(addictionType == AppStrings.drugDetox){
    return DetoxType.drugDetox;
  }else if(addictionType == AppStrings.socialMediaDetox){
    return DetoxType.socialMedia;
  }else if(addictionType == AppStrings.toxicRelationship){
    return DetoxType.love;
  }else if(addictionType == AppStrings.shoppingDetox){
    return DetoxType.shopping;
  }else if(addictionType == AppStrings.smokingDetox){
    return DetoxType.smoke;
  }else {
    return DetoxType.smoke;
  }


}


