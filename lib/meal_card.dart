import 'package:flutter/material.dart';
import 'meal.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe; // Pass Recipe object as a parameter

  RecipeCard({
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[900]!,
            offset: Offset(0.0, 10.0),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
      ),
      child: Center( // Center the Column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Align content center
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text(
                recipe.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center, // Center the text
              ),
            ),
            _buildInfoItem("Calories", recipe.calories.toString()),
            _buildInfoItem("Serving Size (g)", recipe.serving_size_g.toString()),
            _buildInfoItem("Total Fat (g)", recipe.fat_total_g.toString()),
            _buildInfoItem("Saturated Fat (g)", recipe.fat_saturated_g.toString()),
            _buildInfoItem("Protein (g)", recipe.protein_g.toString()),
            _buildInfoItem("Sodium (mg)", recipe.sodium_mg.toString()),
            _buildInfoItem("Potassium (mg)", recipe.potassium_mg.toString()),
            _buildInfoItem("Sugar (g)", recipe.sugar_g.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Align content center
        mainAxisAlignment: MainAxisAlignment.center, // Align content center
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center, // Center the text
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center, // Center the text
            ),
          ),
        ],
      ),
    );
  }
}
