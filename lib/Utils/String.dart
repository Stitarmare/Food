// Main Page
const STR_SPLASH_SCREEN_PAGE_INITIAL = '/';
const STR_SPLASH_SCREEN_PAGE = '/SplashScreen';
const STR_LOGIN_PAGE = '/LoginView';
const STR_MAIN_WIDGET_PAGE = '/MainWidget';
const STR_REGISTRATION_PAGE = '/Registerview';
const STR_RESET_PWD_PAGE = '/ResetPasswordview';
const STR_CHANGE_PWD_PAGE = '/ChangePasswordview';
const STR_OTP_SCREEN_PAGE = '/OTPScreen';
const STR_OTP_SCREEN_UPATE = '/UpdateNoOTPScreen';
const STR_ENTER_OTP_PAGE = '/EnterOTPScreen';
const STR_DINE_IN_PAGE = '/DineInView';
const STR_TAKE_AWAY_PAGE = '/TakeAwayView';
const STR_PROFILE_PAGE = '/ProfileScreen';
const STR_EDIT_PROFILE_PAGE = '/EditProfileview';
const STR_RETAURANT_PAGE = '/RestaurantView';
const STR_RESTAURANT_TAKE_AWAY_PAGE = '/RestaurantTAView';
const STR_NOTIFICATION_PAGE = '/NotificationView';
const STR_MYORDER_PAGE = '/MyOrders';
const STR_MYORDER_TAKE_AWAY_PAGE = '/MyOrderTakeAway';
const STR_BOTTOM_PROFILE_PAGE = '/BottomProfileScreen';
const STR_BOTTOM_NOTIFICATION_PAGE = '/BottomNotificationView';
const STR_RETAURANT_INFO_PAGE = '/RestaurantInfoView';
const STR_ADD_ITEM_PAGE = '/AddItemPageView';
const STR_ADD_ITEM_TAKE_AWAY_PAGE = '/AddItemPageTAView';
const STR_MY_CART_PAGE = '/MyCart';
const STR_ORDER_CONFIRM_2_PAGE = '/OrderConfirmation2View';
const STR_CONFIRMATION_DINE_PAGE = '/ConfirmationDineView';
const STR_WEB_VIEW_PAGE = '/webview';
const STR_PAYMENT_PAGE = '/PaymentMethod';
const STR_STATUS_TRACK_PAGE = '/StatusTrackView';
const STR_WEB_VIEW_SCREEN_PAGE = '/WebViewScreen';
const STR_CART_DETAILS_PAGE = '/CartDetailsPage';
const STR_ENTER_MOBILE_PAGE = '/EnterMobileNoPage';
const STR_CATEGORY_SECTION = '/CategoriesSection';
const STR_PAYMENT_RECEIPT_DINE = '/PaymentReceiptDineView';

// API_BASE_HELPER Page

// URLs
const STR_PRODUCTION_URL = "https://www.foodzi.app/";
const STR_DEVELOPEMENT_URL = "http://foodzi.php-dev.in/";
const STR_LOCAL_URL = "http://3.12.75.171/";

// IMAGE_URLs
const STR_IMAGE_PRODUCTION_URL = "https://www.foodzi.app/storage/";
const STR_IMAGE_DEVELOPEMENT_URL = "http://foodzi.php-dev.in/storage/";
const STR_IMAGE_LOCAL_URL = "http://3.12.75.171/storage/";

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

// SharedPreference Page
const STR_AUTH_KEY = "AUTH_KEY";
const STR_USER_DATA = 'USER_DATA';
const STR_CART_ITEM_COUNT = "DINE_CART_ITEM_COUNT";
const STR_TAKE_AWAY_ITEM_COUNT = "TAKE_AWAY_ITEM_COUNT";
const STR_DELIVERY_ITEM_COUNT = "DELIVERY_ITEM_COUNT";
const STR_IS_ALREADY_IN_CART = "IS_ALREADY_IN_CART";
const STR_RESTAURANT_ID = "RESTAURANT_ID";
const STR_IS_ALREADY_IN_CART_TA = "IS_ALREADY_IN_CART_TA";
const STR_RESTAURANT_ID_TA = "RESTAURANT_ID_TA";
const STR_RETAURANT_NAME = "RESTAURANT_NAME";
const STR_ORDER_ID = "ORDER_ID";
const STR_CURRENT_ORDER_ID = "CURRENT_ORDER_ID";
const STR_CURRENT_REST_ID = "CURRENT_RESTAURANT_ID";
const STR_IS_DINE_IN = "ISDINEIN";
const STR_TABLE_ID = "TABLE_ID";

