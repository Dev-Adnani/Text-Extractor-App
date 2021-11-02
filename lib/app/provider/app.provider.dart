import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:textscanner/core/notifier/homeNotifier/home.notifer.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) => HomeNotifer(),
    )
  ];
}
