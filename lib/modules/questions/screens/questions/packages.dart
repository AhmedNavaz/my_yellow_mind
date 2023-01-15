import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_yellow_mind/constants/style.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

import '../../../authentication/provider/authProvider.dart';
import '../../../settings/models/subscriptionModel.dart';
import '../../../settings/provider/subscriptionProvider.dart';
import '../../../settings/screens/subscription.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  bool? trial = false;

  Future<SubscriptionModel> getScreenData() async {
    String token =
        Provider.of<AuthProvider>(context, listen: false).localUser.token!;
    return await Provider.of<SubscriptionProvider>(context, listen: false)
        .getData(token);
  }

  void onGooglePayResult(dynamic paymentResult) {
    debugPrint(paymentResult.toString());
  }

  int selectedPackage = -1;
  String? amount;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getScreenData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors.amberAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Get Upto 70% off',
                                    style: customTextStyle(28, FontWeight.w600),
                                  ),
                                ),
                                Image.asset('assets/images/packages.png')
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Get personalized meditation',
                          style: customTextStyle(18, FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Your mental health progress by far',
                          style: customTextStyle(18, FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Your physical activity tracker',
                          style: customTextStyle(18, FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Your therapy sessions to lower your stress levels',
                          style: customTextStyle(18, FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Consumer<SubscriptionProvider>(
                      builder: (context, subscrptionData, child) {
                    return SizedBox(
                      height: 166,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: subscrptionData.packagesDtoList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedPackage = index;
                                  amount = subscrptionData
                                      .packagesDtoList[index].price
                                      .toString();
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.15,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop();
                                                },
                                                icon: const Icon(
                                                    Icons.close)),
                                            Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 30),
                                              child: GooglePayButton(
                                                paymentConfigurationAsset:
                                                JsonAssets.gpayAsset,
                                                paymentItems: [
                                                  PaymentItem(
                                                      label: 'Total',
                                                      amount: amount!,
                                                      status:
                                                      PaymentItemStatus
                                                          .final_price),
                                                ],
                                                onPaymentResult:
                                                onGooglePayResult,
                                                margin:
                                                const EdgeInsets.only(
                                                    top: 15),
                                                width: double.maxFinite,
                                                loadingIndicator:
                                                const Center(
                                                  child:
                                                  CircularProgressIndicator(),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                });
                              },
                              child: Card(
                                elevation: 2,
                                color: selectedPackage == index
                                    ? Colors.amber
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        subscrptionData
                                            .packagesDtoList[index].title!,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: selectedPackage == index
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      SizedBox(
                                        width: 125,
                                        child: Text(
                                          subscrptionData.packagesDtoList[index]
                                              .description!,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: selectedPackage == index
                                                  ? Colors.white
                                                      .withOpacity(0.75)
                                                  : Colors.black
                                                      .withOpacity(0.45)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Text(
                                        '\$${subscrptionData.packagesDtoList[index].price}',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: selectedPackage == index
                                                ? Colors.white
                                                : Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: trial,
                                shape: const CircleBorder(),
                                fillColor:
                                    MaterialStateProperty.all(Colors.amber),
                                onChanged: (value) {
                                  setState(() {
                                    UIBlock.block(context);
                                    String token =
                                    Provider.of<AuthProvider>(context, listen: false).localUser.token!;
                                    Provider.of<SubscriptionProvider>(context, listen: false).activateFreeTrial(token, true, DateTime.now()).then((value) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              '3 day trial activated'),
                                        ),
                                      );
                                      UIBlock.unblock(context);
                                      setState(() {
                                        trial = true;
                                      });
                                    });


                                      }

                                );
                                }),
                            Text(
                              'Start your 3 day trial',
                              style: customTextStyle(18, FontWeight.w600),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
