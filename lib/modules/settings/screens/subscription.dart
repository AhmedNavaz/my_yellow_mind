import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_yellow_mind/modules/settings/models/subscriptionModel.dart';
import 'package:my_yellow_mind/modules/settings/provider/subscriptionProvider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../constants/style.dart';
import '../../authentication/provider/authProvider.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  Future<SubscriptionModel> getScreenData() async {
    String token =
        Provider.of<AuthProvider>(context, listen: false).localUser.token!;
    await Provider.of<SubscriptionProvider>(context, listen: false)
        .getActivePlan(token);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Subscription',
          style: customTextStyle(16, FontWeight.w500),
        ),
      ),
      body: FutureBuilder(
          future: getScreenData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Plans',
                      style: customTextStyle(17, FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                                      height: MediaQuery.of(context).size.height * 0.15,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: const Icon(Icons.close)),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: GooglePayButton(
                                              paymentConfigurationAsset:
                                              JsonAssets.gpayAsset,
                                              paymentItems: [
                                                PaymentItem(
                                                    label: 'Total',
                                                    amount: amount!,
                                                    status:
                                                    PaymentItemStatus.final_price),
                                              ],
                                              onPaymentResult: onGooglePayResult,
                                              margin: const EdgeInsets.only(top: 15),
                                              width: double.maxFinite,
                                              loadingIndicator: const Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
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
                              color: selectedPackage == index
                                  ? const Color(0xffE3ACAC)
                                  : Colors.white,
                              elevation: 2,
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
                                                ? Colors.white.withOpacity(0.75)
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
                const SizedBox(height: 30),
                Text(
                  'Try 3 days free trial',
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.45)),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    if(Provider.of<SubscriptionProvider>(context, listen: false).freeTrial){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'You\'ve already redeemed your free trial!'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Provider.of<SubscriptionProvider>(context, listen: true).freeTrial ? Colors.grey :const Color(0xffE3ACAC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(
                      'Get Started',
                      style: customTextStyle(15, FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Active Plan',
                      style: customTextStyle(17, FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Consumer<SubscriptionProvider>(
                    builder: (context, subscriptionProvider, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  subscriptionProvider.activePackages[0].name
                                      .toString()
                                      .toUpperCase(),
                                  style: customTextStyle(13, FontWeight.w500,
                                      color: Colors.black.withOpacity(0.66)),
                                ),
                                Text(
                                  'Expires on ${DateFormat('dd/MM/yyyy').format(DateTime.parse(subscriptionProvider.activePackages[0].endDate!))}',
                                  style: customTextStyle(11, FontWeight.w500,
                                      color: const Color(0xff8B8B8B)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '\$${subscriptionProvider.activePackages[0].amount}/month',
                                    style: customTextStyle(14, FontWeight.w500,
                                        color: Colors.black)),
                                const Icon(
                                  Icons.radio_button_checked,
                                  color: Colors.black,
                                )
                              ],
                            ),
                            const SizedBox(height: 30),
                            Text(
                              'Subscription will automatically renew and your credit card will be charged at the end of the period',
                              style: customTextStyle(12, FontWeight.w500,
                                  color: Colors.black.withOpacity(0.45)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                Divider(
                  height: 100,
                  thickness: 1.5,
                  color: const Color(0xff707070).withOpacity(0.16),
                  indent: 100,
                  endIndent: 100,
                ),
              ],
            );
          }),
    );
  }
}

class JsonAssets {
  JsonAssets._();

  static const String gpayAsset =
      'json/default_payment_profile_google_pay.json';
}
