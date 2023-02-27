import 'dart:ui';

import 'package:evento/models/Hotels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'booking_confirmation.dart';

class BookingPage extends StatefulWidget {
  final Hotel? hotel;

  const BookingPage({Key? key, this.hotel}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  var eventType = null;
  String? menuId = "id";
  var dateSelected = null;
  List<DateTime> disabledDates = [DateTime.parse('2023-02-25'), DateTime.parse('2023-02-26'),DateTime.parse('2023-02-02')];

  TextEditingController _date = TextEditingController();


  int totalBill=0;
  var selectedDecoration;
  Menu? selectedMenu;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    var decorations=widget.hotel?.decorations;
    print(decorations);
    // totalBill+=numberOfGuests;
    var numberOfGuests=TextEditingController();

    var menuList =
        widget.hotel?.menus.map((key, value) => MapEntry(key, value));
    List<Menu?>? menu = menuList?.keys.map((e) => menuList[e]).toList();
    List<Map> events = [
      {'id': "wedding", 'name': "Wedding", 'img': "wedding"},
      {'id': "birthday", 'name': "Birthday", 'img': "birthday"},
      {'id': "concert", 'name': "Concert", 'img': "concert"}
    ];

    int calculateTotal(){
    int menuPrice=selectedMenu?.price??0;
    int decorationCharges=selectedDecoration.charges;
      var total=(((int.parse(numberOfGuests.text)) * menuPrice) +
          decorationCharges);
        return total;
    }



    return Scaffold(
      body: Scaffold(
        appBar: AppBar(title: Text("Booking")),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.hotel!.name.toString()),
                    SizedBox(
                      height: Get.size.height * 0.02,
                    ),
                    Text(
                      'Select Event Type',
                      style: TextStyle(
                          fontSize: Get.height * 0.021,
                          fontWeight: FontWeight.bold),
                    ),
                    buildRow(events),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      'Select Menu',
                      style: TextStyle(
                          fontSize: Get.height * 0.021,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: Get.size.height * 0.12,
                      width: Get.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...?menu?.map((e) =>
                              buildMenuCard(e ?? Menu("uid", [], "dumy", 0))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(1),
                    //   child: DropdownButtonFormField(
                    //       hint: Text("Choose Decorations"),
                    //       items: [
                    //         ...?widget.hotel?.decorations?.items.map((e) =>
                    //             DropdownMenuItem(value: e, child: Text("fds")))
                    //       ],
                    //       onChanged: (String? value) {
                    //         print(value);
                    //       }),
                    // ),

                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ElevatedButton(
                            onPressed: () => setState(() => selectedDecoration=decorations?.elementAt(index)),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.black12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                    Text(
                                      decorations?.elementAt(index).name??"",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    Text( decorations?.elementAt(index).charges.toString()??"",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 9),),
                                  ]),
                                  const Spacer(),
                                  Icon(
                                     selectedDecoration== decorations?.elementAt(index)
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color:
                                        // selectedCategory == categories[index]
                                        true
                                            ? const Color.fromARGB(
                                                255, 31, 102, 208)
                                            : const Color.fromARGB(
                                                255, 172, 170, 170),
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: decorations?.length,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text("Select Date",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Container(
                        child: Column(children: [
                      TextField(
                          controller: _date,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.calendar_month_outlined,
                            ),
                            labelText: "Pick Date",
                          ),
                          onTap: () async {

                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                selectableDayPredicate: (day){
                                  return !disabledDates.contains(day);
                                },
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022,01,01),
                                lastDate: DateTime(2023,12,31));
                            if (pickedDate != null) {
                              setState(() {
                                _date.text =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                              });
                            }
                          }),
                      Text(dateSelected != null ? dateSelected.toString() : ""),
                    ])),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Enter Number of person"),

                    Padding(
                      padding: EdgeInsets.all(2),
                      child: SizedBox(
                        width: Get.width*0.8,

                        child: TextField(

                          onSubmitted: (value) {
                          numberOfGuests.text=value;
                          },
                          controller:numberOfGuests,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],

                          decoration: InputDecoration(

                            label: Text("Number of Guests"),
                            border: OutlineInputBorder(),
                            hintText: 'Max Capacity(${widget.hotel?.capacity}) person',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                Colors.red,
                                Colors.deepPurpleAccent
                              ]),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(3)),
                              border: Border.all(width: 1)),
                          padding: const EdgeInsets.all(5),
                          child: Text(
                           "Total",
                            style: TextStyle(
                                fontSize: Get.height * 0.03,
                                fontWeight: FontWeight.w700),
                          ),
                        )),
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(3)),
                                ),
                                child: Text(
                                  totalBill.toString(),
                                  style: TextStyle(
                                      fontSize: Get.height * 0.02,
                                      fontWeight: FontWeight.w600),
                                )))
                      ],
                    ),
                  ),
                  Row(
                    children: [Expanded(
                      child: ElevatedButton(onPressed:(){
                         int menuPrice=selectedMenu?.price??0;
                         int decorationCharges=selectedDecoration.charges;
                         if(int.parse(numberOfGuests.text)>0 && (selectedMenu!=null && menuPrice!=0)) {
                           setState(() {
                             totalBill =
                             (((int.parse(numberOfGuests.text)) * menuPrice) +
                                 decorationCharges);
                           });
                         }


                      }, child: Text("Calculate Total")),
                    ),
                      Expanded(
                        child: OutlinedButton(onPressed: (){
                          setState(() {
                            totalBill=0;
                          });

                        }, child:const Text("Clear All")),
                      )
                    ]),
                  Row(children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              if(int.parse(numberOfGuests.text)>0 && (selectedMenu!=null && selectedMenu?.price!=0)) {
                               var newBooking=Booking(date: _date.text,numberOfPersons: int.parse(numberOfGuests.text),
                                    menu: selectedMenu??Menu("uid",[], "", 0),
                                    decorationType: selectedDecoration.name,hotel: widget.hotel,totalBill: calculateTotal(),eventType: eventType);
                                Get.to(() => BookingConfirmationPage(booking:newBooking));

                                //create Get Popup to show booking details
                              }
                              else{
                                Get.snackbar("Error", "Please select menu and number of guests");
                              }


                            }, child: const Text('Proceed')))
                  ]),
                ],
              ),
            )
          ]),
        ),
      ),
      // body: Container(
      //   padding: EdgeInsets.only(top: Get.height* 0.08),
      //   child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //     mainAxisSize: MainAxisSize.max,
      //     children: [
      //       Text("Event Booking",),
      //       Text("please choose event slot"),
      //
      //      ListView(children: [BookingCalendarWidget()],),
      //     ],
      //   ),
      // ),
    );
  }


  Widget buildRow(List<Map> items) {
    var item;
    return Container(
      height: Get.size.height * 0.13,
      width: Get.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [...items.map((e) => buildCard(e))],
      ),
    );
  }

  Widget buildCard(Map item) {
    return InkWell(
      hoverColor: Colors.black38,
      focusColor: Colors.amberAccent,
      highlightColor: Colors.black38,
      customBorder: RoundedRectangleBorder(side: BorderSide(width: 2)),
      onTap: () {
        setState(() {
          eventType = item['id'];
        });
      },
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 3,
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/${item['img']}.jpg"),
              fit: BoxFit.fill,
            )),
            // color: (eventType == item['name']) ? Colors.grey : Colors.amberAccent[200],
            alignment: Alignment.center,
            height: Get.size.height * 0.2,
            width: Get.size.height * 0.2,
            child: Text(
              item['name'],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Get.size.height * 0.03,
                  color: item['id'] == (eventType ?? "")
                      ? Colors.white
                      : Colors.black87),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuCard(Menu menu) {
    return InkWell(
      highlightColor: Colors.black38,
      customBorder: RoundedRectangleBorder(side: BorderSide(width: 2)),
      onTap: () {},
      onLongPress: () {
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              shape: RoundedRectangleBorder(),
              contentPadding: EdgeInsets.all(0),
              backgroundColor: Colors.black38,
              title: Text(
                menu.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Get.height * 0.04,
                    color: Colors.white),
              ),
              content: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: Get.height * 0.12),
                decoration: BoxDecoration(
                    // color: (menuId==menu.uid)?Colors.grey:Colors.deepPurpleAccent,
                    image: DecorationImage(
                        opacity: 0.9,
                        fit: BoxFit.fill,
                        image: AssetImage('assets/menu_background.jpg'))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [...menu.items.map((e) => Text(e.toString())),Spacer(),Text("Price:${menu.price.toString()}")],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    alignment: Alignment.center,
                  ),
                  child: Text("Select Menu"),
                  onPressed: () {
                    setState(() {
                      selectedMenu = menu;
                    });
                    Navigator.of(dialogContext).pop();
                    // Dismiss alert dialog
                  },
                ),
              ],
            );
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 3,
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/menu_background.jpg'))),
            alignment: Alignment.center,
            height: Get.size.height * 0.3,
            width: Get.size.height * 0.2,
            child: Text(
              "${selectedMenu == menu ? ">" : ""} ${menu.name}",
              style: TextStyle(
                fontWeight:
                    (selectedMenu == menu) ? FontWeight.bold : FontWeight.w500,
                fontSize: Get.size.height * 0.021,
                color: (selectedMenu == menu) ? Colors.black87 : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }


}

