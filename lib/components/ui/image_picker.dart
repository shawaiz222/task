import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';
import 'package:invoder_app/data/models/common_models.dart';
import 'package:invoder_app/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:invoder_app/data/repositories/common_repository.dart';
import 'package:invoder_app/utils/generate.dart';

class CustomImagePicker extends StatefulWidget {
  final Function(ImageModel?) onImageSelected;
  final ImageModel? value;

  const CustomImagePicker({Key? key, required this.onImageSelected, this.value})
      : super(key: key);

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  final CommonRepository _commonRepository = CommonRepository();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: ThemeColors.borderColor,
          width: 1,
        ),
      ),
      child: Material(
        color: ThemeColors.lightGrayColor,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () async {
            final XFile? image = await _picker.pickImage(
              source: ImageSource.gallery,
              imageQuality: 50,
              maxWidth: 150,
              maxHeight: 150,
            );
            if (image != null) {
              // show full screen loader
              Get.dialog(
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Uploading Image',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ),
                barrierDismissible: false,
              );
              _commonRepository
                  .uploadImage(
                image,
              )
                  .then((value) {
                Get.back();
                if (!value.error) {
                  var imageModel = ImageModel.fromMap(value.data);
                  widget.onImageSelected(imageModel);
                } else {
                  Snackbar.show(
                    message: value.message ?? 'Something went wrong',
                    type: SnackType.error,
                  );
                }
              });
            }
          },
          child: widget.value?.key == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIcon(icon: CustomIcons.imageIcon, size: 20),
                    const SizedBox(height: 5),
                    Text(
                      'Add Image',
                      style: TextStyle(
                        color: primaryColor.shade900,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.network(
                    generateImageUrl(widget.value!.key!),
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
