import 'package:mocktail/mocktail.dart';
import 'package:nawytask/core/network/network_info.dart';
import 'package:nawytask/core/network/network_manager.dart';
import 'package:nawytask/features/search/data/datasource/search_remote_datasource.dart';

// for checking the internet connectivity
class MockNetworkInfo extends Mock implements NetworkInfo {}

// mocking network connection
class MockNetworkManager extends Mock implements NetworkManager {}

// mocking repo
class MockSearchRemoteDataSource extends Mock implements SearchRemoteDataSource {}
