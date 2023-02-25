import 'package:flutter/material.dart';

class OwnMessageWidget extends StatelessWidget {
  const OwnMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return 
     
     Align(
      alignment: Alignment.bottomRight,
       child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-45),
         child: Card(
          
         color: Colors.green,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                children: [
                  Align(
                    alignment:Alignment.topRight,
                    child: Text("name")),
                  Text("data"),
                ],
              )),
           
           ),
       ),
     );
  }
}