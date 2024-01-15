import 'package:busca_empresa/app/data/models/enterprise.dart';
import 'package:busca_empresa/app/data/provider/api.dart';

class EnterpriseRepository {
  final Api _api;

  EnterpriseRepository(this._api);

  Future<EnterpriseModel> getEnterprise(id) => _api.getClient(id);
}
