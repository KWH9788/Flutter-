import 'package:flutter/material.dart';
import 'package:studyingapp/widgets/button.dart';
import 'package:studyingapp/widgets/currency_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                // Menu & User
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Hey, Woohyun",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Welcome back",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Total Balance & Button
                const SizedBox(
                  height: 70,
                ),
                Text(
                  "Total Balance",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 20,
                      fontWeight: FontWeight.w200),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "\$5 194 382",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Button(
                      text: "Transfer",
                      bgcolor: Color(0xFFF1B33B),
                      textcolor: Colors.black,
                    ),
                    Button(
                      text: "Request",
                      bgcolor: Color(0xFF1F2123),
                      textcolor: Colors.white,
                    ),
                  ],
                ),
                // Wallets Card & View All
                const SizedBox(
                  height: 90,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Wallets",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const currency_card.createCard(
                  maintext: "Euro",
                  balance: "6 428",
                  smalltext: "EUR",
                  icon: Icons.euro_sharp,
                  isInvarted: false,
                ),
                const currency_card(
                  maintext: "Dollar",
                  balance: "55 622",
                  smalltext: "USD",
                  icon: Icons.monetization_on_outlined,
                  isInvarted: true,
                  offset: Offset(0, -25),
                ),
                const currency_card(
                  maintext: "Rupee",
                  balance: "28 981",
                  smalltext: "INR",
                  icon: Icons.currency_rupee_sharp,
                  isInvarted: false,
                  offset: Offset(0, -50),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
