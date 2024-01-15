import 'dart:async';
import 'dart:io';

import 'package:busca_empresa/app/core/theme/colors.app.dart';
import 'package:busca_empresa/app/modules/home/controller.dart';
import 'package:busca_empresa/app/routes/routes.dart';
import 'package:busca_empresa/app/widgets/button.dart';
import 'package:busca_empresa/helpers/app_lifecycle_reactor.dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends GetView<HomeController> {
  HomePage({
    super.key,
  });
  final phoneMaskFormatter = MaskTextInputFormatter(mask: '##.###.###/####-##');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar empresa',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: ColorsApp.appTitle,
                fontSize: 20,
              ),
            )),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.about);
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: ColorsApp.appBackground,
        shape: const Border(
            bottom: BorderSide(color: ColorsApp.appBorder, width: 0.5)),
      ),
      body: controller.obx(
        (state) => SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 0, right: 10, left: 10, bottom: 0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                          child: Center(
                        child: Stack(children: [
                          Column(children: [
                            Form(
                              key: controller.formKey,
                              child: Column(
                                children: [
                                  Center(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      autofocus: false,
                                      controller: controller.typedText,
                                      decoration: InputDecoration(
                                        hintText: "Informe o CNPJ",
                                        helperStyle: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        filled: true,
                                        focusColor: Colors.black,
                                        fillColor: Colors.white,
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        labelStyle: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      inputFormatters: [phoneMaskFormatter],
                                      validator: (String? value) {
                                        if (value != null && value.isEmpty) {
                                          return 'Favor  preencher o campo';
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Obx(
                                  () => controller.variableTimer.isFalse
                                      ? Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0.0),
                                            child: ElevatedButton(
                                              style: button,
                                              child: AnimatedBuilder(
                                                animation:
                                                    controller.loadingCircular,
                                                builder: (context, _) {
                                                  return controller
                                                          .loadingCircular.value
                                                      ? const SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : Text(
                                                          'Consultar',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        );
                                                },
                                              ),
                                              onPressed: () => {
                                                if (controller
                                                    .formKey.currentState!
                                                    .validate())
                                                  {
                                                    controller.loadingCircular
                                                        .value = true,
                                                    controller.cn.value = true,
                                                    controller.variableTimer
                                                        .value = true,
                                                    controller.timeLeft.value =
                                                        20,
                                                    controller.clickedButton
                                                        .value = false,
                                                    controller.startTimer(),
                                                    controller.submit(),
                                                  }
                                              },
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Aguarde...${controller.timeLeft}',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ])
                        ]),
                      )),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => controller.cn.isFalse
                                  ? const Text(
                                      '',
                                      style: TextStyle(fontSize: 22),
                                    )
                                  : controller.state!.status == "ERROR"
                                      ? Column(
                                          children: [
                                            Card(
                                              surfaceTintColor: Colors.white,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 20, 0, 10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                side: const BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.5,
                                                ),
                                              ),
                                              elevation: 4,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    color: Colors.red,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5,
                                                              left: 20,
                                                              right: 20,
                                                              bottom: 5),
                                                      child: Center(
                                                        child: Text(
                                                          "CNPJ inválido",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                            ),
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
                                      : controller.state!.cnpj ==
                                              "06.947.283/0001-60" //CNPJ do google
                                          ? const Text(
                                              '',
                                              style: TextStyle(fontSize: 22),
                                            )
                                          : Expanded(
                                              child: Card(
                                                surfaceTintColor: Colors.white,
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.5,
                                                  ),
                                                ),
                                                elevation: 4,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 5,
                                                                left: 20,
                                                                right: 20),
                                                        child: Text(
                                                          controller
                                                              .state!.fantasy!,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 5,
                                                                left: 20,
                                                                right: 20),
                                                        child: Text(
                                                          "CNPJ: ${controller.state!.cnpj!}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 5,
                                                                left: 20,
                                                                right: 20),
                                                        child: Text(
                                                          "Empresa: ${controller.state!.name!}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 5,
                                                                left: 20,
                                                                right: 20),
                                                        child: Text(
                                                          controller.state!
                                                                      .status! ==
                                                                  'OK'
                                                              ? 'Status: ATIVO'
                                                              : 'Status: INATIVO',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 5,
                                                                left: 20,
                                                                right: 20),
                                                        child: Text(
                                                          "Capital social: R\$ ${controller.state!.shareCapital}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => controller
                                                              .variableTimer
                                                              .isFalse
                                                          ? Container(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8,
                                                                        left: 0,
                                                                        top: 10,
                                                                        bottom:
                                                                            4),
                                                                child: SizedBox(
                                                                  width: 100,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      var formatted = controller.removeTrace(controller
                                                                          .state!
                                                                          .cnpj);
                                                                      Get.toNamed(Routes
                                                                          .enterprise
                                                                          .replaceFirst(
                                                                              ':id',
                                                                              formatted));
                                                                    },
                                                                    style:
                                                                        button_2,
                                                                    child: FittedBox(
                                                                        fit: BoxFit.scaleDown,
                                                                        child: Text("Ver mais",
                                                                            style: GoogleFonts.poppins(
                                                                              textStyle: const TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                            ))),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Text(""),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                            ),
                          ]),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
