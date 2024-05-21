class Recipe {
  final String name;
  final num calories;
  final num serving_size_g;
  final num fat_total_g;
  final num fat_saturated_g;
  final num protein_g;
  final num sodium_mg;
  final num potassium_mg;
  final num cholesterol_mg;
  final num carbohydrates_total_g;
  final num fiber_g;
  final num sugar_g;

  Recipe({
    required this.name,
    required this.calories,
    required this.serving_size_g,
    required this.fat_total_g,
    required this.fat_saturated_g,
    required this.protein_g,
    required this.sodium_mg,
    required this.potassium_mg,
    required this.cholesterol_mg,
    required this.carbohydrates_total_g,
    required this.fiber_g,
    required this.sugar_g,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] as String,
      calories: json['calories'],
      serving_size_g: json['serving_size_g'],
      fat_total_g: json['fat_total_g'],
      fat_saturated_g: json['fat_saturated_g'],
      protein_g: json['protein_g'],
      sodium_mg: json['sodium_mg'],
      potassium_mg: json['potassium_mg'],
      cholesterol_mg: json['cholesterol_mg'],
      carbohydrates_total_g: json['carbohydrates_total_g'],
      fiber_g: json['fiber_g'],
      sugar_g: json['sugar_g'],
    );
  }




List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }
}
