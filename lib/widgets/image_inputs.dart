import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  const ImageInput(this.onselectImage);
  final Function onselectImage;

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
    File? _storedImage;
    //instance member 'pickImage' can't be accessed using static access. (Documentation), got this error when i did it his way
    final ImagePicker _picker = ImagePicker();
    Future<void>_takePicture() async{
      final imageFile = await _picker.pickImage(source: ImageSource.camera, maxHeight: 600);

      setState() {
        // TODO: implement setState
        _storedImage = imageFile as File?;
      }
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName =  path.basename(imageFile!.path);
      //final savedImage = await imageFile.copy('${appDir.path}/$fileName');
      final savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');

      widget.onselectImage(savedImage);
    }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage !=null? Image.file(_storedImage!,fit: BoxFit.cover,width: double.infinity,): Text('No image taken',textAlign: TextAlign.center,),
    alignment: Alignment.center,
        ),
        SizedBox(height: 10,),
// wrap flatbutton in expanded so that it will take the remaining space available
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
              label: Text('Take picture'),
              textColor: Theme.of(context).primaryColor,
              onPressed:
              _takePicture,


          ),
        )
      ],

    );
  }
}
