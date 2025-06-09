import 'package:flutter/material.dart';
import 'package:wombat_tracker/utils/class/sequences.dart';
import 'package:wombat_tracker/utils/network/sequences_network.dart';
import 'package:wombat_tracker/widget/planning/container_sticker_training.dart';
import 'package:wombat_tracker/widget/planning/title_training.dart';

class SequencesScreen extends StatefulWidget {
  final int idModule;
  final String timeTraining;
  const SequencesScreen({
    super.key,
    required this.idModule,
    required this.timeTraining,
  });

  @override
  State<SequencesScreen> createState() => _SequencesScreenState();
}

class _SequencesScreenState extends State<SequencesScreen> {
  List<Sequences> sequences = [];

  void initializeDataPlanning() async {
    final responseSequences = await SequencesNetwork().loadSequence(
      widget.idModule,
    );
    setState(() {
      sequences = responseSequences;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDataPlanning();
  }

  @override
  Widget build(BuildContext context) {
    if (sequences.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                TitleTraining(title: widget.timeTraining),
                for (var sequence in sequences)
                  ContainerStickerTraining(titleTraining: sequence.titleSequences, timeTraining: [
                    sequence.duration,
                    sequence.numberOfCircuit,
                  ], listTrain: sequence.descriptionSequences),
              ],
            ),
          ),
        ),
      );
    }
  }
}

