import 'package:busca_empresa/app/core/theme/colors.app.dart';
import 'package:busca_empresa/app/modules/enterprise/controller.dart';
import 'package:busca_empresa/app/routes/routes.dart';
import 'package:busca_empresa/app/widgets/button.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EnterprisePage extends GetView<EnterpriseController> {
  const EnterprisePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Empresa',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: ColorsApp.appTitle,
                fontSize: 20,
              ),
            )),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.about);
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
        surfaceTintColor: Colors.white,
        backgroundColor: ColorsApp.appBackground,
        shape: const Border(
            bottom: BorderSide(color: ColorsApp.appBorder, width: 0.5)),
      ),
      body: controller.obx(
        (state) => SingleChildScrollView(
            padding:
                const EdgeInsets.only(top: 40, right: 0, left: 0, bottom: 0),
            child: Column(children: [
              Card(
                surfaceTintColor: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                color: ColorsApp.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                  side: const BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                elevation: 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 20, right: 20),
                              child: Text(
                                controller.state!.fantasy!,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        controller.state!.status == "OK"
                            ? Container(
                                alignment: Alignment.center,
                                child: badges.Badge(
                                  badgeStyle: badges.BadgeStyle(
                                    badgeColor: Colors.green,
                                    shape: badges.BadgeShape.square,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(0),
                                        topLeft: Radius.circular(0),
                                        bottomLeft: Radius.circular(3),
                                        bottomRight: Radius.circular(0)),
                                  ),
                                  badgeContent: Text(
                                    "ATIVO",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                child: badges.Badge(
                                  badgeStyle: badges.BadgeStyle(
                                    badgeColor: Colors.red,
                                    shape: badges.BadgeShape.square,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(2),
                                        topLeft: Radius.circular(0),
                                        bottomLeft: Radius.circular(3),
                                        bottomRight: Radius.circular(3)),
                                  ),
                                  badgeContent: Text("INATIVO",
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
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 20, right: 20),
                              child: Text(
                                controller.state!.name!,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 20, right: 20),
                            child: Text(
                              "CNPJ: ${controller.state!.cnpj!} (${controller.state!.type!})",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 10, left: 15),
                            child:
                                Icon(Icons.attach_money, color: Colors.green),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 0),
                            child: Text(
                              'Capital social: R\$ ${controller.state!.shareCapital!}',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 175, top: 5),
                    ),
                  ],
                ),
              ),
              if ((controller.state!.email!.isNotEmpty) ||
                  (controller.state!.phone!.isNotEmpty))
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () => {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Wrap(
                            children: [
                              if (controller.state!.phone!.isNotEmpty)
                                ListTile(
                                  leading: const Icon(
                                    Icons.phone_enabled_outlined,
                                    color: ColorsApp.orange,
                                  ),
                                  title: Text(
                                    controller.state!.phone!,
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  onTap: () => {},
                                ),
                              if (controller.state!.email!.isNotEmpty)
                                ListTile(
                                    leading: const Icon(
                                      Icons.email_outlined,
                                      color: ColorsApp.orange,
                                    ),
                                    title: Text(
                                      controller.state!.email!,
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      String email =
                                          controller.state!.email!.toString();
                                      final Uri emaillUri = Uri(
                                        scheme: 'mailto',
                                        path: email,
                                        query: '',
                                      );
                                      // ignore: deprecated_member_use
                                      launch(emaillUri.toString());
                                    }),
                            ],
                          );
                        },
                      )
                    },
                    style: button,
                    child: Text("Entrar em contato com a empresa",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        )),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              Card(
                surfaceTintColor: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                color: ColorsApp.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                  side: const BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                elevation: 4,
                child: Center(
                  child: Column(
                    children: [
                      Obx(
                        () => Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 1, left: 5, top: 10, bottom: 4),
                                    child: SizedBox(
                                      width: 88,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.currentPageIndex.value = 0;

                                          controller.colorButton1.value = true;
                                          controller.colorButton2.value = false;
                                          controller.colorButton3.value = false;
                                          controller.colorButton4.value = false;

                                          controller.startCard.value = true;
                                        },
                                        style: ElevatedButton.styleFrom(
                                          textStyle: const TextStyle(
                                              color: Colors.black),
                                          backgroundColor:
                                              controller.colorButton1.value !=
                                                      true
                                                  ? ColorsApp.button_menu_origin
                                                  : ColorsApp.button_menu,
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 0, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          elevation: 0,
                                          shadowColor: Colors.white,
                                        ),
                                        child: Text(
                                          "Atividades",
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 9,
                                                color: controller.colorButton1
                                                            .value !=
                                                        true
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 1, left: 2, top: 10, bottom: 4),
                                    child: SizedBox(
                                      width: 88,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.currentPageIndex.value = 1;

                                          controller.colorButton2.value = true;
                                          controller.colorButton1.value = false;
                                          controller.colorButton3.value = false;
                                          controller.colorButton4.value = false;

                                          controller.startCard.value = true;
                                        },
                                        style: ElevatedButton.styleFrom(
                                          textStyle: const TextStyle(
                                              color: Colors.black),
                                          backgroundColor:
                                              controller.colorButton2.value !=
                                                      true
                                                  ? ColorsApp.button_menu_origin
                                                  : ColorsApp.button_menu,
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 0, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          elevation: 0,
                                          shadowColor: Colors.white,
                                        ),
                                        child: Text("Sócios",
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 10,
                                                  color: controller.colorButton2
                                                              .value !=
                                                          true
                                                      ? Colors.black
                                                      : Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 1, left: 2, top: 10, bottom: 4),
                                    child: SizedBox(
                                      width: 88,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.currentPageIndex.value = 2;
                                          controller.colorButton3.value = true;

                                          controller.colorButton1.value = false;
                                          controller.colorButton2.value = false;
                                          controller.colorButton4.value = false;

                                          controller.startCard.value = true;
                                        },
                                        style: ElevatedButton.styleFrom(
                                          textStyle: const TextStyle(
                                              color: Colors.black),
                                          backgroundColor:
                                              controller.colorButton3.value !=
                                                      true
                                                  ? ColorsApp.button_menu_origin
                                                  : ColorsApp.button_menu,
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 0, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          elevation: 0,
                                          shadowColor: Colors.white,
                                        ),
                                        child: Text(
                                          "Endereço",
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 10,
                                                color: controller.colorButton3
                                                            .value !=
                                                        true
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5, left: 2, top: 10, bottom: 4),
                                    child: SizedBox(
                                      width: 88,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.currentPageIndex.value = 3;
                                          controller.colorButton4.value = true;

                                          controller.colorButton2.value = false;
                                          controller.colorButton3.value = false;
                                          controller.colorButton1.value = false;

                                          controller.startCard.value = true;
                                        },
                                        style: ElevatedButton.styleFrom(
                                          textStyle: const TextStyle(
                                              color: Colors.black),
                                          backgroundColor:
                                              controller.colorButton4.value !=
                                                      true
                                                  ? ColorsApp.button_menu_origin
                                                  : ColorsApp.button_menu,
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 0, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          elevation: 0,
                                          shadowColor: Colors.white,
                                        ),
                                        child: Text("Contatos",
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 10,
                                                  color: controller.colorButton4
                                                              .value !=
                                                          true
                                                      ? Colors.black
                                                      : Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 175, top: 5),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(
                () => controller.startCard.isFalse
                    ? const Text(
                        '',
                        style: TextStyle(fontSize: 22),
                      )
                    : IndexedStack(
                        index: controller.currentPageIndex.value,
                        children: [
                          Card(
                            surfaceTintColor: Colors.white,
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            color: ColorsApp.card,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            elevation: 4,
                            child: Center(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 5, left: 20, right: 20),
                                            child: Text(
                                              "Atividade principal",
                                              softWrap: false,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  for (var activity
                                      in controller.state!.mainActivity) ...[
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 20, right: 20),
                                              child: Text(
                                                "CNAE: ${activity.code!}",
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 20, right: 20),
                                              child: Text(
                                                activity.text!,
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 5, left: 20, right: 20),
                                            child: Text(
                                              "Atividade secundária",
                                              softWrap: false,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  for (var activity in controller
                                      .state!.secondaryActivity) ...[
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 20, right: 20),
                                              child: Text(
                                                activity.text!,
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 5,
                                      thickness: 1,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Colors.grey,
                                    ),
                                  ],
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 175, top: 5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            surfaceTintColor: Colors.white,
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            color: ColorsApp.card,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            elevation: 4,
                            child: Center(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 5, left: 20, right: 20),
                                            child: Text("Sócios",
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  for (var partner
                                      in controller.state!.partners) ...[
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 20, right: 20),
                                              child: Text(
                                                partner.name!,
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 20, right: 20),
                                              child: Text(
                                                partner.qual!,
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 5,
                                      thickness: 1,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                  const Padding(
                                    padding: EdgeInsets.only(left: 175, top: 5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            surfaceTintColor: Colors.white,
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            color: ColorsApp.card,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            elevation: 4,
                            child: Center(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 20, right: 20),
                                            child: Text(
                                              "Logradouro: ${controller.state!.publicPlace!}",
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 20, right: 20),
                                            child: Text(
                                              "Número: ${controller.state!.number!}",
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 20, right: 20),
                                            child: Text(
                                              "Complemento: ${controller.state!.complement!}",
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 20, right: 20),
                                            child: Text(
                                              "CEP: ${controller.state!.cep!}",
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 20, right: 20),
                                            child: Text(
                                              "Bairro: ${controller.state!.neighborhood!}",
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 20, right: 20),
                                            child: Text(
                                              "Cidade: ${controller.state!.county!}",
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 20, right: 20),
                                            child: Text(
                                              "Estado: ${controller.state!.uf!}",
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            surfaceTintColor: Colors.white,
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            elevation: 0,
                            child: Center(
                              child: Column(
                                children: [
                                  Card(
                                    surfaceTintColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      side: const BorderSide(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5,
                                                    left: 20,
                                                    right: 20),
                                                child: Text(
                                                  "Telefone",
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5,
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 5),
                                                child: Text(
                                                  controller.state!.phone!,
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                    surfaceTintColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      side: const BorderSide(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5,
                                                    left: 20,
                                                    right: 20),
                                                child: Text(
                                                  "Email",
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5,
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 5),
                                                child: Text(
                                                  controller.state!.email!,
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 175, top: 5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ])),
      ),
    );
  }
}
