import 'package:calculators/globals.dart';
import 'package:calculators/inputs/brrrr/location.dart';
import 'package:calculators/inputs/brrrr/property_costs.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class RenovationsCalculator extends ConsumerStatefulWidget {
  const RenovationsCalculator({Key? key}) : super(key: key);

  @override
  _RenovationsCalculatorState createState() => _RenovationsCalculatorState();
}

class _RenovationsCalculatorState extends ConsumerState<RenovationsCalculator> {
  bool enterTotal = true;

  TextEditingController monthsToRehabController = TextEditingController();
  TextEditingController foundationController = TextEditingController();
  TextEditingController roofController = TextEditingController();
  TextEditingController airConditionerController = TextEditingController();
  TextEditingController paintingController = TextEditingController();
  TextEditingController kitchenController = TextEditingController();
  TextEditingController windowsController = TextEditingController();
  TextEditingController plumbingController = TextEditingController();
  TextEditingController flooringController = TextEditingController();
  TextEditingController bathroomsController = TextEditingController();
  TextEditingController appliancesController = TextEditingController();
  TextEditingController electricalController = TextEditingController();
  TextEditingController yardController = TextEditingController();
  TextEditingController cleaningController = TextEditingController();
  TextEditingController baseboardsController = TextEditingController();
  TextEditingController exteriorController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  GlobalKey<FormState> brrrrRenovationsKey = GlobalKey<FormState>();

