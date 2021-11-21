import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/address.dart';
import 'models/property.dart';

final addressProvider = ChangeNotifierProvider<Address>(
        (ref) => Address(street: '', line2: '', city: '', state: '',
        zip: ''));

final propertyProvider = ChangeNotifierProvider<Property>(
        (ref) => Property(address: Address(street: '', line2: '', city: '', state: '',
        zip: ''), listPrice: 0, )
);