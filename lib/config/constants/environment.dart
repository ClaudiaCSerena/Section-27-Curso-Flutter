import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static initEnvironment() async {
    await dotenv.load(fileName: ".env"); //lo pongo aquí (y no en el main) para dejar todo centralizado aquí
  } 

  static String apiUrl =
      dotenv.env['API_URL'] ?? 'No está configurado el API_URL';
}
