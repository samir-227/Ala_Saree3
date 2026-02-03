import '../models/food_model.dart';

class MockFoodsDataSource {
  List<FoodModel> getFoods() {
    return [
      FoodModel(  
        id: '1',
        image: 'assets/foods/burger-2.png',
        name: 'Classic Burger',
        description: 'Juicy beef patty, cheddar, lettuce & tomato',
        price: '12.99',
        category: 'Burgers',
        availableSizes: ['Large'],
      ),
      FoodModel(
        id: '2',
        image: 'assets/foods/burger-3.png',
        name: 'Bacon Burger',
        description: 'Crispy bacon, double cheese, special sauce',
        price: '14.50',
        category: 'Burgers',
        availableSizes: ['Regular'],
      ),
      FoodModel(
        id: '3',
        image: 'assets/foods/burger-1.png',
        name: 'Spicy Burger',
        description: 'Jalapeños, spicy mayo & pepper jack cheese',
        price: '13.75',
        category: 'Burgers',
        availableSizes: ['Extra Large'],
      ),
      FoodModel(
        id: '4',
        image: 'assets/foods/burger-2.png',
        name: 'Classic Burger',
        description: 'Juicy beef patty, cheddar, lettuce & tomato',
        price: '12.99',
        category: 'Burgers',
        availableSizes: ['Regular', 'Large', 'Extra Large'],
      ),
      FoodModel(
        id: '5',
        image: 'assets/foods/burger-1.png',
        name: 'Bacon Burger',
        description: 'Crispy bacon, double cheese, special sauce',
        price: '14.50',
        category: 'Burgers',
        availableSizes: ['Extra Large'],
      ),
      FoodModel(
        id: '6',
        image: 'assets/foods/burger-3.png',
        name: 'Spicy Burger',
        description: 'Jalapeños, spicy mayo & pepper jack cheese',
        price: '13.75',
        category: 'Burgers',
        availableSizes: ['Extra Large', 'Regular'],
      ),
      FoodModel(
        id: '7',
        image: 'assets/foods/burger-1.png',
        name: 'Classic Burger',
        description: 'Juicy beef patty, cheddar, lettuce & tomato',
        price: '12.99',
        category: 'Burgers',
        availableSizes: ['Large'],
      ),
      FoodModel(
        id: '8',
        image: 'assets/foods/burger-3.png',
        name: 'Bacon Burger',
        description: 'Crispy bacon, double cheese, special sauce',
        price: '14.50',
        category: 'Burgers',
        availableSizes: ['Regular'],
      ),
      FoodModel(
        id: '9',
        image: 'assets/foods/burger-2.png',
        name: 'Spicy Burger',
        description: 'Jalapeños, spicy mayo & pepper jack cheese',
        price: '13.75',
        category: 'Burgers',
        availableSizes: ['Extra Large'],
      ),
     
    ];
  }
}
