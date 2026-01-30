# Coffee App Functionality

This document provides a detailed overview of the Coffee App's functionality, architecture, and implementation.

## App Description

The Coffee App is a mobile application built with Flutter that allows users to browse and order coffee and food items. The app provides a smooth and intuitive user experience, with a clean and modern UI. It features a bottom navigation bar for easy switching between the drinks and food menus, a shopping cart, and a checkout process.

## Key Features

- **Browse Menus:** Users can browse through a list of available drinks and food items.
- **Product Details:** Users can view detailed information about each product, including its name, description, price, and image.
- **Product Carousel:** The product details screen features a carousel that allows users to swipe through different product options.
- **Size and Quantity Selection:** Users can customize their orders by selecting the size and quantity of each item.
- **Shopping Cart:** Users can add items to their shopping cart and view the cart's contents.
- **Checkout Process:** The app provides a seamless checkout process that includes:
  - Adding a shipping address.
  - Selecting a shipping method.
  - Adding a payment method.
  - Placing an order.
- **State Management:** The app uses the `provider` package for state management, with separate providers for drinks, food, and the shopping cart.
- **Navigation:** The app uses the `go_router` package for declarative routing, which allows for deep linking and a more organized navigation structure.

## Screens and Functionality

### Splash Screen

- The `SplashScreen` is the first screen that appears when the app is launched.
- It is a simple screen that is shown for a short period of time while the app is initializing.

### Main Screen

- The `MainScreen` is the main screen of the app and contains the bottom navigation bar.
- The bottom navigation bar has two tabs: "Drinks" and "Food".
- The `IndexedStack` widget is used to keep the state of each tab alive when switching between them.

### Drinks Menu Screen

- The `DrinksMenuScreen` displays a list of available drinks.
- The screen fetches the list of drinks from the `DrinksProvider`.
- It shows a loading indicator while the drinks are being fetched.
- Each drink is displayed in a `DrinkCard` widget, which shows the drink's name, title, image, and price.
- Tapping on a drink navigates the user to the `DrinkDetails` screen, with a `Hero` animation for a smooth transition.

### Food Menu Screen

- The `FoodMenuScreen` is similar to the `DrinksMenuScreen` but displays a list of food items instead.
- It fetches the list of food items from the `FoodsProvider`.

### Drink Details Screen

- The `DrinkDetails` screen displays the details of a selected drink.
- It features a carousel of drink images, allowing the user to swipe through different options.
- Users can select the size and quantity of the drink.
- The "Add to Cart" button is enabled only when a size is selected.
- When the "Add to Cart" button is pressed, the selected drink is added to the shopping cart using the `CartProvider`.

### Food Details Screen

- The `FoodDetailsScreen` is similar to the `DrinkDetailsScreen` but displays the details of a selected food item.

### Cart Screen

- The `CartScreen` displays the items that the user has added to their shopping cart.
- If the cart is empty, it shows a message indicating that the cart is empty.
- Each item in the cart is displayed with its name, image, size, quantity, and price.
- Users can remove items from the cart.
- The screen displays the total price of all items in the cart.
- The "Checkout" button navigates the user to the `CheckoutScreen`.

### Checkout Screen

- The `CheckoutScreen` allows the user to complete their order.
- It displays the user's shipping address, shipping method, and payment method.
- Users can add or edit their shipping address.
- Users can select a shipping method.
- Users can add a payment method.
- The screen displays a summary of the order, including the total price.
- The "Place Order" button shows a payment success dialog and clears the cart.

## State Management

The app uses the `provider` package for state management. The following providers are used:

- **`DrinksProvider`:** Manages the state of the drinks menu, including fetching the list of drinks from the `DrinksRepository`.
- **`FoodsProvider`:** Manages the state of the food menu, including fetching the list of food items from the `FoodsRepository`.
- **`CartProvider`:** Manages the state of the shopping cart, including adding, removing, and updating items in the cart.
- **`ProductDetailsProvider`:** Manages the state of the product details screen, including the selected size and quantity.

## Navigation

The app uses the `go_router` package for navigation. The routes are defined in the `AppRouter` class. The following routes are defined:

- **`/`:** The splash screen.
- **`/main`:** The main screen.
- **`/drink_details`:** The drink details screen.
- **`/food_details`:** The food details screen.
- **`/cart`:** The cart screen.
- **`/checkout`:** The checkout screen.
- **`/add_address`:** The add address screen.
- **`/add_card`:** The add card screen.
