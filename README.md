# Team Hurricane Events App
This is the codebase for Team Hurricane Mobile Team. It contains the code for the Event App built by Team Hurricane.

>**NOTE**: Try to read the comments provided in the code if you do not have an understanding of what it does and you're advised to browse through definitions of functions to know what it's about and how it wirks under the hood.

>**NOTE**: Try not to edit what you have no undertanding of. If you need to make changes to a file or a structure and you have no understanding of it, reach out to your teammates and they'll surely find an answer for you.


## App Structure

To work on the app:
- Fork the repo
- Make sure your flutter sdk is up to date
- Fetch the packages using flutter pub get
- Always perform git pull to keep your local up to date
- Perform your task
- Resolve every error before making PR (including linting error -- use dart fix --apply to fix)
- Make a pull request and await merge, pending merge conflicts.

The app uses a clean architecture with the provider package for state management.
It's divided into 4 main parts:

### App
This part of the app handles everything that is visible on th users screen. It takes care of the presentation layer from the creation of a page to the management of core widgets and custom built widgets.

**NOTE**

> Every screen created in the presntation folder must house a folder container screens, provider, widgets.

So for example creating the login screen.
You'll have to create a login folder containing folders of screens, widgets, provider.

This will house your screens, the custom UI elements used in developing your screen will be housed in the widgets folder and the provider folder contains the provider used in building that screen if it's secluded and not a global provider.




### Component
This part of the app handles everything that is used in the app globally. It handles and houses every component that is globally available in the app.
- ### Constants
    This houses static constant files in the app like, app strings, colors, images.
- ### Enums
- ### Theme
    A custom text theme extension was created to ensure a uniform styling of the app in general and consistency. As at the time of creation there are 7 custom styles: headline1, headline2, headline3, body1, body2, body3, button. You can check out the implemantation of this under components/theme/events_text_theme.dart.

    This ishows the normal inbuilt way of styling a text
    ```
    return const Scaffold(
      body: Text(
        "data",
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.2,
          color: Colors.red,
        ),
      ),
    );
    ```
    This is the same code after adding our extension. It saves boiler plate code and makes sure we hava a source we can go to if we want to make a change  on a textStyle design globally
    ```
     return Scaffold(
      body: Text(
        "data",
        style: context.body3.copyWith(
          color: Colors.red,
        ),
      ),
    );
    ```
- ### Utils
    As at the time of writing this documentation, this folder houses the extension file. It's the file that contains and houses all the extensions used in the app.

    NOTE: When creation an extension, give a brief explanation of what your extension does so it's easier for others to use and understand.
- ### Global Custom Widgets
    This houses every widget used globally in the app so we do not have a case of repitition keeping us in check with the DRY priciple

### Data
This part of the app handles the network and internet connectivity
For this purpose we used:
- Dio - for our network calls
- Retrofit - This was used as a wrapper over Dio for our code gen
- Build runner - Aids in the generation of code
- Tuple - This is usedto assign nullable records and value to a variable.

NOTE: When making changes to this part always make sure you go through this routine:

SERVICES --> API IMPLEMENTATION --> REPOSITORY --> PROVIDERS.

Each of these folders house a read_me file that explains how they work and if you do not understand, reach out to the team lead @ooluseye16 and he'll assist you or point you to where you'll receive your help.

### Domain
This part of the app handles the business logic of the app. This houses and includes the providers used for managing the state of the app.