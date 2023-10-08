import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'profile_page.dart';
import 'home_page.dart';

class Rlocal extends StatefulWidget {
  const Rlocal({Key? key}) : super(key: key);

  @override
  State<Rlocal> createState() => _RlocalState();
}

class _RlocalState extends State<Rlocal> {
  bool isLiked = false;
  Color likeIconColor = Colors.white; // Color cuando está desactivado
  Color likedIconColor = Colors.red; // Color cuando está activado
  double likeButtonScale = 1.5; // Escala inicial del botón
  double nearMeIconScale = 0.8; // Escala del icono "near me"
  double starIconScale = 0.8; // Escala de las estrellas

  void navigateToHomeView() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const Profile(),
      ),
    );
  }

  String customTitle = '';
  String customSubtitle = '';
  String customDescription = '';

  void setCustomTitle(String title) {
    setState(() {
      customTitle = title;
    });
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      // Actualizar el color del ícono
      likeIconColor = isLiked ? likedIconColor : Colors.white;
      // Actualizar la escala del botón
      likeButtonScale = isLiked ? 1.5 : 1.5;
    });
  }

  File? selectedImage; // Variable para almacenar la imagen seleccionada

  void pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: InkWell(
                  onTap:
                      pickImage, // Llama a la función para seleccionar imagen
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      image: selectedImage != null
                          ? DecorationImage(
                              image: FileImage(selectedImage!),
                              fit: BoxFit.cover)
                          : null,
                    ),
                    child: selectedImage == null
                        ? const Center(
                            child: Icon(Icons.photo,
                                size: 100, color: Colors.grey))
                        : null,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment
                      .topCenter, // Ajusta la posición vertical del cuadro
                  child: FractionalTranslation(
                    translation:
                        const Offset(0.0, -0.5), // Mueve el cuadro hacia arriba
                    child: Container(
                      width:
                          150, // Ajusta el ancho del cuadro según tus necesidades
                      height:
                          35, // Ajusta el alto del cuadro según tus necesidades
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
                            scale: nearMeIconScale,
                            child: const Icon(
                              Icons.near_me,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'Ubicación',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 50,
            right: 15,
            child: Transform.scale(
              scale: likeButtonScale,
              child: IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: likeIconColor,
                ),
                onPressed: toggleLike,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 2,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
              onPressed: navigateToHomeView,
            ),
          ),
          Positioned(
            top: 320, // Ajusta la posición vertical del texto principal
            left: 20, // Ajusta la posición horizontal del texto principal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Fonda El Panalito',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Mexicana ◦ Especies',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
