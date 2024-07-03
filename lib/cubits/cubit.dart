import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';
import 'package:dar_nashr_gameat_el_malek_soad/modules/cart_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitilaThemeState()) {
    categoryList();
    loadSetting();
    checkBiometrics();
  }
  static AppCubit get(context) => BlocProvider.of(context);

  ThemeMode themeMode = ThemeMode.light;
  ScrollController scrollController = ScrollController();
  bool isOnTop = true;
  int itemsInCart = 0;
  // bool buttonEnabled = true;
  //////////
  List<CartModel> cartList = [];
  ///////////
  List<String> category = [];

  //////////////////// change language ////////////////////
  String lang = "en";

  Future<void> changeLang() async {
    final langPrefs = await SharedPreferences.getInstance();
    lang == "en" ? lang = "ar" : lang = "en";
    emit(ChangeLanguageState());
    langPrefs.setString("language", lang == "en" ? "en" : "ar");
  }

  //////////
  ////////// add category list ./////////
  void categoryList() {
    for (BookModel element in allBooksData) {
      category.add(element.category);
    }
    //// remove the dublicate . ///////
    category = [
      ...{...category}
    ];
  }

////////////////////    toggle between index navbar    ///////
  int onItemTapped(int index, int selectedIndex) {
    selectedIndex = index;
    emit(NavBarIndexState());
    return selectedIndex;
  }

///////////////////////////
///////////// get the total price of in the cart ////////////
  double getFullPrice() {
    double totalPrice = 0;

    for (CartModel element in cartList) {
      totalPrice += element.totalPrice;
    }
    emit(CountOfItemState());
    return totalPrice;
  }

//////////////////////////////////
/////////////// add items to cart ////////////
  void addToCart({required BookModel bookData}) {
    CartModel data = CartModel(
        bookName: bookData.name,
        bookImg: bookData.img,
        bookCategory: bookData.category,
        bookPrice: bookData.price,
        totalPrice: bookData.price);
    cartList.add(data);
  }

//////////////////////
/////////////// remove items from cart ////////////
  void removeFromCart({
    required String name,
  }) {
    for (int i = 0; i < cartList.length; i++) {
      if (name == cartList[i].bookName) {
        cartList.removeAt(i);
      }
    }
  }

///////////////////////
/////////// increse the items count in the cart /////////////
  int increment(int integer, int index) {
    integer += 1;
    cartList[index].totalPrice =
        double.parse((cartList[index].bookPrice * integer).toStringAsFixed(2));
    emit(CountOfItemState());
    return integer;
  }

//////////////////////////
/////////// decrese the items count in the cart /////////////

  int decrement(int integer, int index) {
    if (integer <= 1) {
      return integer;
    } else {
      integer -= 1;
      cartList[index].totalPrice = double.parse(
          (cartList[index].bookPrice * integer).toStringAsFixed(2));

      emit(CountOfItemState());
      return integer;
    }
  }

////////////////////////
/////// get the count of items in the cart //////////
  void cartItemsCount() {
    itemsInCart = cartList.length;
    emit(CartListCountState());
  }

//////////////////////////
///////// toggle the theme colors //////////

  Future<void> changeTheme() async {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    final themPrefs = await SharedPreferences.getInstance();
    emit(ChangedThemeState());
    themPrefs.setString(
        "themeMode", themeMode == ThemeMode.dark ? "dark" : "light");
  }

///////// start the app with saved theme and language //////////

  Future<void> loadSetting() async {
    final themPrefs = await SharedPreferences.getInstance();
    final themeString = themPrefs.getString("themeMode");
    final langPrefs = await SharedPreferences.getInstance();
    final languge = langPrefs.getString("language");
    themeMode = themeString == "dark" ? ThemeMode.dark : ThemeMode.light;
    lang = languge == "en" ? "en" : "ar";
    emit(LoadSettingStates());
  }

/////////////////////
//////// scroll to the top of the screen //////////
  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

