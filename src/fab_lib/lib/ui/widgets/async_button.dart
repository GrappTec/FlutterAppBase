part of fab_lib;

enum EButtonState { Normal, Running, Success, Fail }

class AsyncButton<TData> extends StatefulWidget {
  final ActionCancelEventHandler<TData> onExecute;
  final Act1<TData> onSuccess;
  final Act1<TData> onFail;
  final Widget child;
  final Color color;
  final Color textColor;

  AsyncButton({Key key, @required this.onExecute, this.onSuccess, this.onFail, this.child, this.color, this.textColor}) : super(key: key);

  @override
  _AsyncButtonState<TData> createState() => _AsyncButtonState<TData>();
}

class _AsyncButtonState<TData> extends State<AsyncButton> {
  EButtonState _state = EButtonState.Normal;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
        child: setUpButtonChild(),
        color: widget.color,
        textColor: widget.textColor,
        padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () async {
          if (_state == EButtonState.Running) {
            return;
          }

          setState(() {
            _state = EButtonState.Running;
          });

          final args = ActionCancelEventsArgs<TData>();
          await widget.onExecute(this, args);

          setState(() {
            _state = args.cancel ? EButtonState.Fail : EButtonState.Success;
          });

          await Future.delayed(Duration(milliseconds: 850));

          if (args.cancel) {
            widget.onFail?.call(args.data);
          } else {
            widget.onSuccess?.call(args.data);
          }
        });
  }

  Widget setUpButtonChild() {
    if (_state == EButtonState.Normal) {
      return Row(
        children: <Widget>[
          SizedBox(
            width: 14,
            height: 20,
          ),
          widget.child,
          SizedBox(
            width: 14,
          ),
        ],
      );
    } else if (_state == EButtonState.Running) {
      return Row(
        children: <Widget>[
          Container(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            width: 20,
            height: 20,
          ),
          SizedBox(
            width: 8,
          ),
          widget.child
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Container(
            child: Icon(_state == EButtonState.Success ? Icons.check : Icons.error, color: widget.textColor),
            width: 20,
            height: 20,
          ),
          SizedBox(
            width: 8,
          ),
          widget.child
        ],
      );
    }
  }
}