// APPEXCEPTION
const STR_ERROR_COMMUNICATION = "Error During Communication: ";
const STR_INVALID_REQUEST = "Invalid Request: ";
const STR_UNAUTHORISED = "Unauthorised: ";
const STR_INVALID_INPUT = "Invalid Input: ";

// MIX_STRING
const STR_R_CURRENCY_SYMBOL = "R";
const KEY_APP_NAME = 'foodZi';
const KEY_FONTFAMILY = 'gotham';
const STR_DOLLAR_SIGN = "\$ ";
const double PI_VALUE = 3.14;
const KEY_APP_SLOGAN = 'Loading, please wait...';
const KEY_FIRST_NAME = 'First Name';
const KEY_LAST_NAME = 'Last Name';
const KEY_EMAIL_ID = 'Email ID';
const STR_NULL = "null";
const KEY_PASSWORD = 'Password';
const KEY_EDIT_PROFILE = 'Edit Profile';
const KEY_MOBILE_NUMBER = 'Mobile Number';
const KEY_PROVIDE_ANOTHER_NO = 'Provide Another Number';
const KEY_MOBILE_NUMBER_REQUIRED = 'Mobile Number is Required';
const KEY_COUNTRYCODE_REQUIRED = 'Required code';
const KEY_PINCODE_NUMBER_REQUIRED = 'Postal Code is Required';
const KEY_MOBILE_NUMBER_LIMIT = 'Mobile No. must have maximum 13 digits';
const KEY_COUNTRY_CODE_LIMIT = 'Out of limit';
const KEY_PIN_NUMBER_LIMIT = 'Postal Code must have 4 digits only';
const KEY_MOBILE_NUMBER_TEXT = 'Mobile No. must be digits';
const KEY_COUNTRY_CODE_TEXT = 'Must be digits';
const KEY_PIN_NUMBER_TEXT = 'Postal Code must be 4 digits';
const KEY_ENTER_PASSWORD = 'Enter Password';
const KEY_ENTER_OLD_PASSWORD = 'Enter Old Password';
const KEY_ENTER_NEW_PASSWORD = 'Enter New Password';
const KEY_CONFIRM_PASSWORD = 'Confirm Password';
const KEY_SIGN_UP_WITH = KEY_SIGN_UP + ' with';
const KEY_SIGN_IN_WITH = KEY_SIGN_IN + ' with';
const KEY_THIS_SHOULD_NOT_BE_EMPTY = 'This should not be empty.';
const STR_ADDRESS_REQUIRED = 'Address field is required';
const STR_CITY_REQUIRED = 'City field is required';
const STR_STATE_REQUIRED = 'State field is required';
const STR_COUNTRY_REQUIRED = 'Country field is required';

const STR_STREET_TITLE = 'Street field is required';
const STR_FIRST_NAME_REQUIRED = 'First name is required';
const STR_LAST_NAME_REQUIRED = 'Last name is required';
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
const PASSWORD_SHOULD_BE_MIN_8_CHAR_LONG =
    'Password should be minimum 8 characters';
const KEY_PLEASE_ENTER_CORRECT_PASSWORD = 'Please enter correct password';
const KEY_TERMS_AND_CONDITIONS = 'Terms and conditions';
const KEY_OK = 'OK';
const KEY_GET_OTP_ENTER_NO = 'Please enter your mobile number to get OTP';
const KEY_ENTER_NO = 'Please enter your new mobile number to get OTP';
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
const STR_ADDTOCART = "Add To Cart";
const STR_STARTNEWORDER = "Start a new order?";
const STR_YOUR_UNFINIHED_ORDER = "Your unfinished order at ";
const STR_WILLDELETE = "will be deleted.";
const STR_UNFINISHEDORDER =
    "Your unfinished order at previous hotel will be deleted.";
