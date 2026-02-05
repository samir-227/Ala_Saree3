import 'package:ala_saree3/data/models/product_model.dart';
import 'package:ala_saree3/domain/entities/product.dart';

class MockDrinksDataSource {
  List<Product> getDrinks() {
    return [
      const Product(
        id: '1',
        image: 'assets/drinks/Banana.png',
        name: 'Banana Smoothie',
        description:
            'A creamy blend of fresh organic bananas and chilled milk, topped with a hint of vanilla.',
        price: '23',
        category: 'Smoothie',
        type: ProductType.drink,
      ),
      const Product(
        id: '2',
        image: 'assets/drinks/Salted Caramel.png',
        name: 'Caramel Milkshake',
        description:
            'Indulgent milkshake featuring rich salted caramel sauce blended with premium vanilla ice cream.',
        price: '20',
        category: 'Milkshake',
        type: ProductType.drink,
      ),
      const Product(
        id: '3',
        image: 'assets/drinks/Chocolate.png',
        name: 'Hot Chocolate',
        description:
            'Warm your soul with our signature hot chocolate made from melted Belgian cocoa and steamed milk.',
        price: '10',
        category: 'Hot Drinks',
        type: ProductType.drink,
      ),
      const Product(
        id: '4',
        image: 'assets/drinks/Strawberry.png',
        name: 'Strawberry Fusion',
        description:
            'Fresh seasonal strawberries blended to perfection for a refreshing and naturally sweet experience.',
        price: '40',
        category: 'Smoothie',
        type: ProductType.drink,
      ),
      const Product(
        id: '5',
        image: 'assets/drinks/Banana.png',
        name: 'Banana Deluxe',
        description:
            'The classic banana smoothie with an extra swirl of honey and a sprinkle of chia seeds.',
        price: '23',
        category: 'Smoothie',
        type: ProductType.drink,
      ),
      const Product(
        id: '6',
        image: 'assets/drinks/Salted Caramel.png',
        name: 'Salted Caramel Shake',
        description:
            'For the true caramel lovers—extra drizzle, extra cream, and that perfect salty kick.',
        price: '20',
        category: 'Milkshake',
        type: ProductType.drink,
      ),
      const Product(
        id: '7',
        image: 'assets/drinks/Chocolate.png',
        name: 'Dark Chocolate Drink',
        description:
            'A deeper, richer cocoa experience for those who appreciate the bold notes of dark chocolate.',
        price: '10',
        category: 'Hot Drinks',
        type: ProductType.drink,
      ),
      const Product(
        id: '8',
        image: 'assets/drinks/Strawberry.png',
        name: 'Strawberry Classic',
        description:
            'Simple, fresh, and iconic. Just pure strawberries and chilled yogurt blend.',
        price: '40',
        category: 'Smoothie',
        type: ProductType.drink,
      ),
      const Product(
        id: '9',
        image: 'assets/drinks/Salted Caramel.png',
        name: 'Ultimate Milkshake',
        description:
            'Our premium milkshake selection, served in a large cup with whipped cream and toppings.',
        price: '20',
        category: 'Milkshake',
        type: ProductType.drink,
      ),
    ];
  }
}
