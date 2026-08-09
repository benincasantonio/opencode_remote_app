import 'package:flutter/material.dart';

import 'raw_string_stubs.dart';

/// Negative cases: must NOT trigger avoid_raw_string_in_widgets.
class RawStringOkFixtures extends StatelessWidget {
  const RawStringOkFixtures({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${'localhost'}:8080'),
        const Text(''),
        const Text('·'),
        Text(context.l10n.retry),
        Builder(
          builder: (_) {
            const unused = 'not in a widget ctor';
            return Text(unused);
          },
        ),
      ],
    );
  }
}
