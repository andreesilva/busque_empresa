import 'package:busca_empresa/app/core/theme/colors.app.dart';
import 'package:busca_empresa/app/modules/about/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends GetView<AboutController> {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre o Busque Empresa',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: ColorsApp.appTitle,
                fontSize: 20,
              ),
            )),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: ColorsApp.appBackground,
        shape: const Border(
            bottom: BorderSide(color: ColorsApp.appBorder, width: 0.5)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Form(
          child: Column(
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "O aplicativo Busque Empresa forneçe informações de empresas, consultadas atráves do seu CNPJ. Auxiliando dessa forma com a prospecção com as mesmas. ",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "O aplicativo Busque Empresa não coleta os dados de usuários.",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Nenhum dos dados registrados são salvos em nosso servidor.",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "O aplicativo faz uso de propaganda em suas telas.",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
