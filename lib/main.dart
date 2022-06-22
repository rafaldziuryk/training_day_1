import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import 'features/reports/presentation/blocs/reports_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return BlocProvider(
      create: (context) => ReportsBloc()..add(ReportsInit()),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: BlocBuilder<ReportsBloc, ReportsState>(
              builder: (context, state) {
                if (state is ReportsInitial) {
                  return Text('Loading');
                } else if (state is ReportsData) {
                  return Text('Reports: ${state.reports.length}');
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            backgroundColor: Colors.lime,
          ),
          body: BlocBuilder<ReportsBloc, ReportsState>(
            builder: (context, state) {
              if (state is ReportsInitial) {
                return Text('Brak danych');
              } else if (state is ReportsData) {
                final list = state.reports;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final data = list[index];
                    return CardView(
                      key: ValueKey(data),
                      name: data.title,
                      description: data.description,
                      date: data.date,
                      server: data.server,
                      isOk: data.isOk,
                      onDismiss: () {
                        context.read<ReportsBloc>().add(ReportsRemove(index: index));
                      },
                    );
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
// key: ValueKey(index),

class CardView extends StatelessWidget {
  CardView({
    required this.key,
    required this.name,
    required this.description,
    required this.date,
    required this.server,
    required this.isOk,
    required this.onDismiss,
  }) : super(key: key);

  final Key key;
  final String name;
  final String description;
  final DateTime date;
  final String server;
  final bool isOk;
  final Function onDismiss;

  String get textDate => format.format(date);

  final format = DateFormat('yyyy LLLL dd');

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Dismissible(
            onDismissed: (direction) {
              onDismiss();
            },
            key: key,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          highlightColor: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {},
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.brown),
                              // color: Colors.red,
                            ),
                            child: Icon(Icons.download_done),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                          height: 16,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(name),
                              const SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: () => ExpandableController.of(context)?.toggle(),
                                child: Expandable(
                                  collapsed: SizedBox(
                                      height: 48,
                                      child: Html(
                                        data: '$description$description$description',
                                      )),
                                  expanded: Html(data: '$description$description$description'),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('asdasd');
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Clicked')));
                              },
                              child: Container(
                                width: 12,
                                height: 12,
                                color: isOk ? Colors.lime : Colors.red,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              server,
                              style: TextStyle(
                                color: Colors.lime,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(textDate)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
