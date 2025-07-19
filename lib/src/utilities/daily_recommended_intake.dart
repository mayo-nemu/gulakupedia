class DailyRecommendedIntake {
  DailyRecommendedIntake({
    required this.dateOfBirth,
    required this.gender,
    required this.weight,
    required this.height,
  });

  final DateTime dateOfBirth;
  final String gender;
  final double weight;
  final double height;

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  /// Calculates the Basal Metabolic Rate (BMR) using the Mifflin-St Jeor Equation.
  ///
  /// The Mifflin-St Jeor Equation is:
  /// For Males: (10 * weight_kg) + (6.25 * height_cm) - (5 * age_years) + 5
  /// For Females: (10 * weight_kg) + (6.25 * height_cm) - (5 * age_years) - 161
  ///
  /// Returns the BMR in calories per day.
  double calculateBMR() {
    if (gender == 'male') {
      return (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else if (gender == 'female') {
      return (10 * weight) + (6.25 * height) - (5 * age) - 161;
    } else {
      throw ArgumentError('Gender must be "M" (Male) or "F" (Female).');
    }
  }

  // --- You would add methods for TDEE, Macronutrients, and Added Sugars here ---

  /// Calculates Total Daily Energy Expenditure (TDEE) based on BMR and activity level.
  ///
  /// [activityLevel] should be one of:
  /// 'sedentary', 'lightlyActive', 'moderatelyActive', 'veryActive', 'extremelyActive'
  double calculateTDEE(String activityLevel) {
    final bmr = calculateBMR();
    double activityFactor;

    switch (activityLevel) {
      case 'sedentary':
        activityFactor = 1.2;
        break;
      case 'lightly active':
        activityFactor = 1.375;
        break;
      case 'moderately active':
        activityFactor = 1.55;
        break;
      case 'very active':
        activityFactor = 1.725;
        break;
      case 'extremely active':
        activityFactor = 1.9;
        break;
      default:
        throw ArgumentError('Invalid activity level provided.');
    }
    return bmr * activityFactor;
  }

  /// Calculates the final recommended daily calorie intake based on TDEE and weight goal.
  ///
  /// [tdee] is the Total Daily Energy Expenditure.
  /// [goal] should be one of:
  /// 'maintain', 'mildLoss', 'moderateLoss', 'aggressiveLoss',
  /// 'mildGain', 'moderateGain', 'aggressiveGain'
  double calculateRecommendedCalories(double tdee, String goal) {
    double goalAdjustment;

    switch (goal) {
      case 'maintain':
        goalAdjustment = 0;
        break;
      case 'mildLoss':
        goalAdjustment = -250;
        break;
      case 'moderateLoss':
        goalAdjustment = -500;
        break;
      case 'aggressiveLoss':
        goalAdjustment = -750;
        break;
      case 'mildGain':
        goalAdjustment = 250;
        break;
      case 'moderateGain':
        goalAdjustment = 500;
        break;
      case 'aggressiveGain':
        goalAdjustment = 750;
        break;
      default:
        throw ArgumentError('Invalid weight goal provided.');
    }

    double finalCalories = tdee + goalAdjustment;

    // Apply minimum calorie safeguards for weight loss
    if (goal.contains('Loss')) {
      if (gender.toUpperCase() == 'F' && finalCalories < 1200) {
        finalCalories = 1200;
      } else if (gender.toUpperCase() == 'M' && finalCalories < 1500) {
        finalCalories = 1500;
      }
    }

    return finalCalories;
  }

  /// Calculates the recommended grams for protein, carbohydrates, and fat.
  ///
  /// [recommendedCalories] is the final daily calorie target.
  /// Returns a Map with keys 'protein', 'carbs', 'fat' and their gram values.
  Map<String, double> calculateMacronutrients(double recommendedCalories) {
    // Using mid-points of AMDRs for calculation
    const proteinPercentage = 0.225; // 10-35%
    const carbsPercentage = 0.55; // 45-65%
    const fatPercentage = 0.275; // 20-35%

    const caloriesPerGramProtein = 4;
    const caloriesPerGramCarbs = 4;
    const caloriesPerGramFat = 9;

    final proteinCals = recommendedCalories * proteinPercentage;
    final carbCals = recommendedCalories * carbsPercentage;
    final fatCals = recommendedCalories * fatPercentage;

    return {
      'protein': (proteinCals / caloriesPerGramProtein).roundToDouble(),
      'carbs': (carbCals / caloriesPerGramCarbs).roundToDouble(),
      'fat': (fatCals / caloriesPerGramFat).roundToDouble(),
    };
  }

  /// Calculates the recommended maximum grams for added sugars.
  ///
  /// [recommendedCalories] is the final daily calorie target.
  /// Returns the maximum added sugar in grams.
  double calculateAddedSugarsLimit(double recommendedCalories) {
    const maxAddedSugarPercentage =
        0.10; // Less than 10% of total daily calories
    const caloriesPerGramCarbs = 4;

    final maxAddedSugarCals = recommendedCalories * maxAddedSugarPercentage;
    return (maxAddedSugarCals / caloriesPerGramCarbs).roundToDouble();
  }
}
