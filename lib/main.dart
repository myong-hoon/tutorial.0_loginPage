import 'package:flutter/material.dart';
import 'package:cell_calendar/cell_calendar.dart';
import 'sample_event.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final idcontroller = TextEditingController();
  final pwcontroller = TextEditingController();

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
          body: Builder(
            builder: (context) => SingleChildScrollView(
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
                    TextField(
                      controller: idcontroller,
                      decoration: InputDecoration(
                        labelText: 'Id',
                      ),
                    ),
                    TextField(
                      controller: pwcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Pw',
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 24),
                      child: ElevatedButton(
                        onPressed: () {
                          if (idcontroller.text == 'nana') {
                            if (pwcontroller.text == '1') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Login Success"),
                                  duration: Duration(seconds: 1),
                                  action: SnackBarAction(
                                    label: "Undo",
                                    onPressed: () {},
                                  ),
                                ),
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const MyWidget(
                                        title: 'cell_calendar example');
                                  },
                                ),
                                (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Login Failed, The pw was wrong"),
                                  duration: Duration(seconds: 1),
                                  action: SnackBarAction(
                                    label: "Undo",
                                    onPressed: () {},
                                  ),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Login Failed, The id was wrong"),
                                duration: Duration(seconds: 1),
                                action: SnackBarAction(
                                  label: "Undo",
                                  onPressed: () {},
                                ),
                              ),
                            );
                          }
                        },
                        child: Text("Login"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Hello Flutter",
            style: TextStyle(fontSize: 28),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MyApp();
                    },
                  ),
                  (route) => false,
                );
              },
            ),
          ]),
    ));
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _conter = false;
  @override
  Widget build(BuildContext context) {
    final events = sampleEvents();
    final cellCalendarPageController = CellCalendarPageController();
    return Scaffold(
      body: CellCalendar(
        cellCalendarPageController: cellCalendarPageController,
        events: events,
        daysOfTheWeekBuilder: (dayIndex) {
          final labels = ["S", "M", "T", "W", "T", "F", "S"];

          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              labels[dayIndex],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
        monthYearLabelBuilder: (datetime) {
          final year = datetime!.year.toString();
          final month = datetime.month;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  "$year년 $month월",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Checkbox(
                    value: _conter,
                    onChanged: (value) {
                      setState(() {
                        _conter = !_conter;
                      });
                    }),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    cellCalendarPageController.animateToDate(
                      DateTime.now(),
                      curve: Curves.linear,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                ),
              ],
            ),
          );
        },
        onCellTapped: (date) {
          final eventsOnTheDate = events.where((event) {
            final eventDate = event.eventDate;
            return eventDate.year == date.year &&
                eventDate.month == date.month &&
                eventDate.day == date.day;
          }).toList();
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                  title: Text("${date.year}년 ${date.month}월 ${date.day}일"),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: eventsOnTheDate
                          .map(
                            (event) => Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(4),
                              margin: const EdgeInsets.only(bottom: 12),
                              color: event.eventBackgroundColor,
                              child: Text(
                                event.eventName,
                                style: event.eventTextStyle,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )));
        },
        onPageChanged: (firstDate, lastDate) {
          /// Called when the page was changed
          /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
        },
      ),
    );
  }
}
