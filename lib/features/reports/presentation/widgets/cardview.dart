import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:training_flutter_intro/router.dart';

class CardView extends StatelessWidget {
  CardView({
    Key? key,
    required this.name,
    required this.description,
    required this.date,
    required this.server,
    required this.isOk,
    required this.id,
    required this.onDismiss,
  }) : super(key: key);

  final String name;
  final String description;
  final DateTime date;
  final String server;
  final bool isOk;
  final int id;
  final Function onDismiss;

  String get textDate => format.format(date);

  final format = DateFormat('yyyy LLLL dd');

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        onDismiss();
      },
      key: UniqueKey(),
      child: GestureDetector(
        onTap: () {
          AutoRouter.of(context).push(ReportDetailsRoute(id: id));
        },
        child: ExpandableNotifier(
          child: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
                                          data: description,
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
      ),
    );
  }
}
