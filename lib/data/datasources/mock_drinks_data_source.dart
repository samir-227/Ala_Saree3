import '../models/drink_model.dart';

class MockDrinksDataSource {
  List<DrinkModel> getDrinks() {
    return [
      DrinkModel(
        id: '1',
        image: 'assets/drinks/Banana.png',
        name: 'Banana',
        title: '20 Cups of different flavours',
        price: '23',
        category: 'Smoothie',
      ),
      DrinkModel(
        id: '2',
        image: 'assets/drinks/Salted Caramel.png',
        name: 'Milkshake',
        title: '20 Cups of different flavours',
        price: '20',
        category: 'Milkshake',
      ),
      DrinkModel(
        id: '3',
        image: 'assets/drinks/Chocolate.png',
        name: 'Chocolate Drinks',
        title: '20 Cups of different flavours',
        price: '10',
        category: 'Hot Drinks',
      ),
      DrinkModel(
        id: '4',
        image: 'assets/drinks/Strawberry.png',
        name: 'Strawberry',
        title: '3 Cups of different flavours',
        price: '40',
        category: 'Smoothie',
      ),
      DrinkModel(
        id: '5',
        image: 'assets/drinks/Banana.png',
        name: 'Banana',
        title: '20 Cups of different flavours',
        price: '23',
        category: 'Smoothie',
      ),
      DrinkModel(
        id: '6',
        image: 'assets/drinks/Salted Caramel.png',
        name: 'Milkshake',
        title: '20 Cups of different flavours',
        price: '20',
        category: 'Milkshake',
      ),
      DrinkModel(
         id: '7',
        image: 'assets/drinks/Chocolate.png',
        name: 'Chocolate Drinks',
        title: '20 Cups of different flavours',
        price: '10',
        category: 'Hot Drinks',
      ),
      DrinkModel(
         id: '8',
        image: 'assets/drinks/Strawberry.png',
        name: 'Strawberry',
        title: '3 Cups of different flavours',
        price: '40',
        category: 'Smoothie',
      ),
      DrinkModel(
        id: '9',
        image: 'assets/drinks/Salted Caramel.png',
        name: 'Milkshake',
        title: '20 Cups of different flavours',
        price: '20',
        category: 'Milkshake',
      ),
    ];
  }
}
