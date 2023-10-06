import 'package:flutter/material.dart';
import 'package:opentrend/config/constant/font_constant.dart';

import '../../../../config/constant/color_constant.dart';

typedef StringCallback = void Function(String val);

class MoneyDonateCard extends StatefulWidget {
  final StringCallback callbackAmount;
  const MoneyDonateCard({
    Key? key,
    required this.callbackAmount,
  }) : super(key: key);

  @override
  State<MoneyDonateCard> createState() => _MoneyDonateCardState();
}

class _MoneyDonateCardState extends State<MoneyDonateCard> {
  int _value = 0;
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kCardColor,
      shadowColor: const Color.fromARGB(20, 0, 0, 0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildDonationAmountList(0, "\$5"),
                buildDonationAmountList(1, "\$20"),
                buildDonationAmountList(2, "\$50"),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildDonationAmountList(3, "\$100"),
                buildDonationAmountList(4, "\$200"),
                buildDonationAmountList(5, "\$500"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.76,
                child: TextFormField(
                  style: const TextStyle(color: kWhiteColor),
                  validator: (val) {
                    // if (int.parse(val!) > (raisedQty - donateQty)) {
                    //   return 'Please Enter money under ${widget.raisingItemQty - widget.donateItemQty}';
                    // }
                    return null;
                  },
                  onChanged: (val) {
                    widget.callbackAmount(val);
                    if (val == "") {
                      setState(() {
                        _value = 0;
                      });
                    } else if (int.parse(val) == 5) {
                      setState(() {
                        _value = 0;
                      });
                    } else if (int.parse(val) == 20) {
                      setState(() {
                        _value = 1;
                      });
                    } else if (int.parse(val) == 50) {
                      setState(() {
                        _value = 2;
                      });
                    } else if (int.parse(val) == 100) {
                      setState(() {
                        _value = 3;
                      });
                    } else if (int.parse(val) == 200) {
                      setState(() {
                        _value = 4;
                      });
                    } else if (int.parse(val) == 500) {
                      setState(() {
                        _value = 5;
                      });
                    } else {
                      setState(() {
                        _value = 6;
                      });
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 5),
                    hintText: "Enter Manual Amount",
                    hintStyle: TextStyle(
                      fontFamily: kFuturaPTBook,
                      fontWeight: FontWeight.w400,
                      color: kWhiteColor,
                      fontSize: 14,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: kButtonSecondaryColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kButtonSecondaryColor)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kButtonSecondaryColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDonationAmountList(
    int value,
    String amount,
  ) {
    // raisedQty = widget.raisingItemQty;
    // donateQty = widget.donateItemQty;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          _value = value;
          widget.callbackAmount(_value == 0
              ? "5"
              : _value == 1
                  ? "20"
                  : _value == 2
                      ? "50"
                      : _value == 3
                          ? "100"
                          : _value == 4
                              ? "200"
                              : "500");
        });
      },
      child: Container(
        width: 85,
        height: 85,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: _value == value ? kButtonColor : kButtonSecondaryColor),
          color: _value == value ? kButtonColor : kCardColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            amount,
            style: const TextStyle(
                fontFamily: kFuturaPTBook, fontSize: 18, color: kWhiteColor),
          ),
        ),
      ),
    );
  }
}
