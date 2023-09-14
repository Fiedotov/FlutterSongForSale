typedef IntCallback = Function(int);
typedef StringCallback = Function(String);

class ValidateItem {
  final String value;
  final String error;

  ValidateItem(this.value, this.error);
}
