import 'package:calculators/globals.dart';
import 'package:calculators/inputs/finance_options.dart';
import 'package:calculators/providers.dart';
import 'package:calculators/widgets/money_list_tile.dart';
import 'package:calculators/widgets/money_text_field.dart';
import 'package:calculators/widgets/my_input_page.dart';
import 'package:calculators/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class RenovationsCalculator extends StatefulWidget {
  const RenovationsCalculator({Key? key}) : super(key: key);

  @override
  State<RenovationsCalculator> createState() => _RenovationsCalculatorState();
}

class _RenovationsCalculatorState extends State<RenovationsCalculator> {
  bool enterTotal = true;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        double tenPercent = ref.watch(renovationsProvider).tenPercentExtra;
        double total = ref.watch(renovationsProvider).total;

        String tenPercentString = kCurrencyFormat.format(tenPercent);
        String totalString = kCurrencyFormat.format(total);

        return MyInputPage(
            imageUri: 'images/construction.svg',
            headerText: 'Renovations',
            subheadText: 'How much will it take to renovate the property?',
            onSubmit: () {
              if (!enterTotal) {
                ref.read(renovationsProvider).calculateTotal();
              }
              Get.to(() => const FinanceOptions());
            },
            position: kResidentialREIQuestions.indexOf(RenovationsCalculator) +
                1,
            totalQuestions: kResidentialREIQuestions.length,
            child: ResponsiveLayout(
              children: (enterTotal)
                  ? [
                MoneyTextField(labelText: 'Total cost',
                  onChanged:
                      (String newTotal) {
                    newTotal = newTotal.replaceAll(',', '');
                    double? total = double.tryParse(newTotal);
                    if (total != null) {
                      ref.read(renovationsProvider).updateTotal(total);
                    }
                  },),
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
                MoneyTextField(labelText: 'Foundation',
                  onChanged:
                      (String newFoundation) {
                    newFoundation = newFoundation.replaceAll(',', '');
                    double? foundation = double.tryParse(newFoundation);
                    if (foundation != null) {
                      ref.read(renovationsProvider).updateFoundation(
                          foundation);
                    }
                  },),
                MoneyTextField(labelText: 'Roof',
                  onChanged:
                      (String newRoof) {
                    newRoof = newRoof.replaceAll(',', '');
                    double? roof = double.tryParse(newRoof);
                    if (roof != null) {
                      ref.read(renovationsProvider).updateRoof(roof);
                    }
                  },),
                MoneyTextField(labelText: 'Air Conditioner',
                  onChanged:
                      (String newAirConditioner) {
                    newAirConditioner = newAirConditioner.replaceAll(',', '');
                    double? airConditioner = double.tryParse(newAirConditioner);
                    if (airConditioner != null) {
                      ref.read(renovationsProvider).updateAirConditioner(
                          airConditioner);
                    }
                  },),
                MoneyTextField(labelText: 'Painting/Patching',
                  onChanged:
                      (String newPainting) {
                    newPainting = newPainting.replaceAll(',', '');

                    double? painting = double.tryParse(newPainting);
                    if (painting != null) {
                      ref.read(renovationsProvider).updatePaintingPatching(
                          painting);
                    }
                  },),
                MoneyTextField(labelText: 'Kitchen',
                  onChanged:
                      (String newKitchen) {
                    newKitchen = newKitchen.replaceAll(',', '');

                    double? kitchen = double.tryParse(newKitchen);
                    if (kitchen != null) {
                      ref.read(renovationsProvider).updateKitchen(kitchen);
                    }
                  },),
                MoneyTextField(labelText: 'Windows',
                  onChanged:
                      (String newWindows) {
                    newWindows = newWindows.replaceAll(',', '');

                    double? windows = double.tryParse(newWindows);
                    if (windows != null) {
                      ref.read(renovationsProvider).updateWindows(windows);
                    }
                  },),
                MoneyTextField(labelText: 'Plumbing',
                  onChanged:
                      (String newPlumbing) {
                    newPlumbing = newPlumbing.replaceAll(',', '');

                    double? plumbing = double.tryParse(newPlumbing);
                    if (plumbing != null) {
                      ref.read(renovationsProvider).updatePlumbing(plumbing);
                    }
                  },),
                MoneyTextField(labelText: 'Flooring',
                  onChanged:
                      (String newFlooring) {
                    newFlooring = newFlooring.replaceAll(',', '');

                    double? flooring = double.tryParse(newFlooring);
                    if (flooring != null) {
                      ref.read(renovationsProvider).updateFlooring(flooring);
                    }
                  },),
                MoneyTextField(labelText: 'Bathrooms',
                  onChanged:
                      (String newBathrooms) {
                    newBathrooms = newBathrooms.replaceAll(',', '');

                    double? bathrooms = double.tryParse(newBathrooms);
                    if (bathrooms != null) {
                      ref.read(renovationsProvider).updateBathrooms(bathrooms);
                    }
                  },),
                MoneyTextField(labelText: 'Appliances',
                  onChanged:
                      (String newAppliances) {
                    newAppliances = newAppliances.replaceAll(',', '');

                    double? appliances = double.tryParse(newAppliances);
                    if (appliances != null) {
                      ref.read(renovationsProvider).updateAppliances(
                          appliances);
                    }
                  },),
                MoneyTextField(labelText: 'Electrical',
                  onChanged:
                      (String newElectrical) {
                    newElectrical = newElectrical.replaceAll(',', '');

                    double? electrical = double.tryParse(newElectrical);
                    if (electrical != null) {
                      ref.read(renovationsProvider).updateElectrical(
                          electrical);
                    }
                  },),
                MoneyTextField(labelText: 'Yard',
                  onChanged:
                      (String newYard) {
                    newYard = newYard.replaceAll(',', '');

                    double? yard = double.tryParse(newYard);
                    if (yard != null) {
                      ref.read(renovationsProvider).updateYard(yard);
                    }
                  },),
                MoneyTextField(labelText: 'Cleaning',
                  onChanged:
                      (String newCleaning) {
                    newCleaning = newCleaning.replaceAll(',', '');

                    double? cleaning = double.tryParse(newCleaning);
                    if (cleaning != null) {
                      ref.read(renovationsProvider).updateCleaning(cleaning);
                    }
                  },),
                MoneyTextField(labelText: 'Baseboards',
                  onChanged:
                      (String newBaseboards) {
                    newBaseboards = newBaseboards.replaceAll(',', '');

                    double? baseboards = double.tryParse(newBaseboards);
                    if (baseboards != null) {
                      ref.read(renovationsProvider).updateBaseboards(
                          baseboards);
                    }
                  },),
                MoneyTextField(labelText: 'Exterior',
                  onChanged:
                      (String newExterior) {
                    newExterior = newExterior.replaceAll(',', '');

                    double? exterior = double.tryParse(newExterior);
                    if (exterior != null) {
                      ref.read(renovationsProvider).updateExterior(exterior);
                    }
                  },),
                MoneyTextField(labelText: 'Demo',
                  onChanged:
                      (String newDemo) {
                    newDemo = newDemo.replaceAll(',', '');

                    double? demo = double.tryParse(newDemo);
                    if (demo != null) {
                      ref.read(renovationsProvider).updateDemo(demo);
                    }
                  },),
                MoneyTextField(labelText: 'Elevators',
                  onChanged:
                      (String newElevators) {
                    newElevators = newElevators.replaceAll(',', '');

                    double? elevators = double.tryParse(newElevators);
                    if (elevators != null) {
                      ref.read(renovationsProvider).updateElevators(elevators);
                    }
                  },),
                MoneyTextField(labelText: 'Build 28 units',
                  onChanged:
                      (String newBuildUnits) {
                    newBuildUnits = newBuildUnits.replaceAll(',', '');

                    double? buildUnits = double.tryParse(newBuildUnits);
                    if (buildUnits != null) {
                      ref.read(renovationsProvider).updateBuildUnits(
                          buildUnits);
                    }
                  },),
                MoneyTextField(labelText: 'Other',
                  onChanged:
                      (String newOther) {
                    newOther = newOther.replaceAll(',', '');

                    double? other = double.tryParse(newOther);
                    if (other != null) {
                      ref.read(renovationsProvider).updateOther(other);
                    }
                  },),
                MoneyListTile('10% Extra', tenPercentString),
                MoneyListTile('Total', totalString),

              ],
            )

        );
      }
    );
  }
}
