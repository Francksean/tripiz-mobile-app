import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/constants/font_weights.dart';

class CustomImagePicker extends StatefulWidget {
  final String label;
  final Widget child;
  final void Function(File) imageHandler;
  const CustomImagePicker({
    required this.child,
    required this.label,
    required this.imageHandler,
    super.key,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  Future<void> _pickImageFromGallery() async {
    final galleryImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (galleryImage != null) {
      File newImage = File(galleryImage.path);
      widget.imageHandler(newImage);
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickImageFromCamera() async {
    final cameraImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (cameraImage != null) {
      File newImage = File(cameraImage.path);
      widget.imageHandler(newImage);
      Navigator.pop(context);
    }
  }

  void _fireModalBottomSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                        fontWeight: FontWeights.bold,
                        fontSize: 18,
                      ),
                    ),
                    Icon(Icons.delete_outlined, color: AppColors.red),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImagePickerOption(
                      icon: Icons.image_search_outlined,
                      function: _pickImageFromGallery,
                      label: "Gallerie",
                    ),
                    const SizedBox(width: 40),
                    ImagePickerOption(
                      icon: Icons.camera_alt_outlined,
                      function: _pickImageFromCamera,
                      label: "Camera",
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: _fireModalBottomSheet, child: widget.child);
  }
}

class ImagePickerOption extends StatelessWidget {
  const ImagePickerOption({
    required this.function,
    required this.label,
    required this.icon,
    super.key,
  });

  final Function() function;
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(255, 219, 219, 219),
                width: 1,
              ),
            ),
            child: Icon(icon, color: AppColors.red),
          ),
          const SizedBox(height: 10),
          Text(label, style: TextStyle(fontWeight: FontWeights.bold)),
        ],
      ),
    );
  }
}
