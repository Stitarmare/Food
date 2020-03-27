//import 'dart:ffi';

// API_BASE_HELPER Page

// URLs
const STR_PRODUCTION_URL = "http://18.219.185.86/";
const STR_DEVELOPEMENT_URL = "http://foodzi.php-dev.in/";
const STR_LOCAL_URL = "https://jsonplaceholder.typicode.com/";

// IMAGE_URLs
const STR_IMAGE_PRODUCTION_URL = "http://18.219.185.86/storage/";
const STR_IMAGE_DEVELOPEMENT_URL = "http://foodzi.php-dev.in/storage/";
const STR_IMAGE_LOCAL_URL = "https://jsonplaceholder.typicode.com/";

const STR_HEADER_TYPE = "application/json";
const STR_BEARER = "Bearer ";
const STR_ACCEPT_HEADER = "multipart/form-data";
const STR_TIMEOUT = "Timeout";
const STR_SERVER_MSG =
    "Looks like the server is taking to long to respond, please try again in sometime.";
const STR_WIFI_INTERNET = "Wifi/Internet";
const STR_NO_WIFI_INTERNET = "Wifi/Internet not detected. Please activate it.";
const STR_POST = "POST";
const STR_ERROR = "Error";
const STR_SESSION = "Session";
const STR_COULD_NOT_ACCESS = "Could not access";
const STR_ERROR_MSG =
    "Error occured while Communication with Server with StatusCode : ";

// APPEXCEPTION
const STR_ERROR_COMMUNICATION = "Error During Communication: ";
const STR_INVALID_REQUEST = "Invalid Request: ";
const STR_UNAUTHORISED = "Unauthorised: ";
const STR_INVALID_INPUT = "Invalid Input: ";

// MIX_STRING
const KEY_APP_NAME = 'foodZi';
const KEY_FONTFAMILY = 'gotham';
const KEY_APP_SLOGAN = 'Loading, please wait...';
const KEY_FIRST_NAME = 'First Name';
const KEY_LAST_NAME = 'Last Name';
const KEY_EMAIL_ID = 'Email ID';
const KEY_PASSWORD = 'Password';
const KEY_EDIT_PROFILE = 'Edit Profile';
const KEY_MOBILE_NUMBER = 'Mobile Number';
const KEY_PROVIDE_ANOTHER_NO = 'Provide Another Number';
const KEY_MOBILE_NUMBER_REQUIRED = 'Mobile Number is Required';
const KEY_COUNTRYCODE_REQUIRED = 'Required code';
const KEY_PINCODE_NUMBER_REQUIRED = 'Postal Code is Required';
const KEY_MOBILE_NUMBER_LIMIT = 'Mobile No. must have maximum 13 digits';
const KEY_COUNTRY_CODE_LIMIT = 'Out of limit';
const KEY_PIN_NUMBER_LIMIT = 'Postal Code must have 6 digits only';
const KEY_MOBILE_NUMBER_TEXT = 'Mobile No. must be digits';
const KEY_COUNTRY_CODE_TEXT = 'Must be digits';
const KEY_PIN_NUMBER_TEXT = 'Postal Code must be digits';
const KEY_ENTER_PASSWORD = 'Enter Password';
const KEY_ENTER_OLD_PASSWORD = 'Enter Old Password';
const KEY_ENTER_NEW_PASSWORD = 'Enter New Password';
const KEY_CONFIRM_PASSWORD = 'Confirm Password';
const KEY_SIGN_UP_WITH = KEY_SIGN_UP + ' with';
const KEY_SIGN_IN_WITH = KEY_SIGN_IN + ' with';
const KEY_THIS_SHOULD_NOT_BE_EMPTY = 'This should not be empty.';
const Key_SPECIAL_CHAR = 'This Should Not Contain @ Or Any Special Character';
const KEY_THIS_SHOULD_BE_ONLY_8_CHAR_LONG =
    'This should be only 8 characters long.';
const KEY_THIS_SHOULD_BE_ONLY_30_CHAR_LONG =
    'This should be only 30 characters long.';
const KEY_THIS_SHOULD_BE_ONLY_20_CHAR_LONG =
    'This should be only 20 characters long.';
const KEY_THIS_SHOULD_BE_10_PLUS_CHAR_LONG =
    'This should be more than 10 characters';
const KEY_THIS_SHOULD_BE_MIN_8_CHAR_LONG =
    'This should be minimum 8 characters';
