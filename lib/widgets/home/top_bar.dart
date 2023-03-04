import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';


Row buildTopBar(Color defaultColor, Size size, Function(String) setlocation) {
  setLoc(String location) {
    setlocation(location);
  };
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Searching hotel in",
            style: GoogleFonts.poppins(
              color: defaultColor.withOpacity(0.4),
              fontSize: size.height * 0.017,
            ),
          ),
          Row(
            children: [
              Icon(
                UniconsLine.location_pin_alt,
                color: Colors.indigo,
                size: size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.015,
                ),
                child: Dropdown(setlocation: setLoc,)
                )],
              ),
            ],
          ),

      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: defaultColor.withOpacity(0.25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            UniconsLine.search,
            color: Colors.indigo,
            size: size.height * 0.03,
          ),
        ),
      ),
    ],
  );
}

class Dropdown extends StatefulWidget {
  final Function(String) setlocation;
   Dropdown({Key? key,required this.setlocation}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
    String? dropdownvalue="Islamabad";
  @override
  Widget build(BuildContext context) {
    return
      DropdownButton(
        value: dropdownvalue,
        enableFeedback: true,
        hint: Text("Choose Location"),
        items:
        ["Islamabad","Rawalpindi"].map((e) =>
            DropdownMenuItem<String>(alignment:Alignment.center ,
                onTap: (){},
                value: e, child: Text(
                  e,
                  style: GoogleFonts.lato(

                    fontWeight: FontWeight.bold,
                  ),)
            )).toList(),
        onChanged: (String? value) {
              dropdownvalue=value;
              widget.setlocation(value!);
              print(value);
        },
      );
  }
}

