import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/src/login/login_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthController authController;
  final Uri _url = Uri.parse('https://google.com');
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usuarioContorller;
  late TextEditingController _senhaContorller;
  bool obscure = true;

  @override
  void initState() {
    authController = AuthController(context: context);
    _usuarioContorller = TextEditingController();
    _senhaContorller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usuarioContorller.dispose();
    _senhaContorller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Usuário',
                      textAlign: TextAlign.start,
                    ),
                    TextFormField(
                      controller: _usuarioContorller,
                      maxLength: 20,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, idefique-se';
                        } else if (value.length < 2) {
                          return 'Nome usuário muito curto';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const Text(
                      'Senha',
                      textAlign: TextAlign.start,
                    ),
                    TextFormField(
                      controller: _senhaContorller,
                      obscureText: obscure,
                      maxLength: 20,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      keyboardType: TextInputType.visiblePassword,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9]*')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite sua senha';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          icon: const Icon(Icons.visibility_outlined),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authController.login(
                            usuario: _usuarioContorller.text.trim(),
                            senha: _senhaContorller.text.trim(),
                          );
                        }
                      },
                      child: const Text('Entrar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () async {
                if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                }
              },
              child: const Text('Politica de Privacidade'),
            ),
          ),
        ],
      ),
    );
  }
}
