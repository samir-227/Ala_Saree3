# AlaSaree3 App Functionality

This document provides a detailed overview of the AlaSaree3 App's functionality, architecture, and implementation.

## App Description

The AlaSaree3 App is a mobile application built with Flutter that allows users to browse and order drinks and food items. The app provides a smooth and intuitive user experience with a clean and modern UI. It features a bottom navigation bar for easy switching between menus, order history, and profile.

## Key Features

- **Browse Menus:** Users can browse through a list of available drinks and food items.
- **Product Details:** Users can view detailed information about each product, including its name, description, price, and image. Both drinks and food are unified under a common `ProductEntity`.
- **Product Carousel:** The product details screen features a carousel that allows users to swipe through different product options or images.
- **Size and Quantity Selection:** Users can customize their orders by selecting the size and quantity of each item.
- **Shopping Cart:** Users can add items to their shopping cart and view the cart's contents.
- **Checkout Process:** The app provides a seamless checkout process that includes:
  - Adding/Editing a shipping address.
  - Selecting a shipping method.
  - Adding/Editing a payment method.
  - Placing an order.
- **Order History:** Users can view their past orders and track their status.
- **Theme Management:** Support for both Light and Dark modes.
- **Dependency Injection:** Uses `get_it` for service location and dependency management.
- **State Management:** The app uses the `provider` package for state management, integrated with the service locator.
- **Navigation:** The app uses the `go_router` package for declarative routing, which allows for deep linking and a more organized navigation structure.

## Screens and Functionality

### Splash Screen

- The `SplashScreen` is the first screen that appears when the app is launched.
- It is a simple screen that is shown for a short period of time while the app is initializing.

### Main Screen

- The `MainScreen` is the core of the app and contains the bottom navigation bar.
- The bottom navigation bar has four tabs: "Drinks", "Food", "Orders", and "Profile".
- The `IndexedStack` widget is used to keep the state of each tab alive when switching between them.

### Drinks Menu Screen

- Displays a list of available drinks fetched from the `DrinksProvider`.
- Each drink is displayed in a card showing the name, image, and price.
- Tapping on a drink navigates the user to the `DrinkDetails` screen.

### Food Menu Screen

- Displays a list of food items fetched from the `FoodsProvider`.
- Similar to the drinks menu but focused on food products.

### Product Details Screens (Drinks & Food)

- Displays the details of a selected product.
- Features a carousel of images and customization options.
- Users can select the size and quantity.
- The "Add to Cart" button handles the logic for adding the item to the persistent cart state.

### Cart Screen

- Displays the items currently in the user's shopping cart.
- Users can manage quantities or remove items.
- Shows the subtotal and provides a link to the checkout process.

### Checkout Screen

- Allows the user to finalize their order.
- Displays and allows editing of shipping address, shipping method, and payment method.
- Shows an order summary before final placement.

### Orders Screen

- Lists the user's past and current orders.
- Users can tap on an order to see its specific details and status.

### Profile Screen

- Allows users to manage their account settings.
- Features theme switching (Light/Dark mode).
- Provides access to order history and other user-specific information.

## State Management & DI

The app uses `get_it` as a service locator to manage dependencies and `provider` for UI state.

### Providers (Controllers)

- **`DrinksProvider`:** Manages the state of the drinks menu.
- **`FoodsProvider`:** Manages the state of the food menu.
- **`CartProvider`:** Manages the shopping cart state.
- **`OrderProvider`:** Manages order history and placement.
- **`ThemeProvider`:** Manages the app's theme mode (Light/Dark).
- **`ProductDetailsProvider`:** Manages the state of the detail screens (selection of size, quantity).

### Repositories

- **`DrinksRepository`:** Fetches drink data.
- **`FoodsRepository`:** Fetches food data.
- **`OrderRepository`:** Handles order-related data operations.

## Navigation

The app uses `go_router`. Routes defined in `AppRouter`:

- **`/main`:** The main screen containing the bottom navigation.
- **`/cart`:** The cart screen.
- **`/checkout`:** The main checkout screen.
- **`/checkout/add-address`:** Screen to add shipping info.
- **`/checkout/add-card`:** Screen to add payment info.
- **`/drinks/details`:** Detailed view for a drink.
- **`/foods/details`:** Detailed view for a food item.
- **`/orders`:** The order history list.
- **`/order_details/:id`:** Specific order details.
- **`/profile`:** The user profile and settings screen.