const KEY_PLEASE_ENTER_CORRECT_PASSWORD = 'Please enter correct password';
const KEY_TERMS_AND_CONDITIONS = 'Terms and conditions';
const KEY_OK = 'OK';
const KEY_GET_OTP_ENTER_NO = 'Please enter your mobile number to get OTP';
const KEY_I_HAVE_READ_AND_ACCEPT_THE = 'I have read and Accept the';
const KEY_PRIVACY_POLICY = 'Privacy Policy';
const KEY_SIGN_UP = 'SIGN UP';
const KEY_SIGN_IN = 'SIGN IN';
const KEY_SIGNUP = 'Sign Up';
const KEY_SIGNIN = 'Sign In';
const KEY_NOW_EXLAMATION = 'Now !';
const KEY_USE_EMAIL_ADDRESS = 'use email address';
const KEY_FORGET_PASSWORD_QUES = KEY_FORGET_PASSWORD + '?';
const KEY_CURRENT_PASSWORD = 'Current Password';
const KEY_Name = 'Name';
const Key_USER_NAME = 'Username';
const KEY_NEW_PASSWORD = 'New Password';
const KEY_SUBMIT_BUTTON = 'SUBMIT';
const KEY_PASSWORD_DOESNT_MATCH = "Password doesn't Match";
const KEY_VERFICATION_OTP = 'Verification code sent to your';
const KEY_CHANGE_PASSWORD = 'Change Password';
const KEY_CONFIRM = 'Confirm';
const KEY_CANCEL = 'Cancel';
const KEY_OTP_SIGN_IN = 'Sign In using OTP';
const KEY_PASSWORD_CHANGE = 'Password Change';
const KEY_PASSWORD_REQUIRED = 'Password is Required';
const KEY_SUCCESS = 'Success';
const KEY_FAILED = 'Failed';
const KEY_MY_PROFILE = 'My Profile';
const KEY_NEW_USER_QUES = 'New User?';
const KEY_MY_ACCOUNT = 'My Account';
const KEY_MY_ORDER = 'My Orders';
const KEY_FAVOURITE = 'Favourite';
const KEY_WALLET = 'Wallet';
const KEY_SETTINGS = 'Settings';
const KEY_HELP = 'Help?';
const KEY_ABOUT_US = 'About Us';
const KEY_LOG_OUT = 'Log out';
const KEY_FORGET_PASSWORD = 'Forgot Password?';
const KEY_SEND_OTP = 'Send OTP';
const KEY_YOUR_NEW_PASSWORD = 'Your ' + KEY_NEW_PASSWORD;
const KEY_CONFIRM_YOUR_PASSWORD = 'Confirm Your Password';
const KEY_HURAY_PASSWORD_CHANGE_SUCCESSFULLY =
    'Huray! Password Change Successfully!!!';

//Drawer.dart
const KEY_SIGN_OUT = 'Sign Out';

//EditProfile.dart
const KEY_STREET = 'Street';
const KEY_COUNTRY = 'Country';
const KEY_STATE = 'State';
const KEY_CITY = 'City';
const KEY_POSTAL_CODE = 'Postal Code';
const KEY_UPDATE = 'UPDATE';
const KEY_CANCEL_UC = 'CANCEL';

//font-sizes
const double FONTSIZE_6 = 6;
const double FONTSIZE_15 = 15;
const double FONTSIZE_16 = 16;
const double FONTSIZE_17 = 17;
const double FONTSIZE_12 = 12;
const double FONTSIZE_10 = 10;
const double FONTSIZE_14 = 14;
const double FONTSIZE_13 = 13;
const double FONTSIZE_18 = 18;
const double FONTSIZE_22 = 22;
const double FONTSIZE_20 = 20;
const double FONTSIZE_25 = 25;
const double FONTSIZE_32 = 32;
const double FONTSIZE_24 = 24;
const double FONTSIZE_11 = 11;

// AddItemPageView & AddItemPageViewTA
const KEY_INVALIDORDER = "Invalid Order";
const KEY_ORDERFROMREST =
    "Sorry, you can't order from this restaurant right now.";
const KEY_ADDTOCART = "Add To Cart";
const STR_STARTNEWORDER = "Start a new order?";
const STR_YOURUNFINIHEDORDER = "Your unfinished order at ";
const STR_WILLDELETE = "will be deleted.";
const STR_UNFINISHEDORDER =
    "Your unfinished order at previous hotel will be deleted.";
const STR_NEWORDER = "NEW ORDER";
const STR_CANCEL = "CANCEL";
const RESTAURANT_IMAGE_PATH = "assets/HotelImages/Image12.png";
const STR_QUANTITY = 'Quantity:';
const STR_SPREADS = 'Spreads';
const STR_SELECT_OPTION = 'Please select any one option';
const STR_ADDITIONS = 'Additions';
const STR_MULIPLE_OPTIONS = 'You can select multiple options';
const STR_SIZE = 'Size';
const STR_DATA = "data";
const STR_OK = "Ok";
const STR_CARTADDED = "is successfully added to your cart.";
const SUCCESS_IMAGE_PATH = 'assets/SuccessIcon/success.png';

