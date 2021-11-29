import 'package:calculators/globals.dart';
import 'package:calculators/inputs/is_seller_financed.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinanceOptionConstructionLoan extends StatelessWidget {
  const FinanceOptionConstructionLoan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyInputPage(
        imageUri: 'images/finance-construction.svg',
        headerText: 'Finance Option', subheadText: 'Construction Loan',
        onSubmit: () {
          Get.to(() => const IsSellerFinanced());
        },
        position: kResidentialREIQuestions.indexOf(FinanceOptionConstructionLoan) + 1,
        totalQuestions: kResidentialREIQuestions.length,
        child: const ResponsiveLayout(
          children: [

          ],
        ),
    );
  }
}
