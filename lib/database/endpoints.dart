const String baseUrl = 'https://revenue.izagro.com.br';
const String urlPlans = 'https://consultores.izagro.com.br/';
const String viaCep = 'https://viacep.com.br';
const String urlEstimate = 'https://estimate.izagro.com.br';
// const String urlEstimate = 'http://25.63.157.58:8090';
//const String baseUrl = 'http://25.63.157.58:8080'; // Pedro
// const String baseUrl = 'http://25.63.157.58:8081'; // Pedro
//const String baseUrl = 'http://25.35.163.144:8080'; // Joao

abstract class Endpoints {
  static const String signin = '$baseUrl/auth';
  static const String signup = '$baseUrl/v1/user';
  static const String getAllCultures = '$baseUrl/v1/culture';
  static const String validateToken = '$baseUrl/v1/user/test/token';
  static const String recoverPassword = '$baseUrl/v1/user/retrieve-password';
  static const String getAllPlans = '$baseUrl/v1/level/all';
  static const String getUserPlan = '$baseUrl/v1/level-user';
  static const String getStatusLevel = '$baseUrl/v1/level/status';
  static const String cancelSignature = '$baseUrl/v1/payment/disable';
  static const String disableUser = '$baseUrl/v1/user/disablement';
  static const String saveEditedUser = '$baseUrl/v1/user';
  static const String sendContact = '$baseUrl/v1/mail';
  static const String uploadPhoto =
      '$baseUrl/v1/file/photo/path?pass=\$2a\$10\$v5mtzLkAc49uP5JNVBdB/e3evVje0gmLBxzdVM.vMV//xeKzCmLp.';
  static const String findAllQuestion =
      '$urlEstimate/v1/agronomist/results?agronomistId=';

  static const String getAnswerByQuestionId =
      '$urlEstimate/v1/agronomist/answer/';

  static const String sendAnswer = '$urlEstimate/v1/agronomist/answer/';
  static const String getCulture = '$baseUrl/v1/culture';
  static const String getProduct = '$baseUrl/v1/product';
  static const String getContamination = '$baseUrl/v1/contamination';
  static const String getNaturalEnemies = '$baseUrl/v1/scouting/enemy';
  static const String getProducers = '$baseUrl/v1/producer';
  static const String getFarms = '$baseUrl/v1/farm/byproducer';
  static const String getFields = '$baseUrl/v1/field';
  static const String getFieldMap = '$baseUrl/v1/fieldmap/coord';
  static const String saveProducer = '$baseUrl/v2/producer';
  static const String saveFarm = '$baseUrl/v1/farm';
  static const String saveField = '$baseUrl/v1/field';
  static const String saveFieldMap = '$baseUrl/v1/fieldmap';
  static const String deleteProducer = '$baseUrl/v1/producer';
  static const String deleteFarm = '$baseUrl/v1/farm';
  static const String deleteField = '$baseUrl/v1/field';
  static const String getAllAdvReport =
      '$baseUrl/v1/report-apsi/user-yourself/sync';

  static const String searchCep = '$viaCep/ws/';
}
