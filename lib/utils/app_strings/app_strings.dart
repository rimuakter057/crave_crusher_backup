class AppText {
  static RegExp passRegexp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.{8,}$)');
  static RegExp emailRegexp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  static const String fieldCantBeEmpty = "Field can't be empty";
  static const String emailFieldCantBeEmpty = "Please enter your email";
  static const String passwordFieldCantBeEmpty = "Please enter your password";
  static const String checknetworkconnection = "Check network connection";
  static const String enterThe8Character = "Please Enter The 8 character";
  static const String passwordNotMatch = "Passwords do not match";
  static const String noDataFound = "No Data Found";

  static const String smokingDetox = 'Smoking Detox';
  static const String drugDetox = 'Saving Money Battle';
  static const String socialMediaDetox = 'Social Media Detox';
  static const String toxicRelationship = 'Toxic Relationship Battle';
  static const String shoppingDetox = 'Shopping Detox';
  static const String junkFoodBattle = 'Junk Food Battle';

  static const String caved = "Caved";
  static const String craved = "Craved";
  static const String missed = "Missed";
///api status text==============================================
  static const String cavedStatus = "caved";
  static const String cravedStatus = "craved";
  static const String missedStatus = "missed";
  static const String pendingStatus = "pending";
  static const String completeStatus = "complete";
  static const String cancelStatus = "cancel";

  static const List<String> addictionTypes = [
    smokingDetox,
    drugDetox,
    socialMediaDetox,
    toxicRelationship,
    shoppingDetox,
    junkFoodBattle,
  ];

  // Addiction Levels
  static const String veryLow = 'Very Low';
  static const String low = 'Low';
  static const String medium = 'Medium';
  static const String high = 'High';
  static const String veryHigh = 'Very High';

  static const List<String> addictionLevels = [
    veryLow,
    low,
    medium,
    high,
    veryHigh,
  ];

  static const String ccLegend = "CC Legend";
  static const String positivePowerhouse = "Positive Powerhouse";
  static const String milestoneAchiever = "Milestone Achiever";
  static const String victoryStreaker = "Victory Streaker";
  static const String focusFighter = "Focus Fighter";
  static const String monsterMaster = "Monster Master";
  static const String consistencyChamp = "Consistency Champ";
  static const String starterSpark = "Starter Spark";

  // Optional: সব titles list এ রাখতে চাইলে
  static const List<String> all = [
    ccLegend,
    positivePowerhouse,
    milestoneAchiever,
    victoryStreaker,
    focusFighter,
    monsterMaster,
    consistencyChamp,
    starterSpark,
  ];
}
