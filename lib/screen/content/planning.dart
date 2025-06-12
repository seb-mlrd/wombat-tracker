// lib/screen/content/planning.dart

import 'package:flutter/material.dart';

// utils 
import 'package:wombat_tracker/utils/class/modules.dart';
import 'package:wombat_tracker/utils/network/modules_network.dart';

// widget 
import 'package:wombat_tracker/widget/planning/container_sticker_training.dart';
import 'package:wombat_tracker/widget/planning/title_training.dart';
import 'package:wombat_tracker/widget/banner/wombat_banner_screen.dart';

class Planning extends StatefulWidget {
  const Planning({super.key});

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  List plannings = [];
  List<Modules> modules = [];

  void initializeDataPlanning() async {
    final responseModule = await ModulesNetwork().loadModules();
    setState(() {
      modules = responseModule;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDataPlanning();
  }

  @override
  Widget build(BuildContext context) {
    if (modules.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                WombatBannerScreen(isLogoActive: true),
                TitleTraining(title: "Modules"),
                for (var module in modules)
                  ContainerStickerTraining(
                    titleTraining: module.titleModule,
                    timeTraining: [],
                    listTrain: [module.objectif, module.materiel],
                    id: module.id,
                  ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