const STR_NEWORDER = "NEW ORDER";
const STR_CANCEL = "CANCEL";
const RESTAURANT_IMAGE_PATH = "assets/HotelImages/Image12.png";
const STR_QUANTITY = 'Quantity:';
const STR_SPREADS = 'Options';
const STR_SPLREQ = 'Special Request (eg. No bacon)';
const STR_REQUIRED = "REQUIRED";
const STR_SELECT_OPTION = 'Please select any one option';
const STR_ADDITIONS = 'Additions';
const STR_SWITCHES = 'Switches';
const STR_MULIPLE_OPTIONS = 'You can select multiple options';
const STR_SIZE = 'Size';
const STR_DATA = "data";
const STR_OK = "Ok";
const STR_OK_TITLE = "OK";
const STR_CARTADDED = "is successfully added to your cart.";
const SUCCESS_IMAGE_PATH = 'assets/SuccessIcon/success.png';
const JSON_STR_ITEM_ID = "item_id";

// ChangePassword Page
const STR_CHANGE_PASSWORD = 'Change Your Password';
const IMAGE_LOCK_PATH = 'assets/LockImage/Group_1560.png';
const STR_PWD_NOT_MATCHED = 'Password does not match with confirm password.';
const STR_PWD_CHANGED_SUCCESS =
    'Your password has been successfully change, Please login again.';
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
const STR_DELIVERY_FOOD = "Delivery";
const FOODZI_LOGO_PATH = "assets/Logo/foodzi_logo.png";
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
const STR_REQUEST_TBL_MSG =
    " or you can send request for table owner to join table";
const STR_TABLE_STATUS_TITLE = "Table Status";
const JSON_STR_LATI = "latitude";
const JSON_STR_LONG = "longitude";
const JSON_STR_SORT_BY = "sort_by";
const JSON_STR_SEARCH_BY = "search_by";
const JSON_STR_PAGE = "page";
const JSON_STR_DELIVERY = "delivery";

// drawer page
const STR_IMAGE_PATH = 'assets/BackgroundImage/Group1649.png';
const STR_IMAGE_PATH1 = 'assets/SignOutIcon/Group1349.png';
const STR_VERSION_NO = "Version";
const STR_I_AGREE = "I AGREE";

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
const FODDZI_LOGO_3X = "assets/Logo/foodzi_logo.png";
const STR_HELLO = 'Hello';
const STR_HI = "Hi";
const STR_FAV_FINGERTIP = 'All your favourites at your fingertip !!';
const STR_WHAT_LIKE_TO_DO = 'What would you like to do?';
const DINE_IN_IMAGE_PATH = 'assets/DineInImage/Group1504.png';
const STR_DINEIN_TITLE = 'Dine-in';
const STR_DELIVERY_TITLE = "Delivery";

const STR_SERVED_RESTAUTRANT = 'Get served in Restaurant';
const STR_VIEW_YOUR_ORDER = 'Track Your Order';
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
const STR_FIELD_REQUIRED = " This field required";

const STR_COLLECT_FOOD = 'I WANT TO COLLECT MY FOOD';
const STR_DELEIVER_FOOD = 'PLEASE DELIVER MY FOOD';
const STR_PLACE_FOOD = 'I AM PLACING A DINE-IN ORDER';

// MapView Page
const STR_ADDRESS_SELECTION = "Add Selection";
const STR_CONFIRM_ADDRESS = "Confirm Address";
const STR_CHANGE_ADDRESS = "Change Address";

// Login Page
const KEY_FONT_HELVETICANEUE = 'HelveticaNeue';
const STR_PLUS_SIGN = '+';
const STR_ACCOUNT = "Don't have an account?";
const STR_INPUTFORMAT = '[ ]';
const JSON_STR_PWD = 'password';
const STR_MESSAGE = "Mobile number not registered";

// MenuItemDropDown Page
const STR_ZERO = "0";
const JSON_STR_REST_ID = "rest_id";
const JSON_STR_REST_PAGE = "page";

