import '../models/food_model.dart';

class MockFoodsDataSource {
  List<FoodModel> getFoods() {
    return [
      FoodModel(
  image: 'assets/foods/burger-2.png',        name: 'Classic Burger',
        description: 'Juicy beef patty, cheddar, lettuce & tomato',
        price: '12.99',
      ),
      FoodModel(
  image: 'assets/foods/burger-3.png',        name: 'Bacon Burger',
        description: 'Crispy bacon, double cheese, special sauce',
        price: '14.50',
      ),
      FoodModel(
  image: 'assets/foods/burger-2.png',        name: 'Spicy Burger',
        description: 'Jalapeños, spicy mayo & pepper jack cheese',
        price: '13.75',
      ),
      FoodModel(
  image: 'assets/foods/burger-3.png',        name: 'Classic Burger',
        description: 'Juicy beef patty, cheddar, lettuce & tomato',
        price: '12.99',
      ),
      FoodModel(
  image: 'assets/foods/burger-2.png',        name: 'Bacon Burger',
        description: 'Crispy bacon, double cheese, special sauce',
        price: '14.50',
      ),
      FoodModel(
        image: 'assets/foods/burger-3.png',
        name: 'Spicy Burger',
        description: 'Jalapeños, spicy mayo & pepper jack cheese',
        price: '13.75',
      ),
    ];
  }
}
