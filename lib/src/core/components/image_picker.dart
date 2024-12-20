import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/colors.dart';
import '../constants/variables.dart';
import 'buttons.dart';
import 'spaces.dart';

class ImagePickerWidget extends StatefulWidget {
  final String label;
  final void Function(XFile? file) onChanged;
  final bool showLabel;
  final String initialImage;

  const ImagePickerWidget({
    super.key,
    required this.label,
    required this.onChanged,
    this.showLabel = true,
    this.initialImage = "",
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  String imagePath = "";

  Future<void> _pickImage({required ImageSource source}) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
    );

    setState(() {
      if (pickedFile != null) {
        imagePath = pickedFile.path;
        widget.onChanged(pickedFile);
      } else {
        debugPrint("No image selected.");
        imagePath = "";
        widget.onChanged(null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel) ...[
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceHeight(12.0),
        ],
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey,
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 120.0,
                height: 120.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: widget.initialImage.isNotEmpty
                      ? imagePath.isNotEmpty
                          ? Image.file(
                              File(imagePath),
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              width: 120.0,
                              height: 120.0,
                              fit: BoxFit.cover,
                              imageUrl:
                                  '${Variables.imageBaseUrl}${widget.initialImage}',
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.food_bank_outlined,
                                size: 80,
                              ),
                            )
                      : imagePath.isNotEmpty
                          ? Image.file(
                              File(imagePath),
                              fit: BoxFit.cover,
                            )
                          : Container(
                              padding: const EdgeInsets.all(16.0),
                              color: AppColors.black.withOpacity(0.05),
                              child: Icon(Icons.image_outlined)),
                ),
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Button.filled(
                      height: 40.0,
                      width: 110.0,
                      onPressed: customBottomSheet,
                      label: "Pilih",
                    ),
                  ),
                  const SpaceHeight(14),
                  imagePath.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Button.filled(
                            height: 40.0,
                            width: 110.0,
                            onPressed: () {
                              setState(() {
                                imagePath = "";
                                widget.onChanged(null);
                              });
                            },
                            label: "Delete",
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> customBottomSheet() {
    return showModalBottomSheet(
      isDismissible: true,
      elevation: 5,
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 28,
                  color: AppColors.black,
                ),
              ),
              const Divider(),
              const SpaceHeight(8),
              const Text(
                "Pilih Photo Dari?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SpaceHeight(18),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Button.filled(
                      height: 50.0,
                      width: 160.0,
                      onPressed: () {
                        _pickImage(source: ImageSource.camera);
                        Navigator.pop(context);
                      },
                      label: "Camera",
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.white,
                      ),
                    ),
                    const Spacer(),
                    Button.filled(
                      height: 50.0,
                      width: 160.0,
                      onPressed: () {
                        _pickImage(source: ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      label: "Gallery",
                      icon: const Icon(
                        Icons.photo_camera_back_rounded,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
