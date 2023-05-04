# Mobi Grocery Shopping App

The Mobi Grocery Shopping App is a mobile application built with Flutter that helps users keep track of their grocery lists and items. With this app, users can create new grocery lists, add items to existing lists, mark items as collected, and delete items from lists.

## Screenshot

![app shot](app_screenshot.png?raw=true 'Mobi Grocery Shopping')

## Running the Application

To run the application, first make sure you have the Flutter SDK installed. Then, clone this repository and navigate to the project directory in your terminal. Run the following command to install the necessary dependencies:

    flutter pub get

Next, start an Android emulator or connect a physical Android device to your computer. Finally, run the app with the following command:

    flutter run

## Usage

-- The application is a simple Flutter application that displays a list of grocery lists. A grocery list can be added, renamed and deleted.

    1. To add a grocery list, tap the __"Floating Plus"__ button. Enter the name of the grocery list and tap the "Add New List" button.

    2. To rename or delete a grocery list, tap the __"More"__ icon on the grocery list card and rename or delete it.

    3. To view the grocery list items of a particular grocery list, tap on the gorcery list card.

    4. To add a grocery list item, tap the __"Floating 'Add'"__ button. Enter the name of the grocery list item and tap the "Add Shopping Item" button.

    5. To rename or delete a grocery list item, slide to the left of that particular grocery list item tap on the __"Edit"__ or __"Delete"__ icon and proceed to edit or delete that grocery list item.

    6. To mark a grocery list item as completed tap on the checkbox next to the item.



## Running Tests

To run tests for the application, use the following command:

    flutter test

This will run all the tests in the test directory. To generate a coverage report, use the following command:

    flutter test --coverage

This will generate a coverage report in the coverage/lcov.info file. You can then use a tool like lcov to view the coverage report:

    genhtml coverage/lcov.info -o coverage/html

This will generate an HTML report in the coverage/html directory. You can open the index.html file in a web browser to view the coverage report.

## Architecture

The project was built using a feature-based approach with clean architecture principles. This approach promotes modularity, separation of concerns, and maintainability of the codebase. Each feature of the app is treated as a module that contains all necessary components such as screens, widgets, models, and business logic.

The clean architecture principles ensure that the code is testable, loosely coupled, and easy to maintain. The architecture is divided into three layers: Presentation, Domain, and Data.

    - The Presentation layer is responsible for displaying data to the user and handling user interactions. It consists of the widgets and pages that the user interacts with.

    - The Domain layer contains the business logic of the app. It defines the use cases and business rules of the app. The use cases are independent of any specific framework or implementation, making it easier to change the implementation details in the future.

    - The Data layer is responsible for providing data to the app. It consists of repositories that provide data from various sources. The data layer is also responsible for caching and syncing data. This project focused on using the remote data source.

## Technologies Used

    * Flutter
    * Dart
    * Supabase
    * Dio
    * Get It
    * Provider
    * Go Router
    * JSON Serializable


Additional Notes

    The app uses the Flutter Provider package for state management.
    The app uses the Flutter Slidable package for swipeable list items.
    The app uses the Flutter TextField and AlertDialog widgets for user input and feedback.
