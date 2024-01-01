import 'package:busca_empresa/app/routes/routes.dart';
import 'package:busca_empresa/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonErrorConectionPage extends GetView {
  const ButtonErrorConectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.centerLeft,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Sem conexão de rede",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                child: ElevatedButton(
                  onPressed: () => Get.offAllNamed(Routes.home),
                  style: button,
                  child: Text("Tentar novamente",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
