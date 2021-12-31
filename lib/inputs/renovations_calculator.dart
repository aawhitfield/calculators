import 'package:calculators/globals.dart';
import 'package:calculators/inputs/property_costs.dart';
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
  TextEditingController demoController = TextEditingController();
  TextEditingController elevatorsController = TextEditingController();
  TextEditingController build28Controller = TextEditingController();
  TextEditingController otherController = TextEditingController();
  TextEditingController totalController = TextEditingController();

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
    double demo = ref.read(brrrrProvider).demo;
    if (demo != 0) {
      demoController.text = kCurrencyFormat.format(demo);
    }
    double elevators = ref.read(brrrrProvider).elevators;
    if (elevators != 0) {
      elevatorsController.text = kCurrencyFormat.format(elevators);
    }
    double build28 = ref.read(brrrrProvider).build28Units;
    if (build28 != 0) {
      build28Controller.text = kCurrencyFormat.format(build28);
    }
    double other = ref.read(brrrrProvider).otherRenovations;
    if (other != 0) {
      otherController.text = kCurrencyFormat.format(other);
    }
    double total = ref.read(brrrrProvider).totalRenovations;
    if (total != 0) {
      totalController.text = kCurrencyFormat.format(total);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double tenPercent = ref.watch(brrrrProvider).tenPercentExtra;
    double total = ref.watch(brrrrProvider).totalRenovations;

    String tenPercentString = kCurrencyFormat.format(tenPercent);
    String totalString = kCurrencyFormat.format(total);

    return MyInputPage(
        imageUri: 'images/construction.svg',
        headerText: 'Renovations',
        subheadText: 'How much will it take to renovate the property?',
        onSubmit: () {
          if (!enterTotal) {
            ref.read(brrrrProvider).calculateTotalRenovations();
          }
          Get.to(() => const PropertyCosts());
        },
        position: kBRRRRQuestions.indexOf(RenovationsCalculator) + 1,
        totalQuestions: kBRRRRQuestions.length,
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
                        ref.read(brrrrProvider).updateTotalRenovations(total);
                      }
                    },
                  ),
                  IntegerTextField(
                      labelText: 'Months to Rehab/Rent',
                      controller: monthsToRehabController,
                      onChanged: (String newValue) {
                        int? value = int.tryParse(newValue);
                        if (value != null) {
                          ref
                              .read(brrrrProvider)
                              .updateMonthsToRehabRent(value);
                        }
                      }),
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
                            .read(brrrrProvider)
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
                            .read(brrrrProvider)
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
                        ref.read(brrrrProvider).updateKitchen(kitchen);
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
                        ref.read(brrrrProvider).updateWindows(windows);
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
                        ref.read(brrrrProvider).updatePlumbing(plumbing);
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
                        ref.read(brrrrProvider).updateFlooring(flooring);
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
                        ref.read(brrrrProvider).updateBathrooms(bathrooms);
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
                        ref.read(brrrrProvider).updateAppliances(appliances);
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
                        ref.read(brrrrProvider).updateElectrical(electrical);
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
                        ref.read(brrrrProvider).updateYard(yard);
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
                        ref.read(brrrrProvider).updateCleaning(cleaning);
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
                        ref.read(brrrrProvider).updateBaseboards(baseboards);
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
                        ref.read(brrrrProvider).updateExterior(exterior);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Demo',
                    controller: demoController,
                    onChanged: (String newDemo) {
                      newDemo = newDemo.replaceAll(',', '');

                      double? demo = double.tryParse(newDemo);
                      if (demo != null) {
                        ref.read(brrrrProvider).updateDemo(demo);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Elevators',
                    controller: elevatorsController,
                    onChanged: (String newElevators) {
                      newElevators = newElevators.replaceAll(',', '');

                      double? elevators = double.tryParse(newElevators);
                      if (elevators != null) {
                        ref.read(brrrrProvider).updateElevators(elevators);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Build 28 units',
                    controller: build28Controller,
                    onChanged: (String newBuildUnits) {
                      newBuildUnits = newBuildUnits.replaceAll(',', '');

                      double? buildUnits = double.tryParse(newBuildUnits);
                      if (buildUnits != null) {
                        ref.read(brrrrProvider).updateBuildUnits(buildUnits);
                      }
                    },
                  ),
                  MoneyTextField(
                    labelText: 'Other',
                    controller: otherController,
                    onChanged: (String newOther) {
                      newOther = newOther.replaceAll(',', '');

                      double? other = double.tryParse(newOther);
                      if (other != null) {
                        ref.read(brrrrProvider).updateOtherRenovations(other);
                      }
                    },
                  ),
                  MoneyListTile('10% Extra', tenPercentString),
                  MoneyListTile('Total', totalString),
                ],
        ));
  }
}
