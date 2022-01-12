class Validation {
  bool emailValidation(String text) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(text);
  }

  bool numberValidation(String text) {
    String p = r'^[0-9]{1,}$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(text);
  }

  bool stringValidation(String text) {
    String p = r'^[A-Za-zñÑ ]{1,}$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(text);
  }
}
