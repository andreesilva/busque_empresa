import 'package:busca_empresa/app/modules/button_return/controller.dart';
import 'package:busca_empresa/app/routes/routes.dart';
import 'package:busca_empresa/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonReturnPage extends GetView<ButtonReturnController> {
  ButtonReturnPage({super.key});

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
              Obx(
                () => controller.variableTimer.isFalse
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Muitas solicitações feitas recentemente.",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Aguarde um momento e tente novamente.",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${controller.timeLeft}",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10),
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
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
