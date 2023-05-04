# Mobi Grocery Shopping App

The Mobi Grocery Shopping App is a mobile application built with Flutter that helps users keep track of their grocery lists and items. With this app, users can create new grocery lists, add items to existing lists, mark items as collected, and delete items from lists.

## Screenshot

![app shot](app_screenshot.png?raw=true 'Mobi Grocery Shopping')

## Running the Application

To run the application, first make sure you have the Flutter SDK installed. Then, clone this repository and navigate to the project directory in your terminal. Run the following command to install the necessary dependencies:

    flutter pub get

Next, start an Android emulator or connect a physical Android device to your computer. Finally, run the app with the following command:

    flutter run

## Running Tests

To run tests for the application, use the following command:

    flutter test

This will run all the tests in the test directory. To generate a coverage report, use the following command:

    flutter test --coverage

This will generate a coverage report in the coverage/lcov.info file. You can then use a tool like lcov to view the coverage report:

    genhtml coverage/lcov.info -o coverage/html

This will generate an HTML report in the coverage/html directory. You can open the index.html file in a web browser to view the coverage report.

## Architecture

The Grocery Shopping App follows the Model-View-ViewModel (MVVM) architecture pattern. The app's data models are defined in the models directory, while the view models are defined in the viewmodels directory. The user interface is defined in the presentation directory.

Additional Notes

    The app uses the Flutter Provider package for state management.
    The app uses the Flutter Slidable package for swipeable list items.
    The app uses the Flutter TextField and AlertDialog widgets for user input and feedback.
