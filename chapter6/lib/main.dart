import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         body: Center(
//           // 하나의 위젯만 가운데 정렬 가능
//           child: Text('Code Factory'),
//         ),
//       ),
//     ),
//   );
// }

// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: SizedBox(
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//
//             // 여러 위젯을 Column 위젯에 입력 가능
//             children: [
//               Text('Code'),
//               Text('Factory'),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: , //여기에 예제 코드 작성
        ),
      ),
    );
  }
}