import 'package:flutter/material.dart';

class currency_card extends StatelessWidget {
  final String maintext, balance, smalltext;
  final IconData icon;
  final bool isInvarted;
  final Offset offset;

  const currency_card({
    required this.maintext,
    required this.balance,
    required this.smalltext,
    required this.icon,
    required this.isInvarted,
    required this.offset,
  });

  const currency_card.createCard({
    required String maintext,
    required String balance,
    required String smalltext,
    required IconData icon,
    required bool isInvarted,
  })  : maintext = maintext,
        balance = balance,
        smalltext = smalltext,
        icon = icon,
        isInvarted = isInvarted,
        offset = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isInvarted ? Colors.white : const Color(0xFF1F2123),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maintext,
                    style: TextStyle(
                      fontSize: 30,
                      color: isInvarted ? Colors.black : Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        balance,
                        style: TextStyle(
                          fontSize: 20,
                          color: isInvarted ? Colors.black : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        smalltext,
                        style: TextStyle(
                          fontSize: 15,
                          color: isInvarted
                              ? Colors.black.withOpacity(0.8)
                              : Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.scale(
                scale: 2,
                child: Transform.translate(
                  offset: const Offset(
                    -10,
                    15,
                  ),
                  child: Icon(
                    icon,
                    color: isInvarted ? Colors.black : Colors.white,
                    size: 70,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
