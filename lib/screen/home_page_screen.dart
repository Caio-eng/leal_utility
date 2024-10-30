import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leal_utility/screen/tabs/sorteio_tab.dart';

import '../components/custom_Input_decoration.dart';
import '../components/custom_app_tab_view.dart';
import '../components/custom_snack_bar.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppTabView(
      title: 'Sorteio de Números',
      tabs: const [
        Tab(icon: Icon(Icons.cached_rounded), text: 'Sorteio'),
        Tab(icon: Icon(Icons.camera_alt), text: 'Status'),
        Tab(icon: Icon(Icons.call), text: 'Chamadas'),
      ],
      tabViews: const [
        SorteioTab(),
        StatusTab(),
        ChamadasTab(),
      ],
    );
  }
}

class StatusTab extends StatelessWidget {
  const StatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text("Status")
    );
  }
}

class ChamadasTab extends StatelessWidget {
  const ChamadasTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Chamadas"));
  }
}