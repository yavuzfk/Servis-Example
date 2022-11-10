import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:servis_deneme/model/info_model.dart';

abstract class INetworkService {
  Future<bool> addItemToService(InfoModel model);
  Future<bool> putItemToService(InfoModel model, int id);
  Future<bool> deleteItem(int id);
  Future<List<InfoModel>?> fetchItems();
}

class NetworkService implements INetworkService {
  final Dio _dio;
  NetworkService()
      : _dio =
            Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'));

  @override
  Future<bool> addItemToService(InfoModel model) async {
    try {
      final response = await _dio.post('posts', data: model);
      return response.statusCode == HttpStatus.created;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  @override
  Future<bool> deleteItem(int id) async {
    try {
      final response = await _dio
          .delete('${_NetworkQueryPaths.postId.name}/${id.toString()}');
      return response.statusCode == HttpStatus.accepted;
    } catch (e) {
      print(e);
    }
    return false;
  }

  @override
  Future<List<InfoModel>?> fetchItems() async {
    try {
      final response = await _dio.get(_NetworkServicePaths.posts.name);
      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;
        if (datas is List) {
          return datas.map((e) => InfoModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<bool> putItemToService(InfoModel model, int id) async {
    try {
      final response = await _dio.put(
          '${_NetworkQueryPaths.postId.name}/${id.toString()}',
          data: model);
      return response.statusCode == HttpStatus.accepted;
    } catch (e) {
      print(e);
    }
    return false;
  }
}

enum _NetworkServicePaths { posts }

enum _NetworkQueryPaths { postId }
