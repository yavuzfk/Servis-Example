import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:servis_deneme/model/info_model.dart';
import 'package:servis_deneme/view/widgets/model_info_card.dart';
import 'package:servis_deneme/viewmodel/network_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<InfoModel>? _items;
  bool isLoading = false;
  late final INetworkService networkService;

  @override
  void initState() {
    networkService = NetworkService();

    super.initState();
    fetchItems();
  }

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> fetchItems() async {
    _changeLoading();
    _items = await networkService.fetchItems();
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servis Example"),
        actions: [
          isLoading
              ? const CircularProgressIndicator.adaptive()
              : const SizedBox.shrink()
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _items?.length ?? 0,
          itemBuilder: (context, index) {
            return ModelInfoCard(model: _items![index]);
          },
        ),
      ),
    );
  }
}
