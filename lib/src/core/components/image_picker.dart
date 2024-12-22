import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/colors.dart';
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
    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
          onTap: imagePath.isEmpty ? customBottomSheet : null,
          child: Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[300],
            ),
            child: imagePath.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Image.asset(
                      'assets/images/add.png',
                      // width: 40,
                      // height: 40,
                    ),
                  ),
          ),
        ),
        imagePath.isEmpty
            ? const SizedBox.shrink()
            : Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      imagePath = "";
                      widget.onChanged(null);
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 28,
                      color: AppColors.white,
                    ),
                  ),
                ),
              )
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
