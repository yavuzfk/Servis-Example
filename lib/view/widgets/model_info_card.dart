import 'package:flutter/material.dart';
import 'package:servis_deneme/model/info_model.dart';

class ModelInfoCard extends StatelessWidget {
  const ModelInfoCard({
    Key? key,
    required InfoModel model,
  })  : _model = model,
        super(key: key);

  final InfoModel? _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(_model?.title ?? ''),
        subtitle: Text(_model?.body ?? ''),
      ),
    );
  }
}