// ChangePassword Page
const STR_CHANGE_PASSWORD = 'Change Your Password';
const STR_GROUP_IMAGE = 'assets/LockImage/Group_1560.png';
const double PI_VALUE = 3.14;
const STR_PWD_NOT_MATCHED = 'Password does not match with confirm password.';
const STR_PWD_CHANGED_SUCCESS = 'Your password has been successfully change. ';
const JSON_STR_OLD_PWD = 'old_password';
const JSON_STR_NEW_PWD = 'new_password';
const JSON_STR_PWD_CONFIRM = 'new_password_confirmation';

// DineInPage
const int pageNumber = 1;
const STR_DISTANCE = "Distance";
const STR_POPULARITY = "Popularity";
const STR_RATINGS = "Ratings";
const STR_FAVORITE = "Favourites Only ";
const STR_PLEASE_WAIT = "Please Wait";
const STR_DINE_IN = "Dine In";
const FOODZI_LOGO_PATH = "assets/Logo/foodzi_logo.jpg";
const STR_ORDER_EASY = 'ORDER EASY';
const LEVEL_IMAGE_PATH = 'assets/LevelsIcon/levels.png';
const STR_SMALL_DISTANCE = "distance";
const STR_SMALL_RATING = "rating";
const STR_SMALL_FAVOURITE = "favourite";
const STR_SORT_BY = 'Sorted By';
const STR_FLITER_BY = 'Filter By';
const STR_CURRENT_LOCATION = "Please wait while getting your current location!";
const STR_NO_RESTAURANT = 'No restaurants found.';
const STR_KM = "km";
const JSON_STR_LATI = "latitude";
const JSON_STR_LONG = "longitude";
const JSON_STR_SORT_BY = "sort_by";
const JSON_STR_SEARCH_BY = "search_by";
const JSON_STR_PAGE = "page";

// drawer page
const STR_IMAGE_PATH = 'assets/BackgroundImage/Group1649.png';
const STR_IMAGE_PATH1 = 'assets/SignOutIcon/Group1349.png';
const STR_VERSION_NO = "Version 1.2";

// EditProfile Page
const STR_CHOOSE_COUNTRY = 'Choose Country';
const STR_WHERE_FROM = 'Where are you from';
const STR_FROM = 'From';
const STR_CHOOSE_STATE = 'Choose State';
const STR_CHOOSE_CITY = 'Choose City';
const STR_VALIDATE_NAME = r'^[a-zA-Z]';
const STR_VALIDATE_PIN = r'(^[1-9][0-9]{5}$)';
const STR_EDIT_PROFILE = "Edit Profile";
const STR_ACCOUNT_UPDATED =
    'Your account details has been successfully updated. ';
const STR_DONE = "Done";
const JSON_STR_STATE_ID = "state_id";
const JSON_STR_FIRSTNAME = 'first_name';
const JSON_STR_LASTNAME = 'last_name';
const JSON_STR_ADDRESS = 'address_line_1';
const JSON_COUNTRY_ID = 'country_id';
const JSON_STATE_ID = 'state_id';
const JSON_CITY_ID = 'city_id';
const JSON_POSTAL_ID = 'postal_code';

// EnterOTP page
const KEY_FONT_SEGOEUI = 'SegoeUI';
const STR_CODE = "Code";
const OTP_LOGO_PATH = 'assets/PhoneImage/Group_295.png';
const STR_VALIDATE_MOB_NO = r'(^[0-9]*$)';
const STR_VALIDATE_COUNTRY_CODE = r'(^[0-9]*$)';
const JSON_STR_MOB_NO = "mobile_number";

// LandingView Page
const MENU_IAMGE_PATH = 'assets/MenuIcon/menu.png';
const FODDZI_LOGO_3X = "assets/Logo/foodzi_logo@3x.jpg";
const STR_HELLO = 'Hello';
const STR_FAV_FINGERTIP = 'All your favourites at your fingertip !!';
const DINE_IN_IMAGE_PATH = 'assets/DineInImage/Group1504.png';
const STR_DINEIN_TITLE = 'Dine-in';
const STR_SERVED_RESTAUTRANT = 'Get served in Restaurant';
const STR_VIEW_YOUR_ORDER = 'View Your Order';
const TAKE_AWAY_IMAGE_PATH = 'assets/TakeAwayImage/Group1505.png';
const STR_PAID = "paid";
const STR_COLLECTION = 'Collection';
const STR_ORDER_TO_COLLECT = 'Order to Collect';
const STR_MAIN = 'main';
const STR_HOME = 'Home';
const STR_SETTING = 'Settings';
const STR_GALLERY = 'Gallery';
const STR_TERMS_CONDITION = 'Terms & Conditions';
const STR_FAVORITE_TITLE = 'Favorites';
const STR_PRIVACY_POLICY = 'Privacy Policy';
const STR_NOTIFICATION = 'Notification';
const STR_ABOUT_US = 'About Us';
const STR_INVITE = 'invite';
const STR_HELP = 'Help';
const PROFILE_IMAGE_PATH = 'assets/PlaceholderImage/placeholder.png';

