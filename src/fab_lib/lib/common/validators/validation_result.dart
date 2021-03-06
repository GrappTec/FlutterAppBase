import 'package:app_base/events/delegates.dart';
import 'package:vmais/common/rx/app_property.dart';

import 'model_validators.dart';

class ValidationResult {
  var _errors = List<String>();

  void add(String error) {
    _errors.add(error);
  }

  bool get success => _errors.length == 0;

  ValidationResult check<T>(
    Property<T> property, {
    Func1<T, String> what,
  }) {
    ModelValidators.check<T>(
      property,
      what,
      validationResult: this,
    );

    return this;
  }

  ValidationResult checkIf<T>(
    Property<T> property,
    Func<bool> predicate, {
    Func1<T, String> what,
  }) {
    if (!predicate()) {
      return this;
    }

    ModelValidators.check<T>(
      property,
      what,
      validationResult: this,
    );

    return this;
  }

  bool fail() => !success;

  @override
  String toString() => _errors.join(",\n");
}

extension ValidationResultExtensions on ValidationResult {
  ValidationResult check<T>(
    Property<T> property,
    Func1<T, String> funCheck,
  ) {
    ModelValidators.check<T>(
      property,
      funCheck,
      validationResult: this,
    );

    return this;
  }
}
