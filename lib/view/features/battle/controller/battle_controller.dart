import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_strings/app_strings.dart';
import 'package:crave_crusher/view/features/battle/models/battle_details_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../models/battle_model.dart';
class BattleController extends GetxController{


  RxInt battleTabIndex = 0.obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   fetchAllBattle('active');
  // }


  ///create battle section=============================================Post Method============================================


// Loading
  var isLoading = false.obs;

  // User selections
  var selectedType = RxnString();
  var selectedLevel = RxnString();
  var sendReminder = true.obs;

  // Text controllers
  final TextEditingController daysController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  // Static dropdown values

  final List<String> addictionTypes =AppStrings.addictionTypes;


  final List<String> addictionLevels =AppStrings.addictionLevels;

  /// Create Battle API call=====================================================
  Future<bool> createBattle() async {
    if (!_validateInputs()) return false;

    isLoading.value = true;

    // Directly create body as Map<String, dynamic> instead of using a model
    final body = {
      "addictionType": selectedType.value,
      "addictionLevel": selectedLevel.value,
      "battleLength": int.tryParse(daysController.text),
      "sendReminder": sendReminder.value,
      "battleReason": reasonController.text,
    };

    final response = await ApiClient.postData(
      ApiUrl.createBattle,
      body,
    );

    isLoading.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      _clearInputs();
      return true;
    } else {
      Get.snackbar("Error", response.statusText ?? "Battle create failed");
      return false;
    }
  }


  // Input validation
  bool _validateInputs() {
    if (selectedType.value == null) {
      Get.snackbar("Error", "Please select addiction type");
      return false;
    }
    if (selectedLevel.value == null) {
      Get.snackbar("Error", "Please select addiction level");
      return false;
    }
    if (daysController.text.isEmpty) {
      Get.snackbar("Error", "Please enter number of days");
      return false;
    }
    if (reasonController.text.isEmpty) {
      Get.snackbar("Error", "Please enter a reason");
      return false;
    }
    return true;
  }

  void _clearInputs() {
    selectedType.value = null;
    selectedLevel.value = null;
    sendReminder.value = true;
    daysController.clear();
    reasonController.clear();
  }


  ///cancel battle=================================================================================

  var isLoadingCancelBattle = false.obs;

  Future<bool> cancelBattle(String battleId,) async {
    isLoadingCancelBattle.value = true;
    final body = {
      "addictionType": selectedType.value,
      "addictionLevel": selectedLevel.value,
      "battleLength": int.tryParse(daysController.text),
      "sendReminder": sendReminder.value,
      "battleReason": reasonController.text,
    };


    final response = await ApiClient.patchData(
      ApiUrl.cancelBattle(battleId),
      body,
    );

    isLoadingCancelBattle.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }

    return false;
  }



  /// get all battle ============================================================================== Get Method =====================map to lis==============

  RxList<BattleModel> allBattleList = <BattleModel>[].obs;
  RxBool isLoadingAllBattle = false.obs;
  static final Logger logger = Logger();

  Future<void> fetchAllBattle(String status) async {
    isLoadingAllBattle.value = true;

    final response = await ApiClient.getData(ApiUrl.myBattle(status));


    if (response.statusCode == 200 &&
        response.body != null &&
        response.body['data'] != null) {
      final List data = response.body['data'];

      allBattleList.value =
          data.map((e) => BattleModel.fromJson(e)).toList();
    } else {
      allBattleList.clear();
      ApiChecker.checkApi(response);
    }
    isLoadingAllBattle.value = false;
  }





  /// get single battle ==================================================map to map============================ Get Method =====================


  var battleDetails = BattleDetailsModel().obs;
  var isLoadingSingleBattle = false.obs;



  Future<void> fetchSingleBattle(String battleId) async {
    isLoadingSingleBattle.value = true;

    final response = await ApiClient.getData(ApiUrl.singleBattle(battleId));

    if (response.statusCode == 200 && response.body['data'] != null) {
      final data = response.body['data'];
      battleDetails.value = BattleDetailsModel.fromJson(data);
    } else {
      battleDetails.value = BattleDetailsModel();
    }

    isLoadingSingleBattle.value = false;
  }


///complete battle day=====================================================Patch=========================================
  var isLoadingCompleteBattle = false.obs;

  Future<bool> completeBattleDay(String battleId,final String status) async {
    isLoadingCompleteBattle.value = true;

    final body = {
      "status": status, // or whatever backend expects
    };

    final response = await ApiClient.patchData(
      ApiUrl.completeBattleDay(battleId),
      body,
    );

    isLoadingCompleteBattle.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }

    return false;
  }




}