// Login Page
const KEY_FONT_HELVETICANEUE = 'HelveticaNeue';
const STR_PLUS_SIGN = '+';
const STR_ACCOUNT = "Don't have an account?";
const STR_INPUTFORMAT = '[ ]';
const JSON_STR_PWD = 'password';

// MenuItemDropDown Page
const STR_ZERO = "0";
const JSON_STR_REST_ID = "rest_id";

// MyCartView Page and MyCartTakeAway
const STR_LOADING = "Loading";
const STR_NO_TABLE = "No Tables available";
const STR_MYCART = 'My Cart';
const STR_ADD_MORE_ITEM = 'Add More Items';
const STR_SELECT_TABLE = "Please select table number first.";
const STR_ADD_ITEM_CART = "Please add items to your cart first.";
const STR_PLACE_ORDER = 'PLACE ORDER';
const STR_CHOOSE_TABLE = 'Choose Table';
const STR_ADD_TABLE = "Add Table Number ";
const STR_TABLE_NO = "Table Number";
const STR_VEG = "veg";
const IMAGE_VEG_ICON_PATH = 'assets/VegIcon/Group1661.png';
const STR_ITEM_NAME = 'Bacon & Cheese Burger';
const STR_NOTHING_CART = "Nothing in the Cart";
const JSON_STR_USER_ID = "user_id";
const JSON_STR_CART_ID = 'cart_id';
const JSON_STR_TABLE_ID = "table_id";
const JSON_STR_QUANTITY = "quantity";
const JSON_STR_AMOUNT = "amount";
const STR_SUMBIT = 'SUBMIT';
const STR_ITEM_DESC = " Lorem Epsom is simply dummy text";
const STR_SEVENTEEN = '17';

// MyOrders Page & MyOrderTake Away
const STR_SMALL_DINEIN = "dine_in";
const STR_YOUR_ORDERS = "Your Orders";
const STR_CURRENT_ORDER = 'Current Orders';
const STR_BOOKING_HISTORY = 'Booking History';
const STR_ITEMS = 'ITEMS';
const STR_ORDERED_ON = 'ORDERED ON ';
const STR_ORDER_TYPE = 'ORDERED TYPE';
const STR_TOTAL_AMOUNT = 'TOTAL AMOUNT';
const STR_VIEW_ORDER_DETAILS = "VIEW ORDER DETAILS";
const STR_TIME = '06 Feb 2020 at 12:05 PM';
const STR_REPEAT_ORDER = 'Repeat Order';
const JSON_STR_ORDER_TYPE = "order_type";
const STR_TAKE_AWAY = "take_away";
const STR_STATUS = "Status :";

// MyProfileBottomPage
const ITEM_IMAGE_PATH = 'assets/BlurImage/Group1612.png';
const STR_MY_PROFILE = "My Profile";
const STR_SELECT_ONE = 'Select One';
const STR_CAMERA = 'Camera';
const STR_NA = "N.A.";

// Notification Page
const STR_NO_NOTIFICATION = "No Notifications!!";
const STR_INVITATION = "invitation";
const STR_COMMA = ",";
const STR_SPACE = " ";

// Notifications Page
const STR_NOTIFICATION_TITLE = "Notifications";
const STR_NO_NOTIFI_TITLE = " No Notification";
const JSON_STR_FORM_ID = "from_id";
const JSON_STR_INVITATION_ID = "invitation_id";
const JSON_STR_STATUS = "status";

// OrderConfirmation2 Page
const STR_MAKE_PAYMENT = 'MAKE PAYMENT';
const STR_WIMPY_TITLE = 'Wimpy';
const STR_SEVENTEEN_TITLE = '\$17';

// OTPView Page
const STR_MOBILE_NUMBER = 'mobile number';
const STR_NO_CODE = "Didn’t received the code?";
const STR_RESEND = 'RESEND';
const STR_RESEND_OTP = "Resend OTP";
const JSON_STR_DEVICE_TOKEN = 'device_token';
const JSON_STR_DEVICE_TYPE = 'device_type';
const JSON_STR_USER_TYPE = 'user_type';
const JSON_STR_OTP = 'otp';
const STR_CUSTOMER = "customer";
const STR_ONE = "1";
const STR_DSA = "dsa";
const STR_RANDOM = 'gfgfg';