/////////////////////
////// display the floating action button when scrolling //////
  bool lisitenToScroll() {
    scrollController.addListener(() {
      if (scrollController.offset < 50) {
        isOnTop = true;
      } else {
        isOnTop = false;
      }
    });
    emit(ScrollListenerState());
    return isOnTop;
  }

  ////////////////////////
  ////// to pick an image from gallary
  ////try this after ......
  // ImagePicker _imgpick = ImagePicker();
  // File? imageFile;

  Future<void> pickerImage({required int? userIndex}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // File tempFile = File(pickedFile.path);

      // Get the directory where we can save the image
      // final directory = await getApplicationDocumentsDirectory();
      // String newPath = path.join(directory.path, "saved_image.jpg");

      // Copy the file to the new path
      // File savedFile = await tempFile.copy(newPath);

      if (userIndex != null) {
        users[userIndex].profileImg = pickedFile.path;
        print(users[userIndex].userName);
      }
      emit(ImagePickerState());
    }
  }

  /////////////////////////////

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // Call this function after a successful login
  Future<void> storeLoginState({required UsersAccount user}) async {
    // await storage.write(key: "auth_token", vale: token);
    // await storage.write(key: "user_id", value: user.passWord);
    // await storage.write(key: "user_name", value: user.userName);
    await storage.write(key: "userName", value: user.userName);
    // await storage.write(key: "user_password", value: user.passWord);
  }

  /* When the app starts, check if the authentication token exists
   to decide whether to show the login screen or the main screen */
  Future<bool> isLoggedIn() async {
    String? token = await storage.read(key: "userName");
    return token != null;
  }

  Future<UsersAccount> getCurrentUser() async {
    // Replace this with your logic to get the current logged-in user

    UsersAccount currentUser = user1; /////// this is not profisional
    for (var element in users) {
      if (element.userName == await storage.read(key: "userName")) {
        currentUser = element;
        break;
      } else {
        currentUser = user1; /////// this is not profisional
      }
    }
    return currentUser;
  }

  /// Provide a way for users to log out, which clears the authentication token.

  Future<void> logout() async {
    await storage.delete(key: "userName");
  }

  //////////////////////////////

  List<BookModel> filteredItems = [];
  String selectedCategory = "All"; //..........

  void filterSearch(String query) {
    List<BookModel> results = allBooksData
        .where(
          (item) =>
              item.name.toLowerCase().contains(query.toLowerCase()) &&
              (selectedCategory == "All" || selectedCategory == item.category),
        )
        .toList();
    if (query == "") {
      results = [];
    }
    filteredItems = results;
    emit(SearchBarState());
  }

  void changeSelectedCategory(String value) {
    selectedCategory = value;
    // filterSearch;
    emit(ChangeSelectedCategory());
  }
  ///////////////////////////////////

  final LocalAuthentication auth = LocalAuthentication();
  bool canCheckBiometrics = false;
  bool isAuthenticated = false;

  Future<void> checkBiometrics() async {
    // bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      canCheckBiometrics = false;
    }
    canCheckBiometrics = canCheckBiometrics;
    emit(FingerPrintAuthonticationState());
    // if (canCheckBiometrics) authenticate();
  }

////////////////////////////////////////////////////////////
  int checkForLoginData({username, password}) {
    // UsersAccount userData;
    int checker = 0;
    for (int i = 0; i < users.length; i++) {
      if (username == users[i].userName && password == users[i].passWord) {
        // print("Login successful");
        // userData = users[i];
        checker = i;
        // indexOfAcount = i;
        break;
      } else if (username != users[i].userName) {
        checker = -2;
        continue;
      } else if (username == users[i].userName &&
          password != users[i].passWord) {
        checker = -1;
        break;
      }
    }
    // userData = users[checker.isNegative ? 0 : checker];
    return checker;
  }
/////////////////////////// finger print auth ////////////////////////////////

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> saveToLocalAuth({required userName, required password}) async {
    await secureStorage.write(key: "userName", value: userName);
    await secureStorage.write(key: "password", value: password);

    final authPref = await SharedPreferences.getInstance();
    authPref.setBool(userName, true);

    // isAuthenticated = true;
  }

  Future<bool> checkIsAuthonticated(userName) async {
    final authPref = await SharedPreferences.getInstance();
    return authPref.getBool(userName) ?? false;
  }

  Future<int> authenticate() async {
    // bool authenticated = false;
    int checker = -1;

    try {
      // Check if biometrics are available and user has stored credentials
      bool hasStoredCredentials =
          await secureStorage.containsKey(key: "userName") &&
              await secureStorage.containsKey(key: "password");
      if (canCheckBiometrics && hasStoredCredentials) {
        bool authenticated = await auth.authenticate(
          localizedReason: "Scan your fingerprint to authenticate",
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
        if (authenticated) {
          // Retrieve stored credentials
          String? userName = await secureStorage.read(key: "userName");
          String? password = await secureStorage.read(key: "password");

          // Authenticate with the retrieved credentials
          checker = checkForLoginData(username: userName, password: password);
        }
        return checker;
      }
    } on PlatformException catch (e) {
      // authenticated = false;
      switch (e.code) {
        case "BiometricNotAvailable":
          const SnackBar(
            content: Text(
              "Biometric authentication is not available on this device.",
              selectionColor: Colors.red,
            ),
            duration: Duration(seconds: 2),
          );
          break;
        case "BiometricLockout":
          const SnackBar(
            content: Text(
              "Biometric authentication has been locked out.",
              selectionColor: Colors.red,
            ),
            duration: Duration(seconds: 2),
          );
          break;
        case "BiometricError":
          const SnackBar(
            content: Text(
              "An error occurred during biometric authentication.",
              selectionColor: Colors.red,
            ),
            duration: Duration(seconds: 2),
          );
          break;
        case "BiometricUnavailable":
          const SnackBar(
            content: Text(
              "Biometric authentication is unavailable.",
              selectionColor: Colors.red,
            ),
            duration: Duration(seconds: 2),
          );
          break;
        default:
          const SnackBar(
            content: Text(
              "An unknown error occurred during biometric authentication.",
              selectionColor: Colors.red,
            ),
            duration: Duration(seconds: 2),
          );
      }
      // isAuthenticated = false;
    }
    emit(FingerPrintAuthonticationState());
    return checker;
  }

  ///////////////////////////////////

  ///////////////////
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["userName"]);

  Future<void> handleSignIn() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        print("Access Token: ${googleAuth.accessToken}");
        print("ID Token: ${googleAuth.idToken}");
        // You can now send these tokens to your server for further processing.
      }
    } catch (error) {
      print(error);
    }
  }
  //////////////////////
}
