class EndPoints {
  static const String baseUrl =
      'https://massage-app.softwarecloud2.com/api/v1/';
  static const String googleMapsBaseUrl = 'https://maps.googleapis.com';
  static const String imageUrl = 'https://massage-app.softwarecloud2.com/';
  static const String apiKey = 's7xrpFdw4G0F21rfLyD4TaBkjVJYgwGfI3y60OyRnjw9zOggruX30e1as2d3';
  static const String topic = 'casa';
  static const String logIn = 'login';
  static const String register = 'client';
  static const String forgetPassword = 'resetPassword/email';
  static const String checkMailForResetPassword = 'resetPassword/checkCode';
  static const String resetPassword = 'resetPassword/newPassword';
  static changePassword(id) => 'changePassword/$id';
  static const String resend = 'email/verification';
  static const String verifyEmail = 'check/verificationCode';
  static getProfile(id) => 'client/$id';
  static updateProfile(id) => 'client/$id';
  static getFavourites(id) => 'favorites/$id';
  static getNotifications(id) => 'notification/$id';
  static getAddresses(id) => 'address/$id';
  static deleteAddress(id) => 'address/$id';
  static String addAddress = 'address';
  static readNotification(id) => 'notification/read/$id';
  static deleteNotification(id) => 'notification/delete/$id';
  static cancelReservation(id) => 'reservation/$id';
  static nextReservations(id) => 'next/reservation/$id';
  static previousReservations(id) => 'past/reservation/$id';
  static const String postFavourite = 'favorite';
  static const String category = 'service';
  static const products = 'subService';
  static categoryProducts(id) => 'service/$id';
  static const String banners = 'banner';
  static productDetails(id) => 'subService/$id';
  static const String setting = 'setting';

  /// maps
  static const String GEOCODE_URI = '/maps/api/geocode/';
  static const String Autocomplete = '/maps/api/place/autocomplete/';
//https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
//'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=n,&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
}
