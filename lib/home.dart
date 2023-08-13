// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gkx/edit.dart';
import 'package:gkx/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool viewgrid = true;
  @override
  Widget build(BuildContext context) {
    var sz = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(onTap: () {}, child: Icon(Icons.menu)),
                      ),
                      Text(
                        'Search your notes',
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Visibility(
                          visible: viewgrid,
                          replacement: InkWell(
                              onTap: () {
                                setState(() {
                                  viewgrid = !viewgrid;
                                });
                              },
                              child: Icon(Icons.grid_view_outlined)),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  viewgrid = !viewgrid;
                                });
                              },
                              child: Icon(Icons.view_agenda_outlined)),
                        ),
                      ),
                      GestureDetector(
                          onTap: () => account(context),
                          child: CircleAvatar(radius: 18)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, value, child) {
                  final lst = box.keys.toList();
                  final lstvl = box.values.toList();
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: viewgrid ? 2 : 1,
                        childAspectRatio:
                            (sz.width * (viewgrid ? 0.5 : 1)) / 50,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    shrinkWrap: true,
                    itemCount: lst.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Edit(dt: lst[index]),
                            ));
                      },
                      onLongPress: () => _dialogBuilder(context, lst[index]),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey,
                            )),
                        child: Center(
                            child: Text(
                          lstvl[index].toString().substring(
                              0,
                              (lstvl[index].toString().length <= 10)
                                  ? lstvl[index].toString().length
                                  : 10),
                          style: GoogleFonts.poppins(fontSize: 15),
                        )),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Edit(),
              ));
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.centerStart,
      persistentFooterButtons: [
        IconButton(onPressed: () {}, icon: Icon(Icons.check_box_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.brush_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.mic_none_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.image_outlined)),
      ],
      drawer: Container(),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, String key) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Options'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Delete'),
              onPressed: () {
                box.delete(key);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Note deleted!')));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> account(BuildContext context) {
    var sz = MediaQuery.of(context).size;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: RichText(
              text: TextSpan(
                  text: 'Using Offline database\n',
                  style: GoogleFonts.montserrat(
                    color: Colors.grey,
                  ),
                  children: [
                TextSpan(
                    text: 'Designed by ',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                    )),
                TextSpan(
                    text: 'Samvabya',
                    style: GoogleFonts.montserrat(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ))
              ])),
        );
      },
    );
  }
}
