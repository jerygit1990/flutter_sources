import 'package:flutter/material.dart';

class CarPickup extends StatefulWidget {
  @override
  _CarPickupState createState() => _CarPickupState();
}

class _CarPickupState extends State<CarPickup> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(height: 137),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                constraints: BoxConstraints.expand(width: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "SEDAN",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Color(0xff323643),
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffF7F7F7)),
                      width: 64,
                      height: 64,
                      child: Center(
                        child: Image.asset("ic_pickup_sedan.png"),
                      ),
                    ),
                    Text(
                      "\$2.28",
                      style: TextStyle(color: Color(0xff606470), fontSize: 12),
                    )
                  ],
                ),
              );
            },
            itemCount: 10,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: RaisedButton(
              child: Text(
                "Confirm Pickup",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {},
              color: Color(0xff3277D8),
            ),
          ),
        )
      ],
    );
  }
}
