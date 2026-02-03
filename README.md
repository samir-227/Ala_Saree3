# Ala Saree3

A modern Flutter e-commerce application for browsing and ordering drinks and food items. The app provides a smooth and intuitive user experience with a clean, modern UI featuring product browsing, shopping cart functionality, and a complete checkout process.

## Features

- 🍹 **Browse Menus**: Browse through available drinks and food items
- 📱 **Product Details**: View detailed information including name, description, price, and images
- 🎠 **Product Carousel**: Swipe through different product options in the details screen
- ⚙️ **Customization**: Select size and quantity for each item
- 🛒 **Shopping Cart**: Add items to cart and manage your selections
- 💳 **Checkout Process**: Complete checkout with:
  - Shipping address management
  - Shipping method selection
  - Payment method integration
  - Order placement
- 📋 **Order History**: View your past orders
- 🎨 **Modern UI**: Clean and intuitive interface with smooth animations

## Tech Stack

- **Framework**: Flutter 3.7.0+
- **State Management**: Provider
- **Navigation**: Go Router
- **UI Components**: Material Design 3
- **Fonts**: Google Fonts
- **Icons**: Material Icons, Custom SVG assets

## Project Structure

```
lib/
├── core/              # Core functionality (routing, theme)
├── data/              # Data layer (repositories, models)
├── domain/            # Domain layer (entities, use cases)
├── presentation/      # UI layer (screens, controllers, widgets)
│   ├── screens/       # App screens
│   └── controller/    # State providers
└── main.dart          # App entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (3.7.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- iOS Simulator / Android Emulator or physical device

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd Ala_Saree3
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Screens

- **Splash Screen**: Initial loading screen
- **Main Screen**: Bottom navigation with Drinks, Food, Orders, and Cart tabs
- **Drinks Menu**: Browse available drinks
- **Food Menu**: Browse available food items
- **Product Details**: View product details with carousel and customization options
- **Cart Screen**: Manage cart items and proceed to checkout
- **Checkout Screen**: Complete order with address, shipping, and payment
- **Orders Screen**: View order history

## State Management

The app uses the Provider package for state management with the following providers:

- `DrinksProvider`: Manages drinks menu state
- `FoodsProvider`: Manages food menu state
- `CartProvider`: Manages shopping cart state
- `OrderProvider`: Manages order state

## Dependencies

### Main Dependencies
- `provider: ^6.1.2` - State management
- `go_router: ^17.0.1` - Declarative routing
- `google_fonts: ^6.2.1` - Custom fonts
- `flutter_svg: ^2.1.0` - SVG support

See `pubspec.yaml` for the complete list of dependencies.

## Architecture

The app follows a clean architecture pattern with clear separation of concerns:

- **Presentation Layer**: UI components and state management
- **Domain Layer**: Business logic and entities
- **Data Layer**: Repositories and data sources

## Assets

The app includes custom assets for:
- Product images (drinks and foods)
- App logo
- Cart icon
- SVG graphics

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.
