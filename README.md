# Ala Saree3

A modern Flutter e-commerce application for browsing and ordering drinks and food items. The app provides a smooth and intuitive user experience with a clean, modern UI featuring product browsing, shopping cart functionality, and a complete checkout process.

## Features

- 🍹 **Browse Menus**: Browse through available drinks and food items
- 📱 **Product Details**: View detailed information including name, description, price, and images
- 🎠 **Product Carousel**: Swipe through different product options in the details screen
- ⚙️ **Customization**: Select size and quantity for each item
- 🛒 **Shopping Cart**: Add items to cart and manage your selections
- 💳 **Checkout Process**: Complete checkout with address management and payment integration
- 📋 **Order History**: View your past orders and track their status
- � **Theme Management**: Support for Light and Dark modes
- �🎨 **Modern UI**: Clean and intuitive interface with smooth animations and Material 3 design

## Tech Stack

- **Framework**: Flutter 3.19.0+
- **State Management**: Provider
- **Dependency Injection**: GetIt
- **Navigation**: Go Router
- **UI Components**: Material Design 3
- **Fonts**: Google Fonts
- **Icons**: Material Icons, Custom SVG assets

## Project Structure

```
lib/
├── core/              # Core functionality (routing, theme, DI)
│   ├── di/            # Dependency injection (Service Locator)
│   ├── routing/       # App routing (GoRouter)
│   └── theme/         # App theme and styling
├── data/              # Data layer (repositories, data sources, models)
├── domain/            # Domain layer (entities, repositories abstracts)
├── presentation/      # UI layer (screens, controllers, widgets)
│   ├── screens/       # App screens (Drinks, Food, Cart, Checkout, etc.)
│   ├── controller/    # State providers (ChangeNotifiers)
│   └── widgets/       # Shared UI components
└── main.dart          # App entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (3.19.0 or higher)
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
- **Main Screen**: Bottom navigation with Drinks, Food, Orders, and Profile tabs
- **Drinks Menu**: Browse available drinks
- **Food Menu**: Browse available food items
- **Product Details**: View product details with carousel and customization options
- **Cart Screen**: Manage cart items and proceed to checkout
- **Checkout Screen**: Complete order with address, shipping, and payment
- **Orders Screen**: View order history
- **Profile Screen**: Manage account settings and theme

## State Management & DI

The app uses **GetIt** for dependency injection and **Provider** for state management:

- `DrinksProvider`: Manages drinks menu state
- `FoodsProvider`: Manages food menu state
- `CartProvider`: Manages shopping cart state
- `OrderProvider`: Manages order state and history
- `ThemeProvider`: Manages app-wide theme mode
- `ProductDetailsProvider`: Manages transient state of the product details screen

## Dependencies

### Main Dependencies
- `provider: ^6.1.2` - State management
- `get_it: ^7.7.0` - Service locator
- `go_router: ^17.0.1` - Declarative routing
- `google_fonts: ^6.2.1` - Custom fonts
- `flutter_svg: ^2.1.0` - SVG support

See `pubspec.yaml` for the complete list of dependencies.

## Architecture

The app follows Clean Architecture principles with a clear separation of concerns between Data, Domain, and Presentation layers, ensuring scalability and testability.

## Assets

The app includes custom assets for:
- Product images (drinks and foods)
- App logo and branding
- Custom SVG icons

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.