// MyCartView Page and MyCartTakeAway
const STR_LOADING = "Loading";
const STR_NO_TABLE = "No Tables available";
const STR_MYCART = 'My Cart';
const STR_ADD_MORE_ITEM = 'Add More Items';
const STR_SELECT_TABLE = "Please select table first.";
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
const JSON_STR_CURRENCY = "currency";
const JSON_STR_ORDER_ID_1 = "order_id";

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
const STR_SPLIT_AMOUNT = 'SPLIT AMOUNT';
const STR_VIEW_ORDER_DETAILS = "VIEW ORDER DETAILS";
const STR_VIEW_DRIVER_DETAILS = "VIEW DRIVER DETAILS";
const STR_CANCELLED = "cancelled";

const STR_TIME = '06 Feb 2020 at 12:05 PM';
const STR_REPEAT_ORDER = 'Repeat Order';
const JSON_STR_ORDER_TYPE = "order_type";
const STR_TAKE_AWAY = "take_away";
const STR_STATUS = "Status :";
const STR_SMALL_DELIVERY = "delivery";
const DELV_CHARGE = "Delivery charge";
const STR_DELIVERY = "delivery";
const STR_BIG_DELIVERY = "DELIVERY";
const STR_BIG_DINE_IN = "DINE IN";
const STR_PAID_SMALL = "paid";

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
const BUZZ = "buzz";
const ORDERITEMSTATUS = "order_item_status";
const UPDATEFORTABLESSIGNED = "updates_for_assigned_table";
const TABLEIDLE = "table_idle";
const MOVINGOUTOFRADIUS = "moving_out_of_radius";
const SPLITBILLREQUEST = "split_bill_request";
const APPUPDATE = "app_update";
const SPLITBILLPAYMENT = "split bill payment";
const STR_INVITE_REQUEST = "invite request";
const STR_INVITE_RESPONSE = "invitation response";

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
const STR_NO_CODE = "Didn’t receive the code?";
const STR_RESEND = 'RESEND';
const STR_RESEND_OTP = "Resend OTP";
const STR_RESEND_OTP_SUCCESS =
    "OTP has been successfully send to your mobile number.";
const STR_UPDATE_NO = "Update Mobile Number";
const STR_UPDATE_NO_SUCCESS = " Your mobile number updated successfully";
const JSON_STR_DEVICE_TOKEN = 'device_token';
const JSON_STR_DEVICE_TYPE = 'device_type';
const JSON_STR_USER_TYPE = 'user_type';
const JSON_STR_OTP = 'otp';
const STR_CUSTOMER = "customer";
const STR_ONE = "1";
const STR_DSA = "dsa";
const STR_RANDOM = 'gfgfg';

// PaymentTipandPay Page and PaymentTipandPay Take Away
const STR_PAYMENT = "Payment";
const STR_PLACE_ORDER_PAY_BILL = 'PLACE ORDER & PAY BILL';
const STR_BILL_DETAILS = 'Bill Details';
const STR_SUBTOTAL = 'Subtotal';
const SPLIT_AMOUNT = "Split amount";
const STR_ELEVEN = ' 11.20';
const STR_TIP = 'Tip';
const STR_TOTAL = 'Total';
const STR_CHECKOUT_CODE = 'check_out_code';
const STR_FOODZI_TITLE = "Foodzi";
const STR_PAYMENT_FAILED = "Payment Failed.";
const STR_PAYMENT_CANCELLED = "Payment Cancelled.";
const STR_CARD = 'card';
const STR_PAYMENT_SUCCESS = "Payment Success";
const STR_TRANSACTION_DONE = "Your Transactions Has been Done Successfully";
const JSON_STR_TOTAL_AMOUNT = "total_amount";
const JSON_STR_LATITUDE = "latitude";
const JSON_STR_LONGITUDE = "longitude";
const JSON_STR_ITEMS = "items";
const JSON_STR_ADDRESS_HOUSENO = "address";
const JSON_STR_LANDMARK = "landmark";

const STR_SPLIT_BILL = 'Split Bill';
const STR_ADD_PEOPLE_FIRST_SPLIT_BILL =
    " Please add your friends to split the bill";
