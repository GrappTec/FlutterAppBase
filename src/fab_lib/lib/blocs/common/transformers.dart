import 'dart:async';

class Transformers {
  static final empty = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    sink.add(value);
  });

  static final validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email != null && email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError('Por favor informe um e-mail válido');
    }
  });

  static final validatePassword = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    if (password != null) {
      sink.add(password);
    } else {
      sink.addError('Por favor informe uma senha válida');
    }
  });

  static final upper = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      sink.add(data?.toUpperCase());
    },
  );

  static final lower = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      sink.add(data?.toLowerCase());
    },
  );
}
