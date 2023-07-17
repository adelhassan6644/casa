import '../../../navigation/custom_navigation.dart';
import '../../localization/localization/language_constant.dart';

class Validations {
  static String? name(String? value) {
    if (value!.isEmpty) {
      return getTranslated("please_enter_your_name",
          CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }

  static String? mail(String? email) {
    if (email!.length < 8 || !email.contains("@") || !email.contains(".com")) {
      return getTranslated("please_enter_valid_email",
          CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }

  static String? password(String? password) {
    if (password!.length < 8) {
      return getTranslated("please_enter_valid_password",
          CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }

  static String? firstPassword(String? password) {
    if (password == null || password.isEmpty) {
      return getTranslated("please_enter_valid_password",
          CustomNavigator.navigatorState.currentContext!);
    } else if (password.length < 8) {
      return getTranslated("password_length_validation",
          CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }

  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return getTranslated("please_enter_valid_confirm_password",
          CustomNavigator.navigatorState.currentContext!);
    } else if (confirmPassword.length < 8) {
      return getTranslated("password_length_validation",
          CustomNavigator.navigatorState.currentContext!);
    } else if (password != null) {
      if (password != confirmPassword) {
        return getTranslated("confirm_password_match_validation",
            CustomNavigator.navigatorState.currentContext!);
      }
    }
    return null;
  }

  static String? newPassword(String? currentPassword, String? newPassword) {
    if (newPassword == null || newPassword.isEmpty) {
      return getTranslated("please_enter_valid_new_password",
          CustomNavigator.navigatorState.currentContext!);
    } else if (newPassword.length < 8) {
      return getTranslated("password_length_validation",
          CustomNavigator.navigatorState.currentContext!);
    } else if (currentPassword != null) {
      if (currentPassword == newPassword) {
        return getTranslated("new_password_match_validation",
            CustomNavigator.navigatorState.currentContext!);
      }
    }
    return null;
  }

  static String? confirmNewPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return getTranslated("please_enter_valid_confirm_password",
          CustomNavigator.navigatorState.currentContext!);
    } else if (confirmPassword.length < 8) {
      return getTranslated("password_length_validation",
          CustomNavigator.navigatorState.currentContext!);
    } else if (password != null) {
      if (password != confirmPassword) {
        return getTranslated("confirm_new_password_match_validation",
            CustomNavigator.navigatorState.currentContext!);
      }
    }
    return null;
  }

  static String? phone(String? value) {
    if (value!.isEmpty || value.length < 7) {
      return getTranslated("please_enter_valid_number",
          CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }

  static String? code(String? value) {
    if (value!.isEmpty || value.length < 4) {
      return getTranslated("please_enter_valid_code",
          CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }

  static String? city(Object? value) {
    if (value!.toString().isEmpty) {
      return getTranslated(
          "please_choose_city", CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }
}