const STR_PAY_BILL = 'PAY BILL';
const STR_SELECT_TBL = "Selected Table : ";
const STR_TABLE_1 = "Table 1";
const STR_ELEVEN_TITLE = '\$11.20';
const JSON_STR_ORDER_ID = "order_id";
const JSON_STR_ENCRYPTED_CODE = "encrypted_checkout_id";
const JSON_STR_PAYMENT_MODE = "payment_mode";
const JSON_STR_TIP = "tip";
const JSON_STR_TRANSACTION_ID = "transaction_id";
const JSON_STR_DELIVERY_CHARGE = "delivery_charge";
const STR_DELIVERED = "delivered";
const STR_COMPLETED = "completed";

// ProfilePage
const BACK_ARROW_IMAGE_PATH = 'assets/BackButtonIcon/Path1621.png';
const JSON_STR_PROFILE_IMAGE = "profile_image";

// RegistrationPage
const STR_DETAILS_ARE = "Details are : ";
const STR_VALIDATE_NAME_TITLE = r'^[a-zA-Z0-9]';
const STR_ALREADY_ACCOUNT = "Already have an Account?";
const JSON_STR_PASSWORD = 'password';

// ResetPassView Page
const STR_RESET_PASSWORD = 'Reset Your Password';
const STR_PWD_CHANGED = 'Your password has been successfully reset. ';
const JSON_STR_PWD_CONFIRMATION = 'password_confirmation';

// RestaurantInfoView Page
const HOTEL_IMAGE_PATH = "assets/HotelImages/Image31.png";
const HOTEL_IMAGE_PATH_1 = "assets/HotelImages/MaskGroup20.png";
const NAVIGATE_IMAGE_PATH = 'assets/NavigateButton/next(2).png';
const STR_REVIEWS = "Reviews";
const STR_FETCHING_INFO = "Please wait, fetching Restaurant Info!";
const BACK_BTN_ICON_PATH = 'assets/BackButtonIcon/Path1621.png';
const STR_OPENING_HOURS = 'Opening Hours';
const STR_NO_SCHDUL_AVL = 'No Schedule Available';
const STR_DASH_SIGN = "-";
const STR_WRITE_REVIEWS = 'Write Review';
const STR_NO_REVIEWS = 'No Reviews';
const STR_RESTAURANT_INFO = 'Restaurants Info';
const STR_BLANK = "";
const JSON_STR_DESC = "description";
const JSON_STR_RATING = "rating";
const STR_ADD_REVIEW = "Add Review";
const STR_ADD_REVIEW_RATING = "Add Review & Ratings";
const STR_REVIEW_SUMBITTED = "Review Submitted";
const STR_ADD_RATING = "Add Rating";

// Restaurant View
const STR_CURRENCY_SYMBOL = "currencySymbol";

// RestaurantView Page and RestaurantViewTakeAway
const STR_NO_ITEM_FOUND = 'No items found.';
const STR_VEG_ONLY = 'Veg only';
const STR_MENU = "Menu";
const FOOD_IMAGE_PATH = "assets/PlaceholderFoodImage/MaskGroup55.png";
const STR_ADD = "+ ADD";
const JSON_STR_MENU_TYPE = "menu_type";
const JSON_STR_CATEGORY_ID = "category_id";
const JSON_STR_SUBCATEGORY_ID = "subcategory_id";
const STR_NO_ITEMS_FOUND = 'No items found.';

// SplashScreen Page
const STR_SMALL_NOTIFI = 'notification';
const STR_SMALL_TITLE = 'title';
const STR_BODY = 'body';
const SPLASH_SCREEN_IAMGE_PATH = 'assets/SplashScreen/LauncherScreen.png';
const SPLASH_SCREEN_LAUNCHER_IMAGE_PATH = 'assets/SplashScreen/LauncherImg.png';

// SplitBill Page
const JSON_STR_OPTION = "option";

// SplitBillNotification Page
const JSON_STR_USERS = "users";

// StatusTrackView Page and StatusTrackView Take Away
const STR_ORDER_STATUS = "Order Status";
const STR_BILL_PAYMENT = 'BILL PAYMENT';
const STR_ADD_MORE_PEOPLE = 'Add More People';
const STR_ORDER_FOR = "Order for ";
const STR_ORDER_CONFIRM =
    " is confirmed. Please wait while kitchen updates time for prepration. You will be notified about the status.";
const STR_STATUS_NOTIFIED = "You will be notified about the status.";
const STR_PLEASE_WAIT_NOTIFI =
    "Please wait while kitchen updates time for prepration. You will be notified about the status.";

