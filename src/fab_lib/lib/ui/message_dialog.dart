part of fab_lib;

enum EToast { LENGTH_SHORT, LENGTH_LONG }

class MessageDialog {
  static Future<void> alert(BuildContext context, String message, {String title = 'Atenção', List details}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: _createMessageContent(context, message, details),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool> question(BuildContext context, String message, {String title = 'Dúvida?', List details}) async {
    bool result = false;

    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: _createMessageContent(context, message, details),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Continuar'),
              onPressed: () {
                result = true;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    return result;
  }

  static Future<void> toast(String message, {EToast length = EToast.LENGTH_LONG}) async {
    await ft.Fluttertoast.showToast(
        msg: message, toastLength: ft.Toast.values[EToast.values.indexOf(length)], backgroundColor: Colors.red, textColor: Colors.white);
  }

  static _createMessageContent(BuildContext context, String message, List details) {
    final List<Widget> widgets = [];

    widgets.add(Text(
      message,
      style: Theme.of(context).textTheme.subtitle2,
    ));

    details?.forEach((msg) {
      widgets.add(Text(
        msg,
        style: Theme.of(context).textTheme.subtitle2,
      ));
    });

    return widgets;
  }
}
