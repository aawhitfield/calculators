import 'package:calculators/globals.dart';
import 'package:calculators/inputs/fix_and_flip_selling_costs_input.dart';
import 'package:calculators/inputs/want_to_refinance.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/seller_financing_type.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/percent_text_field.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FinanceOptionDownPayment extends ConsumerStatefulWidget {
  const FinanceOptionDownPayment({Key? key}) : super(key: key);

  @override
  _FinanceOptionDownPaymentState createState() => _FinanceOptionDownPaymentState();
}

class _FinanceOptionDownPaymentState extends ConsumerState<FinanceOptionDownPayment> {

  TextEditingController loanPercentController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  void initState() {
    double loanPercent = ref.read(sellerFinanceProvider).loanPercentage * 100;
    if(loanPercent != 0) {
      loanPercentController.text = kWholeNumber.format(loanPercent);
    }
    double interestRate = ref.read(sellerFinanceProvider).interestRate * 100;
    if(interestRate != 0) {
      interestRateController.text = interestRate.toString();
    }
    int term = ref.read(sellerFinanceProvider).term;
    if(term != 0) {
      termController.text = kWholeNumber.format(term);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SellerFinancingType value = ref.watch(sellerFinanceProvider).financingType;

    double loanAmount = ref.watch(brrrrProvider).purchasePrice *
        ref.watch(sellerFinanceProvider).loanPercentage;

    double monthlyPayment = (ref.watch(sellerFinanceProvider).financingType ==
            SellerFinancingType.payment)
        ? ref.watch(sellerFinanceProvider).calculateMonthlyPayment(
              rate: ref.watch(sellerFinanceProvider).interestRate / 12,
              nper: ref.watch(sellerFinanceProvider).term * 12,
              pv: -1 * loanAmount,
            )
        : ref.watch(sellerFinanceProvider).calculateMonthlyPaymentInterestOnly(
              rate: ref.watch(sellerFinanceProvider).interestRate / 12,
              nper: ref.watch(sellerFinanceProvider).term,
              pv: -1 * loanAmount,
              per: 1,
            );

    String loanAmountString = kCurrencyFormat.format(loanAmount);
    String monthlyPaymentString = kCurrencyFormat.format(monthlyPayment);

    return MyInputPage(
        imageUri: 'images/transfer.svg',
        headerText: 'Finance Option',
        subheadText: 'Down Payment',
        onSubmit: () {
          ref.read(sellerFinanceProvider).updateMonthlyPayment(monthlyPayment);
          ref.read(sellerFinanceProvider).updateLoanAmount(loanAmount);
          Calculator calculatorType = ref.read(calculatorProvider).type;
          if (calculatorType == Calculator.brrrr) {
            Get.to(() => const WantToRefinance());
          }
          else {
            double realtorsFees = ref.watch(brrrrProvider).afterRepairValue *
                ref.watch(ffSellingCostsProvider).realtorFeesPercentage;
            ref.read(ffSellingCostsProvider).updateRealtorFees(realtorsFees);

            int numberOfMonthsToRehabRent =
                ref.read(brrrrProvider).monthsToRehabRent;
            double taxes = ref.watch(expensesProvider).taxes;
            if (numberOfMonthsToRehabRent != 0) {
              taxes = taxes / numberOfMonthsToRehabRent;
            }
            ref.read(ffSellingCostsProvider).updateTaxes(taxes);
            double other = ref.watch(brrrrProvider).afterRepairValue * 0.02;
            ref.read(ffSellingCostsProvider).updateOtherClosingCosts(other);
            ref.read(ffSellingCostsProvider).calculateTotal();
            Get.to(() => const FixAndFlipSellingCostsInput());
          }
        },
        position:
            kResidentialREIQuestions.indexOf(FinanceOptionDownPayment) + 1,
        totalQuestions: kResidentialREIQuestions.length,
        child: ResponsiveLayout(
          children: [
            ((MediaQuery.of(context).size.width > 640))
                ? Row(
                    children: [
                      const Text('Financing Type'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SellerDropdown(value: value, ref: ref),
                      )
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Financing Type'),
                      const SizedBox(height: 8),
                      SellerDropdown(value: value, ref: ref)
                    ],
                  ),
            PercentTextField(
              labelText: 'Loan Percent',
              controller: loanPercentController,
              onChanged: (String newPercentage) {
                newPercentage = newPercentage.replaceAll(',', '');
                double? newValue = double.tryParse(newPercentage);
                if (newValue != null) {
                  double loanPercentage = newValue / 100;
                  ref
                      .read(sellerFinanceProvider)
                      .updateLoanPercentage(loanPercentage);
                }
              },
            ),
            MoneyListTile(
                (MediaQuery.of(context).size.width < 640)
                    ? 'Loan\nAmount'
                    : 'Loan Amount',
                loanAmountString),
            PercentTextField(
              labelText: 'Interest Rate',
              controller: interestRateController,
              onChanged: (String newPercentage) {
                newPercentage = newPercentage.replaceAll(',', '');
                double? newValue = double.tryParse(newPercentage);
                if (newValue != null) {
                  double interestRate = newValue / 100;
                  ref
                      .read(sellerFinanceProvider)
                      .updateInterestRate(interestRate);
                }
              },
            ),
            IntegerTextField(
              labelText: 'Term',
              controller: termController,
              leftPadding: 8,
              rightPadding: 8,
              onChanged: (String newTerm) {
                newTerm = newTerm.replaceAll(',', '');
                int? newValue = int.tryParse(newTerm);
                if (newValue != null) {
                  ref.read(sellerFinanceProvider).updateTerm(newValue);
                }
              },
            ),
            MoneyListTile(
                (MediaQuery.of(context).size.width < 640)
                    ? 'Monthly\nPayment'
                    : 'Monthly Payment',
                monthlyPaymentString),
          ],
        ));
  }
}

class SellerDropdown extends StatelessWidget {
  const SellerDropdown({
    Key? key,
    required this.value,
    required this.ref,
  }) : super(key: key);

  final SellerFinancingType value;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<SellerFinancingType>(
      value: value,
      items: SellerFinancingType.values
          .map((SellerFinancingType sellerFinancingType) =>
              DropdownMenuItem<SellerFinancingType>(
                  value: sellerFinancingType,
                  child:
                      Text(SellerFinancingTypeUtils(sellerFinancingType).name)))
          .toList(),
      onChanged: (SellerFinancingType? newValue) {
        ref.read(sellerFinanceProvider).updateFinancingType(newValue);
      },
    );
  }
}