  @override
  void initState() {
    int monthsToRehab = ref.read(brrrrProvider).monthsToRehabRent;
    if (monthsToRehab != 0) {
      monthsToRehabController.text = monthsToRehab.toString();
    }
    double foundation = ref.read(brrrrProvider).foundation;
    if (foundation != 0) {
      foundationController.text = kCurrencyFormat.format(foundation);
    }
    double roof = ref.read(brrrrProvider).roof;
    if (roof != 0) {
      roofController.text = kCurrencyFormat.format(roof);
    }
    double airConditioner = ref.read(brrrrProvider).airConditioner;
    if (airConditioner != 0) {
      airConditionerController.text = kCurrencyFormat.format(airConditioner);
    }
    double painting = ref.read(brrrrProvider).paintingPatching;
    if (painting != 0) {
      paintingController.text = kCurrencyFormat.format(painting);
    }
    double kitchen = ref.read(brrrrProvider).kitchen;
    if (kitchen != 0) {
      kitchenController.text = kCurrencyFormat.format(kitchen);
    }
    double windows = ref.read(brrrrProvider).windows;
    if (windows != 0) {
      windowsController.text = kCurrencyFormat.format(windows);
    }
    double plumbing = ref.read(brrrrProvider).plumbing;
    if (plumbing != 0) {
      plumbingController.text = kCurrencyFormat.format(plumbing);
    }
    double flooring = ref.read(brrrrProvider).flooring;
    if (flooring != 0) {
      flooringController.text = kCurrencyFormat.format(flooring);
    }
    double bathrooms = ref.read(brrrrProvider).bathrooms;
    if (bathrooms != 0) {
      bathroomsController.text = kCurrencyFormat.format(bathrooms);
    }
    double appliances = ref.read(brrrrProvider).appliances;
    if (appliances != 0) {
      appliancesController.text = kCurrencyFormat.format(appliances);
    }
    double electrical = ref.read(brrrrProvider).electrical;
    if (electrical != 0) {
      electricalController.text = kCurrencyFormat.format(electrical);
    }
    double yard = ref.read(brrrrProvider).yard;
    if (yard != 0) {
      yardController.text = kCurrencyFormat.format(yard);
    }
    double cleaning = ref.read(brrrrProvider).cleaning;
    if (cleaning != 0) {
      cleaningController.text = kCurrencyFormat.format(cleaning);
    }
    double baseboards = ref.read(brrrrProvider).baseboards;
    if (baseboards != 0) {
      baseboardsController.text = kCurrencyFormat.format(baseboards);
    }
    double exterior = ref.read(brrrrProvider).exterior;
    if (exterior != 0) {
      exteriorController.text = kCurrencyFormat.format(exterior);
    }
    double total = ref.read(brrrrProvider).totalRenovations;
    if (total != 0) {
      totalController.text = kCurrencyFormat.format(total);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double total = ref.watch(brrrrProvider).totalRenovations;

    String totalString = kCurrencyFormat.format(total);

    return MyInputPage(
        imageUri: 'images/construction.svg',
        headerText: 'Renovations',
        subheadText: 'How much will it take to renovate the property?',
        onBack: () {
          String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
          bool shouldOverrideBackButton = savedCalculatorID != '';
          if (shouldOverrideBackButton) {
            Get.off(() => Location('BRRRR',
                subtitle: 'Buy, Rehab, Rent, Refinance, Repeat'));
          } else {
            Get.back();
          }
        },
        onSubmit: () {
          if (!enterTotal) {
            ref.read(brrrrProvider).calculateTotalRenovations();
          }
          if (brrrrRenovationsKey.currentState?.validate() ?? false) {
            Get.to(() => const PropertyCosts());
          }
        },
        position: kBRRRRQuestions.indexOf(RenovationsCalculator) + 1,
        totalQuestions: kBRRRRQuestions.length,
        child: Form(
          key: brrrrRenovationsKey,
          child: ResponsiveLayout(
            children: (enterTotal)
                ? [
                    MoneyTextField(
                      controller: totalController,
                      labelText: 'Total cost *',
                      onChanged: (String newTotal) {
                        newTotal = newTotal.replaceAll(',', '');
                        double? total = double.tryParse(newTotal);
                        if (total != null) {
                          ref.read(brrrrProvider).updateTotalRenovations(total);
                        }
                        else {
                          ref.read(brrrrProvider).updateTotalRenovations(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Total cost is required';
                        }
                        return null;
                      },
                    ),
                    IntegerTextField(
                      labelText: 'Months to Rehab & Rent *',
                      controller: monthsToRehabController,
                      onChanged: (String newValue) {
                        int? value = int.tryParse(newValue);
                        if (value != null) {
                          ref
                              .read(brrrrProvider)
                              .updateMonthsToRehabRent(value);
                        }
                        else {
                          ref.read(brrrrProvider).updateMonthsToRehabRent(0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Number of months is required';
                        }
                        return null;
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          enterTotal = false;
                        });
                      },
                      child: const Text(
                        'Or enter renovations by category',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ]
                : [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          enterTotal = true;
                          totalController.text =
                              kCurrencyFormat.format(ref.read(brrrrProvider).totalRenovations);
                        });
                      },
                      child: const Text(
                        'Just enter the total',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    MoneyTextField(
                      labelText: 'Foundation',
                      controller: foundationController,
                      onChanged: (String newFoundation) {
                        newFoundation = newFoundation.replaceAll(',', '');
                        double? foundation = double.tryParse(newFoundation);
                        if (foundation != null) {
                          ref.read(brrrrProvider).updateFoundation(foundation);
                        }
                        else {
                          ref.read(brrrrProvider).updateFoundation(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Roof',
                      controller: roofController,
                      onChanged: (String newRoof) {
                        newRoof = newRoof.replaceAll(',', '');
                        double? roof = double.tryParse(newRoof);
                        if (roof != null) {
                          ref.read(brrrrProvider).updateRoof(roof);
                        }
                        else {
                          ref.read(brrrrProvider).updateRoof(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Air Conditioner',
                      controller: airConditionerController,
                      onChanged: (String newAirConditioner) {
                        newAirConditioner =
                            newAirConditioner.replaceAll(',', '');
                        double? airConditioner =
                            double.tryParse(newAirConditioner);
                        if (airConditioner != null) {
                          ref
                              .read(brrrrProvider)
                              .updateAirConditioner(airConditioner);
                        }
                        else {
                          ref.read(brrrrProvider).updateAirConditioner(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Painting/Patching',
                      controller: paintingController,
                      onChanged: (String newPainting) {
                        newPainting = newPainting.replaceAll(',', '');

                        double? painting = double.tryParse(newPainting);
                        if (painting != null) {
                          ref
                              .read(brrrrProvider)
                              .updatePaintingPatching(painting);
                        }
                        else {
                          ref.read(brrrrProvider).updatePaintingPatching(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Kitchen',
                      controller: kitchenController,
                      onChanged: (String newKitchen) {
                        newKitchen = newKitchen.replaceAll(',', '');

                        double? kitchen = double.tryParse(newKitchen);
                        if (kitchen != null) {
                          ref.read(brrrrProvider).updateKitchen(kitchen);
                        }
                        else {
                          ref.read(brrrrProvider).updateKitchen(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Windows',
                      controller: windowsController,
                      onChanged: (String newWindows) {
                        newWindows = newWindows.replaceAll(',', '');

                        double? windows = double.tryParse(newWindows);
                        if (windows != null) {
                          ref.read(brrrrProvider).updateWindows(windows);
                        }
                        else {
                          ref.read(brrrrProvider).updateWindows(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Plumbing',
                      controller: plumbingController,
                      onChanged: (String newPlumbing) {
                        newPlumbing = newPlumbing.replaceAll(',', '');

                        double? plumbing = double.tryParse(newPlumbing);
                        if (plumbing != null) {
                          ref.read(brrrrProvider).updatePlumbing(plumbing);
                        }
                        else {
                          ref.read(brrrrProvider).updatePlumbing(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Flooring',
                      controller: flooringController,
                      onChanged: (String newFlooring) {
                        newFlooring = newFlooring.replaceAll(',', '');

                        double? flooring = double.tryParse(newFlooring);
                        if (flooring != null) {
                          ref.read(brrrrProvider).updateFlooring(flooring);
                        }
                        else {
                          ref.read(brrrrProvider).updateFlooring(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Bathrooms',
                      controller: bathroomsController,
                      onChanged: (String newBathrooms) {
                        newBathrooms = newBathrooms.replaceAll(',', '');

                        double? bathrooms = double.tryParse(newBathrooms);
                        if (bathrooms != null) {
                          ref.read(brrrrProvider).updateBathrooms(bathrooms);
                        }
                        else {
                          ref.read(brrrrProvider).updateBathrooms(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Appliances',
                      controller: appliancesController,
                      onChanged: (String newAppliances) {
                        newAppliances = newAppliances.replaceAll(',', '');

                        double? appliances = double.tryParse(newAppliances);
                        if (appliances != null) {
                          ref.read(brrrrProvider).updateAppliances(appliances);
                        }
                        else {
                          ref.read(brrrrProvider).updateAppliances(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Electrical',
                      controller: electricalController,
                      onChanged: (String newElectrical) {
                        newElectrical = newElectrical.replaceAll(',', '');

                        double? electrical = double.tryParse(newElectrical);
                        if (electrical != null) {
                          ref.read(brrrrProvider).updateElectrical(electrical);
                        }
                        else {
                          ref.read(brrrrProvider).updateElectrical(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Yard',
                      controller: yardController,
                      onChanged: (String newYard) {
                        newYard = newYard.replaceAll(',', '');

                        double? yard = double.tryParse(newYard);
                        if (yard != null) {
                          ref.read(brrrrProvider).updateYard(yard);
                        }
                        else {
                          ref.read(brrrrProvider).updateYard(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Cleaning',
                      controller: cleaningController,
                      onChanged: (String newCleaning) {
                        newCleaning = newCleaning.replaceAll(',', '');

                        double? cleaning = double.tryParse(newCleaning);
                        if (cleaning != null) {
                          ref.read(brrrrProvider).updateCleaning(cleaning);
                        }
                        else {
                          ref.read(brrrrProvider).updateCleaning(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Baseboards',
                      controller: baseboardsController,
                      onChanged: (String newBaseboards) {
                        newBaseboards = newBaseboards.replaceAll(',', '');

                        double? baseboards = double.tryParse(newBaseboards);
                        if (baseboards != null) {
                          ref.read(brrrrProvider).updateBaseboards(baseboards);
                        }
                        else {
                          ref.read(brrrrProvider).updateBaseboards(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Exterior',
                      controller: exteriorController,
                      onChanged: (String newExterior) {
                        newExterior = newExterior.replaceAll(',', '');

                        double? exterior = double.tryParse(newExterior);
                        if (exterior != null) {
                          ref.read(brrrrProvider).updateExterior(exterior);
                        }
                        else {
                          ref.read(brrrrProvider).updateExterior(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyTextField(
                      labelText: 'Other',
                      controller: otherController,
                      onChanged: (String newValue) {
                        newValue = newValue.replaceAll(',', '');

                        double? other = double.tryParse(newValue);
                        if (other != null) {
                          ref.read(brrrrProvider).updateOtherRenovations(other);
                        }
                        else {
                          ref.read(brrrrProvider).updateOtherRenovations(0.0);
                        }
                        ref.read(brrrrProvider).calculateAll();
                      },
                    ),
                    MoneyListTile('Total', totalString),
                  ],
          ),
        ));
  }
}
