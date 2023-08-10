import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditAvatarWidget extends StatefulWidget {
  const EditAvatarWidget({super.key});

  @override
  State<EditAvatarWidget> createState() => _EditAvatarWidgetState();
}

File? _imageFile;
final ImagePicker _picker = ImagePicker();

class _EditAvatarWidgetState extends State<EditAvatarWidget> {
  Future<void> takePhoto(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2.5,
              // ignore: prefer_const_constructors
              color: Color.fromARGB(255, 255, 216, 86),
            ),
            image: DecorationImage(
              image: _imageFile == null
                  ? const AssetImage('assets/images/avatar.jpg')
                  : FileImage(
                      File(_imageFile!.path),
                    ) as ImageProvider<Object>,
            ),
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          bottom: 5.0,
          right: 10.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (builder) => bottomSheet(context),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.cyanAccent,
              size: 20.0,
            ),
          ),
        )
      ],
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera),
                label: const Text("Camera"),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.image),
                label: const Text("Gallery"),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
