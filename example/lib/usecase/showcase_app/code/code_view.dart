// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_highlight/flutter_highlight.dart';
// import 'package:flutter_highlight/themes/github.dart';

// class CodeView extends StatelessWidget {
//   const CodeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const FlatButton(
//       onPressed: () async {
//         String sourceCode =
//             await rootBundle.loadString('path/to/your/file.dart');
//         showDialog(
//           context: context,
//           builder: (BuildContext context) => AlertDialog(
//             content: SingleChildScrollView(
//               child: Container(
//                 child: HighlightView(
//                   sourceCode,
//                   language: 'dart',
//                   theme: githubTheme,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       child: Text('Show source code'),
//     );
//   }
// }
