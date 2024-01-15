import 'package:drivers_app/methods/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class PaymentDialog extends StatefulWidget {
  String fareAmount;

  PaymentDialog({
    super.key,
    required this.fareAmount,
  });

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  CommonMethods cMethods = CommonMethods();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        width: double.infinity,
        // decoration: BoxDecoration(
        //     color: Colors.black87,
        //     borderRadius: BorderRadius.circular(6),
        // ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 21,
            ),
            const Text(
              "COLLECT CASH",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            const Divider(
              height: 1.5,
              color: Colors.grey,
              thickness: 1.0,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "\৳" + widget.fareAmount,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "This is the fare amount ( \$ ${widget.fareAmount} ) to be charged from the user.",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);

                cMethods.turnOnLocationUpdatesForHomePage();

                Restart.restartApp();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, fixedSize: Size(180, 50)),
              child: const Text(
                "COLLECT CASH",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 41,
            )
          ],
        ),
      ),
    );
  }
}
