import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoder_app/views/auth/business_address_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/repositories/auth/auth_repository.dart';
import 'package:invoder_app/data/repositories/auth/auth_parameters.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:invoder_app/data/models/auth_models.dart';

class BuissnessDetailsFormController extends GetxController {
  final box = GetStorage();
  AuthRepository authRepository = Get.put(AuthRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  final _buissnessType = ''.obs;
  final buissnessNameController = TextEditingController();
  final buissnessEmailController = TextEditingController();
  final buissnessPhoneController = TextEditingController();
  final _isOnlineBusiness = false.obs;
  final buissnessAddressController = TextEditingController();
  final buissnessCityController = TextEditingController();
  final buissnessStateController = TextEditingController();
  final buissnessZipController = TextEditingController();
  final buissnessCountryController = TextEditingController();
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  bool get isOnlineBusiness => _isOnlineBusiness.value;
  String get buissnessType => _buissnessType.value;

  List<Map<String, String>> buissnessTypes = [
    {'label': 'Sole Proprietorship', 'value': 'Sole Proprietorship'},
    {'label': 'Partnership', 'value': 'Partnership'},
    {
      'label':
          'Limited Liability Company wer wer ewr we rwe r wer we rwe r ew rwe r we rwe r wer wer',
      'value': 'Limited Liability Company'
    },
    {'label': 'Corporation', 'value': 'Corporation'},
    {'label': 'Nonprofit', 'value': 'Nonprofit'},
    {'label': 'Cooperative', 'value': 'Cooperative'},
    {'label': 'Other', 'value': 'Other'},
  ];

  void setBuissnessName(String value) => buissnessNameController.text = value;
  void setBuissnessType(dynamic value) => {
        _buissnessType.value = value,
      };
  void setBuissnessEmail(String value) => buissnessEmailController.text = value;
  void setBuissnessPhone(String value) => buissnessPhoneController.text = value;
  void setIsOnlineBusiness(bool? value) =>
      {_isOnlineBusiness.value = value!, resetAddress()};
  void setBuissnessAddress(String value) =>
      buissnessAddressController.text = value;
  void setBuissnessCity(String value) => buissnessCityController.text = value;
  void setBuissnessState(String value) => buissnessStateController.text = value;
  void setBuissnessZip(String value) => buissnessZipController.text = value;
  void setBuissnessCountry(String value) =>
      buissnessCountryController.text = value;

  void resetAddress() {
    buissnessAddressController.text = '';
    buissnessCityController.text = '';
    buissnessStateController.text = '';
    buissnessZipController.text = '';
    buissnessCountryController.text = '';
    addressFormKey.currentState?.reset();
  }

  void reset() {
    _buissnessType.value = '';
    buissnessNameController.text = '';
    buissnessEmailController.text = '';
    buissnessPhoneController.text = '';
    _isOnlineBusiness.value = false;
    buissnessAddressController.text = '';
    buissnessCityController.text = '';
    buissnessStateController.text = '';
    buissnessZipController.text = '';
    buissnessCountryController.text = '';
    formKey = GlobalKey<FormState>();
  }

  String? validateBuissnessType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Buissness type is required';
    }
    return null;
  }

  String? validateBuissnessName(String? value) {
    if (value!.isEmpty) {
      return 'Buissness name is required';
    }
    return null;
  }

  String? validateBuissnessEmail(String? value) {
    if (value!.isEmpty) {
      return 'Buissness Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validateBuissnessPhone(String? value) {
    if (value!.isEmpty) {
      return 'Buissness Phone is required';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  String? validateBuissnessAddress(String? value) {
    if (isOnlineBusiness) {
      return null;
    }
    if (value!.isEmpty) {
      return 'Buissness Address is required';
    }
    return null;
  }

  String? validateBuissnessCity(String? value) {
    if (isOnlineBusiness) {
      return null;
    }
    if (value!.isEmpty) {
      return 'Buissness City is required';
    }
    return null;
  }

  String? validateBuissnessState(String? value) {
    if (isOnlineBusiness) {
      return null;
    }
    if (value!.isEmpty) {
      return 'Buissness State is required';
    }
    return null;
  }

  String? validateBuissnessZip(String? value) {
    if (isOnlineBusiness) {
      return null;
    }
    if (value!.isEmpty) {
      return 'Buissness Zip is required';
    }
    return null;
  }

  String? validateBuissnessCountry(String? value) {
    if (value!.isEmpty) {
      return 'Buissness Country is required';
    }
    return null;
  }

  void submitDetail() {
    if (formKey.currentState?.validate() ?? false) {
      Get.to(() => const BusinessAddressScreen());
    }
  }

  void submitAddress() {
    if (addressFormKey.currentState?.validate() ?? false) {
      _isLoading.value = true;
      authRepository
          .addCompany(
        AddCompanyParameters(
          name: buissnessNameController.text,
          type: buissnessType,
          email: buissnessEmailController.text,
          phone: buissnessPhoneController.text,
          address: buissnessAddressController.text,
          city: buissnessCityController.text,
          state: buissnessStateController.text,
          zipCode: buissnessZipController.text,
          country: buissnessCountryController.text,
          isMultiBranch: isOnlineBusiness,
        ),
      )
          .then((value) {
        _isLoading.value = false;
        if (value.error) {
          Snackbar.show(
            message: value.message ?? 'Something went wrong',
            type: SnackType.error,
          );
        } else {
          Snackbar.show(
            message: 'Company created successfully',
            type: SnackType.success,
          );
          var userData = UserModel.fromMap(value.data);
          box.write('user', userData);
          Get.offAllNamed('/home');
        }
      });
    }
  }
}
