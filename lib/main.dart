import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Hello Flutter",
            style: TextStyle(fontSize: 28),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Image.network(
                    "https://bslj.konicaminolta.com/KonicaMinolta/imageWrite.do?image_number=1&dm=1728715455097",
                    width: 300,
                  ),
                ),
                SnackBarPage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  SnackBarPage({super.key});
  final idController = TextEditingController();
  final pwController = TextEditingController();
  String statusmessage = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextField(
            controller: idController,
            decoration: InputDecoration(
              labelText: '이메일',
            ),
          ),
          TextField(
            obscureText: true,
            controller: pwController,
            decoration: InputDecoration(
              labelText: '비밀번호',
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 24),
            child: ElevatedButton(
              onPressed: () {
                if (idController.text == 'nana') {
                  if (pwController.text == '1') {
                    statusmessage = 'login';
                  } else {
                    statusmessage = 'pw error';
                  }
                } else {
                  statusmessage = 'id error';
                }
                final snackBar = SnackBar(
                  content: Text(statusmessage),
                  action: SnackBarAction(
                    label: '닫기',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text("로그인"),
            ),
          ),
        ],
      ),
    );
  }
}
