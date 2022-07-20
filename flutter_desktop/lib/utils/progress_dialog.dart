import 'package:flutter/material.dart';

bool _isShowing = false;
BuildContext? _context, _dismissingContext;
bool _barrierDismissible = true, _showLogs = false;


class ProgressDialog{
  ProgressDialog(
    BuildContext context,
    {bool? isDismissible,
        bool? showLogs,
        TextDirection? textDirection,
        Widget? customBody}) {
    _context = context;
    _barrierDismissible = isDismissible ?? true;
    _showLogs = showLogs ?? false;
  }

  Future<bool> show() async {
    try {
      if (!_isShowing) {
        //_dialog = _Body();
        showDialog<dynamic>(
          context: _context!,
          barrierDismissible: _barrierDismissible,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            _dismissingContext = context;
            return WillPopScope(
              onWillPop: () async => _barrierDismissible,
              child: const Center(
                child: SizedBox(
                  height: 30, width: 30, 
                  child: CircularProgressIndicator(strokeWidth: 3.0)
                )
              )
            );
          },
        );
        // Delaying the function for 200 milliseconds
        // [Default transitionDuration of DialogRoute]
        await Future.delayed(const Duration(milliseconds: 200));
        if (_showLogs) debugPrint('ProgressDialog shown');
        _isShowing = true;
        return true;
      } else {
        if (_showLogs) debugPrint("ProgressDialog already shown/showing");
        return false;
      }
    } catch (err) {
      _isShowing = false;
      debugPrint('Exception while showing the dialog');
      debugPrint(err.toString());
      return false;
    }
  }


  Future<bool> hide() async {
    try {
      if (_isShowing) {
        _isShowing = false;
        Navigator.of(_dismissingContext!).pop();
        if (_showLogs) debugPrint('ProgressDialog dismissed');
        return Future.value(true);
      } else {
        if (_showLogs) debugPrint('ProgressDialog already dismissed');
        return Future.value(false);
      }
    } catch (err) {
      debugPrint('Seems there is an issue hiding dialog');
      debugPrint(err.toString());
      return Future.value(false);
    }
  }
}