// ConfirmationDineView Page
const STR_ASAP = 'ASAP';
const STR_WITHIN_1_HOUR = 'Within 1 hour';
const STR_WITHIN_2_HOUR = 'Within 2 hours';
const STR_WITHIN_3_HOUR = 'Within 3 hours';
const STR_CONFIRM_PLACE_ORDER = 'CONFIRM & PLACE ORDER';
const STR_TABLE_NUMBER = "Table Number :";
const STR_HOW_SOON_WANT = 'How soon do you want it ?';
const STR_SELECT_TABLE_TITLE = "Select Table";
const STR_ORDER_PLACED = "Order Placed";
const STR_ORDER_SUCCESS = "Your order has been successfully placed.";

// GeoLOcationTracking Page
const STR_ACCESS_DENIED = "Access Denied";
const STR_ENABLE_LOCATION =
    "Please enable location services to show you nearby restaurants and hotels";
const STR_ALLOW_LOCATION = "Please Allow The Loaction Services On";
const STR_ALLOW_LOCATION_SERVICE =
    "Please Allow The Loaction Service Enabled To Get Info";

// InvitePeopleDialogSpliBill Page
const STR_SPLIT_BILL_BTWN = 'Split Bill between Members';
const STR_CANCEL_TITLE = 'Cancel';
const STR_INVITE_ID = "invite_id";

// NotificationDialog Page
const STR_JOINING_TABLE = 'Joining a table?';
const STR_IS_TRYING_TO_ADD = 'is trying to add you for';
const STR_TABLE_NUMBER_SMALL = 'table number';
const STR_JOIN = 'JOIN';
const STR_REJECT = 'REJECT';

// OrderItemDialogSplitBill Page
const STR_SPLIT_BILL_ON_ORDER = 'Split Bill On Order Items';

// RadioDialog Page
const STR_MANGO = 'Mango';
const STR_SPLIT_BILL_AMONG_ALL = "Split equally among all";
const STR_SPLIT_BILL_CERTAIN_MEMB =
    "Split between certain members by clicking the checkbox";
const STR_SPLIT_BILL_ORDER_ITEMS = "Split based on order items";
const STR_SPLIT_BILL_USER_SPECIFIC =
    "Split for order made from user specific order items ";
const STR_CONFIRM = 'CONFIRM';

// SliderPOP Page
const STR_SELECT_RATING = 'SELECT RATING';
const STR_SELECTED_RATING = "SELECTED RATING: ";
const STR_FIVE = "/5.0";
const STR_DONE_TITLE = 'DONE';

// UserSpecificOrderDialogSplitBill Page
const STR_SPLIT_BILL_USER_SPECIFIC_TITLE = 'Split Bill on User Specific Items';
const STR_PEOPLE_FOR_THE_ITEM = "People for the Item";

// WebView Page
const STR_GOOGLE_URL = "https://google.co.in";
const STR_URL_TERMS_CONDITION = "http://foodzi.php-dev.in/terms-and-conditions";
const STR_URL_TERMS_CONDITION_TITLE = "terms-and-conditions";
const STR_URL_PRIVACY_POLICY = "http://foodzi.php-dev.in/privacy-policy";
const STR_URL_ABOUT_US = "http://foodzi.php-dev.in/about";

// KeyBoardAction Page
const STR_CUSTOM_ACTION = "Custom Action";
const STR_CLOSE = "CLOSE";
const STR_CUSTOM_FOOTER = 'Custom Footer';

// RadioDialogAddPeople
const STR_ADD_PEOPLE = 'Add People';
const STR_SENDING_INVITATION = "Sending Invitation to ";
const STR_INVITATION_SEND = "Invitation Send";
const STR_INVITATION_SUCCESS = "Invitation has been send Successfully!!";
const STR_ADD_TITLE = "Add ";
const STR_PEOPLE = "People";
const STR_JOINED_PEOPLE = "Joined People";

// TakeAwayBottombar Page
const STR_BTN_BUZZER = "btnBuzzer";
const CLOCK_IMAGE_PATH = 'assets/ClockIcon/clock.png';
const STR_BTN_ADD_CART = "btnAddCart";
