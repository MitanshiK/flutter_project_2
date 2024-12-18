

///////////////////noope
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShortcutsIntents extends StatefulWidget {
  const ShortcutsIntents({super.key});

  @override
  State<ShortcutsIntents> createState() => _ShortcutsIntentsState();
}

class _ShortcutsIntentsState extends State<ShortcutsIntents> {
@override
Widget build(BuildContext context) {
  int count=0;
  return Scaffold(
    appBar: AppBar(),
    body: CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.arrowUp): () {
          setState(() => count = count + 1);
        },
        const SingleActivator(LogicalKeyboardKey.arrowDown): () {
          setState(() => count = count - 1);
        },
      },
      child: Focus(
        autofocus: true,
        child: Column(
          children: <Widget>[
            const Text('Press the up arrow key to add to the counter'),
            const Text('Press the down arrow key to subtract from the counter'),
            Text('count: $count'),
          ],
        ),
      ),
    ),
  );
}
}