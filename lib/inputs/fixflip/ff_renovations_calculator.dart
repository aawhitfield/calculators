import 'package:calculators/globals.dart';
import 'package:calculators/inputs/fixflip/ff_location.dart';
import 'package:calculators/inputs/fixflip/ff_property_costs.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/integer_text_field.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FixFlipRenovationsCalculator extends ConsumerStatefulWidget {
  const FixFlipRenovationsCalculator({Key? key}) : super(key: key);

  @override
  _RenovationsCalculatorState createState() => _RenovationsCalculatorState();
}

class _RenovationsCalculatorState
    extends ConsumerState<FixFlipRenovationsCalculator> {
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
  TextEditingController totalController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  @override
  void initState() {
    int monthsToRehab = ref.read(fixFlipProvider).monthsToRehabRent;
    if (monthsToRehab != 0) {
      monthsToRehabController.text = monthsToRehab.toString();
    }
    double foundation = ref.read(fixFlipProvider).foundation;
    if (foundation != 0) {
      foundationController.text = kCurrencyFormat.format(foundation);
    }
    double roof = ref.read(fixFlipProvider).roof;
    if (roof != 0) {
      roofController.text = kCurrencyFormat.format(roof);
    }
    double airConditioner = ref.read(fixFlipProvider).airConditioner;
    if (airConditioner != 0) {
      airConditionerController.text = kCurrencyFormat.format(airConditioner);
    }
    double painting = ref.read(fixFlipProvider).paintingPatching;
    if (painting != 0) {
      paintingController.text = kCurrencyFormat.format(painting);
    }
    double kitchen = ref.read(fixFlipProvider).kitchen;
    if (kitchen != 0) {
      kitchenController.text = kCurrencyFormat.format(kitchen);
    }
    double windows = ref.read(fixFlipProvider).windows;
    if (windows != 0) {
      windowsController.text = kCurrencyFormat.format(windows);
    }
    double plumbing = ref.read(fixFlipProvider).plumbing;
    if (plumbing != 0) {
      plumbingController.text = kCurrencyFormat.format(plumbing);
    }
    double flooring = ref.read(fixFlipProvider).flooring;
    if (flooring != 0) {
      flooringController.text = kCurrencyFormat.format(flooring);
    }
    double bathrooms = ref.read(fixFlipProvider).bathrooms;
    if (bathrooms != 0) {
      bathroomsController.text = kCurrencyFormat.format(bathrooms);
    }
    double appliances = ref.read(fixFlipProvider).appliances;
    if (appliances != 0) {
      appliancesController.text = kCurrencyFormat.format(appliances);
    }
    double electrical = ref.read(fixFlipProvider).electrical;
    if (electrical != 0) {
      electricalController.text = kCurrencyFormat.format(electrical);
    }
    double yard = ref.read(fixFlipProvider).yard;
    if (yard != 0) {
      yardController.text = kCurrencyFormat.format(yard);
    }
    double cleaning = ref.read(fixFlipProvider).cleaning;
    if (cleaning != 0) {
      cleaningController.text = kCurrencyFormat.format(cleaning);
    }
    double baseboards = ref.read(fixFlipProvider).baseboards;
    if (baseboards != 0) {
      baseboardsController.text = kCurrencyFormat.format(baseboards);
    }
    double exterior = ref.read(fixFlipProvider).exterior;
    if (exterior != 0) {
      exteriorController.text = kCurrencyFormat.format(exterior);
    }
    double total = ref.read(fixFlipProvider).totalRenovations;
    if (total != 0) {
      totalController.text = kCurrencyFormat.format(total);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double total = ref.watch(fixFlipProvider).totalRenovations;

    String totalString = kCurrencyFormat.format(total);

    return MyInputPage(
        imageUri: 'images/construction.svg',
        headerText: 'Renovations',
        subheadText: 'How much will it take to renovate the property?',
        onBack: () {
          String savedCalculatorID = ref.read(savedCalculatorProvider).uid;
          bool shouldOverrideBackButton = savedCalculatorID != '';
          if (shouldOverrideBackButton) {
            Get.off(() => FixFlipLocation('Fix and Flip'));
          } else {
            Get.back();
          }
        },
        onSubmit: () {
          if (!enterTotal) {
            ref.read(fixFlipProvider).calculateTotalRenovations();
          }
          Get.to(() => const FixFlipPropertyCosts());
        },
        position: kFixFlipQuestions.indexOf(FixFlipRenovationsCalculator) + 1,
        totalQuestions: kFixFlipQuestions.length,
        child: ResponsiveLayout(
          children: (enterTotal)
              ? [
                  MoneyTextField(
                    controller: totalController,
                    labelText: 'Total cost',
                    onChanged: (String newTotal) {
                      newTotal = newTotal.replaceAll(',', '');
                      double? total = double.tryParse(newTotal);
                      if (total != null) {
                        ref.read(fixFlipProvider).updateTotalRenovations(total);
                      }
                    },
                  ),
                  IntegerTextField(
                      labelText: 'Months to Rehab & Sell',
                      controller: monthsToRehabController,
                      onChanged: (String newValue) {
                        int? value = int.tryParse(newValue);
                        if (value != null) {
                          ref
                              .read(fixFlipProvider)
                              .updateMonthsToRehabRent(value);
                        }
                      }),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        enterTotal = false;
                        totalController.text = kCurrencyFormat.format(ref.read(fixFlipProvider).totalRenovations);
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
                        ref.read(fixFlipProvider).updateFoundation(foundation);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Roof',
                    controller: roofController,
                    onChanged: (String newRoof) {
                      newRoof = newRoof.replaceAll(',', '');
                      double? roof = double.tryParse(newRoof);
                      if (roof != null) {
                        ref.read(fixFlipProvider).updateRoof(roof);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Air Conditioner',
                    controller: airConditionerController,
                    onChanged: (String newAirConditioner) {
                      newAirConditioner = newAirConditioner.replaceAll(',', '');
                      double? airConditioner =
                          double.tryParse(newAirConditioner);
                      if (airConditioner != null) {
                        ref
                            .read(fixFlipProvider)
                            .updateAirConditioner(airConditioner);
                      }
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
                            .read(fixFlipProvider)
                            .updatePaintingPatching(painting);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Kitchen',
                    controller: kitchenController,
                    onChanged: (String newKitchen) {
                      newKitchen = newKitchen.replaceAll(',', '');

                      double? kitchen = double.tryParse(newKitchen);
                      if (kitchen != null) {
                        ref.read(fixFlipProvider).updateKitchen(kitchen);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Windows',
                    controller: windowsController,
                    onChanged: (String newWindows) {
                      newWindows = newWindows.replaceAll(',', '');

                      double? windows = double.tryParse(newWindows);
                      if (windows != null) {
                        ref.read(fixFlipProvider).updateWindows(windows);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Plumbing',
                    controller: plumbingController,
                    onChanged: (String newPlumbing) {
                      newPlumbing = newPlumbing.replaceAll(',', '');

                      double? plumbing = double.tryParse(newPlumbing);
                      if (plumbing != null) {
                        ref.read(fixFlipProvider).updatePlumbing(plumbing);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Flooring',
                    controller: flooringController,
                    onChanged: (String newFlooring) {
                      newFlooring = newFlooring.replaceAll(',', '');

                      double? flooring = double.tryParse(newFlooring);
                      if (flooring != null) {
                        ref.read(fixFlipProvider).updateFlooring(flooring);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Bathrooms',
                    controller: bathroomsController,
                    onChanged: (String newBathrooms) {
                      newBathrooms = newBathrooms.replaceAll(',', '');

                      double? bathrooms = double.tryParse(newBathrooms);
                      if (bathrooms != null) {
                        ref.read(fixFlipProvider).updateBathrooms(bathrooms);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Appliances',
                    controller: appliancesController,
                    onChanged: (String newAppliances) {
                      newAppliances = newAppliances.replaceAll(',', '');

                      double? appliances = double.tryParse(newAppliances);
                      if (appliances != null) {
                        ref.read(fixFlipProvider).updateAppliances(appliances);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Electrical',
                    controller: electricalController,
                    onChanged: (String newElectrical) {
                      newElectrical = newElectrical.replaceAll(',', '');

                      double? electrical = double.tryParse(newElectrical);
                      if (electrical != null) {
                        ref.read(fixFlipProvider).updateElectrical(electrical);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Yard',
                    controller: yardController,
                    onChanged: (String newYard) {
                      newYard = newYard.replaceAll(',', '');

                      double? yard = double.tryParse(newYard);
                      if (yard != null) {
                        ref.read(fixFlipProvider).updateYard(yard);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Cleaning',
                    controller: cleaningController,
                    onChanged: (String newCleaning) {
                      newCleaning = newCleaning.replaceAll(',', '');

                      double? cleaning = double.tryParse(newCleaning);
                      if (cleaning != null) {
                        ref.read(fixFlipProvider).updateCleaning(cleaning);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Baseboards',
                    controller: baseboardsController,
                    onChanged: (String newBaseboards) {
                      newBaseboards = newBaseboards.replaceAll(',', '');

                      double? baseboards = double.tryParse(newBaseboards);
                      if (baseboards != null) {
                        ref.read(fixFlipProvider).updateBaseboards(baseboards);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Exterior',
                    controller: exteriorController,
                    onChanged: (String newExterior) {
                      newExterior = newExterior.replaceAll(',', '');

                      double? exterior = double.tryParse(newExterior);
                      if (exterior != null) {
                        ref.read(fixFlipProvider).updateExterior(exterior);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Other',
                    controller: otherController,
                    onChanged: (String newValue) {
                      newValue = newValue.replaceAll(',', '');

                      double? other = double.tryParse(newValue);
                      if (other != null) {
                        ref.read(fixFlipProvider).updateOtherRenovations(other);
                      }
                    },
                  ),
                  MoneyListTile('Total', totalString),
                ],
        ));
  }
}
