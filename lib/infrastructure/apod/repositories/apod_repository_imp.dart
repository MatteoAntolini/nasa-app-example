import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:nasa/domain/apod/entities/apod.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa/domain/apod/repositories/apod_repository.dart';
import 'package:nasa/errors/failures.dart';
import 'package:nasa/infrastructure/apod/models/apod_model.dart';
import 'package:nasa/network/network_info.dart';
import 'package:nasa/util/enviroment/enviroment.dart';
import 'package:http/http.dart';

class ApodRepositoryImp extends ApodRepository {
  final NetworkInfo? networkInfo;

  ApodRepositoryImp({required this.networkInfo});

  @override
  Future<Either<Failure, List<Apod>>> getApods(
      {required String start, required String end}) async {
    if (await networkInfo!.result != ConnectivityResult.none) {
      try {
        final response = await get(Uri.parse(
            "https://api.nasa.gov/planetary/apod?start_date=$start&end_date=$end&api_key=$NASA_API_KEY"));

        List data = json.decode(response.body);

        List<Apod> apods = [];

        data.forEach((element) {
          if (element["hdurl"] != null) {
            apods.add(ApodModel.fromMap(element));
          }
        });

        return Right(apods);
      } catch (e) {
        return Left(ApodsFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Apod>> getApod({String? date}) async {
    if (await networkInfo!.result != ConnectivityResult.none) {
      try {
        final response = await get(Uri.parse(
            "https://api.nasa.gov/planetary/apod?date=$date&api_key=$NASA_API_KEY"));

        Map data = json.decode(response.body);

        if (data["hdurl"] != null) {
          return Right(ApodModel.fromMap(data as Map<String, dynamic>));
        } else {
          return Left(ApodFailure());
        }
      } catch (e) {
        return Left(ApodFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Apod>>> getFavorites({List? dates}) async {
    if (await networkInfo!.result != ConnectivityResult.none) {
      try {
        List<Apod> apods = [];

        List<Future> promises = [];

        dates!.forEach((date) async {
          promises.add(get(Uri.parse(
              "https://api.nasa.gov/planetary/apod?date=$date&api_key=$NASA_API_KEY")));
        });

        await Future.wait(promises).then((values) => values.forEach((response) {
              Map data = json.decode(response.body);
              if (data["hdurl"] != null) {
                apods.add(ApodModel.fromMap(data as Map<String, dynamic>));
              }
            }));

        return Right(apods);
      } catch (e) {
        return Left(ApodsFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
