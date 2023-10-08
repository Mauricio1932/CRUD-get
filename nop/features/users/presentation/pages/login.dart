// ignore_for_file: unused_field, prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform; 

import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'profile_page.dart';
import '../services/locales_api.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // variable de permanencia
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //variable de acceso
  late Future<bool> _access;
  
  String? _username;
  String? _password;

  final _formKey = GlobalKey<FormState>();

  // inicio de estado
  @override
  void initState() {
    super.initState();
    _access = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool('userLogeado') ?? false);
    });
    _passMenu();
  }

  Future<void> _passMenu() async {
    final SharedPreferences prefs = await _prefs;
    final bool? userLogeado = prefs.getBool('userLogeado');

    print("ir a home? => " '$userLogeado');

    if (userLogeado == true) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const Profile()));
    }
  }

  void _showErrorAlert(String message) {
    if (defaultTargetPlatform == TargetPlatform.android || kIsWeb) { 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('Error de inicio de sesión'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child:const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Error de inicio de sesión'),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    }
  }

  Future<void> _persistirSesion() async {
    final SharedPreferences prefs = await _prefs;
    //guardar sescion
    late bool logeado = true;

    setState(() {
      _access = prefs.setBool("userLogeado", logeado).then((bool success) {
        return logeado;
      });
    });
  }


  void _submitForm() async {

    _persistirSesion();
    // navigateToHomeView();
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Guardar los valores del formulario en las variables

      if (_username == null || _password == null) {
        print('Nombre de usuario o contraseña es nulo.');
        print(_password);
        return; // Sale de la función para evitar errores adicionales
      }

      String name = _username!;
      String pass = _password!;

    LoginService loginService = LoginService();
    Map<String, dynamic> loginResponse = await loginService.loginUser(name, pass);

    var estatus = loginResponse['status'];
    var data = loginResponse['data'];

    if (estatus == 200) {
      _persistirSesion();
      navigateToHomeView(estatus, data);
    } else if (estatus == 400) {
      _showErrorAlert('El usuario no existe.');
    } else {
      print('Error en la solicitud: $data');
    }
    }
  }

  

  void navigateToRegisterView() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const Register(),
      ),
    );
  }

  void navigateToHomeView(estatus, data) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => LocalView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: navigateToRegisterView,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo2.png',
                    width: 200.0,
                    height: 200.0,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'LocalEats',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 7.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Usuario',
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.person),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa un usuario';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _username = value; // Guardar el valor de entrada en _username
                          },
                        ),
                        const SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Contraseña',
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.lock),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingresa una contraseña';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _password = value; // Guardar el valor de entrada en _password
                                },
                              ),
                              const SizedBox(height: 10.0),
                              GestureDetector(
                                onTap: () {
                                  // Acción al presionar el texto "Forgot Password?"
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 93, 93, 93),
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 93, 93, 93),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    child: Container(
                      width: 200.0,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: const Center(
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: navigateToRegisterView,
                    child: const Text(
                      'Registrarme',
                      style: TextStyle(
                        color: Color.fromARGB(255, 93, 93, 93),
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

