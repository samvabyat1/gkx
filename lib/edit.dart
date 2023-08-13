import 'package:flutter/material.dart';
import 'package:gkx/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Edit extends StatefulWidget {
  String dt;
  Edit({super.key, this.dt = ''});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  String dtnew = DateFormat('yyyyMMddHHmm').format(DateTime.now());
  var tt = TextEditingController();
  var sdt = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.dt != '') {
      setState(() {
        tt.text = box.get(widget.dt);
        sdt =
            '${DateFormat('MMM').format(DateTime(0, int.parse(widget.dt.substring(4, 6))))} ${widget.dt.substring(6, 8)} ${widget.dt.substring(8, 10)}:${widget.dt.substring(10, 12)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.push_pin_outlined),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.archive_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: TextField(
          controller: tt,
          onChanged: (value) {
            if (value != '') {
              box.put((widget.dt == '') ? dtnew : widget.dt, value);
            }
          },
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: GoogleFonts.poppins(color: Theme.of(context).iconTheme.color),
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: 'Note',
            hintStyle:
                GoogleFonts.poppins(color: Theme.of(context).iconTheme.color),
          ),
        ),
      ),
      persistentFooterButtons: [
        Text(
          sdt,
          style: GoogleFonts.poppins(color: Theme.of(context).iconTheme.color),
        )
      ],
    );
  }
}
