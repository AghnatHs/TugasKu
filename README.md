##TugasKu
TugasKu (*'My Tasks'* or *'My Assignments' *in English) is a simple ToDo List app and has a feature that commonly found in ToDo List apps in general. 

I created this app for learning purpose only, especially architecturing a Flutter project.

### What i Used?
- [Flutter](https://flutter.dev/ "Flutter")
- [Realm](https://pub.dev/packages/realm "Realm") and [SharedPreferences](https://pub.dev/packages/shared_preferences "SharedPreferences") for storing database (currently only store locally)
- [Riverpod](https://riverpod.dev/ "Riverpod") for State Management
- [Google Fonts](https://pub.dev/packages/google_fonts "Google Fonts")
- and many more packages.

### Project Structure
- ** Core**
Contains constants, function, and fonts type to use across the project
- **Database**
Contains database classes for querying etc and return models. Using Riverpod Providers, each database classes is instantianted and configured.
- **Model**
- **Notifier**
Notifier updating UIs using it state, passing action from UIs to Services, and interacting with Services to update its state.
- **Services**
Services directly communicate CRUD operations with database.
UI Services is for simplify creating dialog and snackbar.
- **Presentation**
Screens and widgets used in project. Widgets is interacting with Notifiers (using Riverpod ref.watch(...) for updating UI or/and ref.read(...) for user action)

### TODO
- To create backup feature using Realm Flexible Sync.