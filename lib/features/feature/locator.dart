import 'package:get_it/get_it.dart';
import 'package:hb_demo/features/feature/viewModel/file_picker_vm.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => FilePickVM());
}
