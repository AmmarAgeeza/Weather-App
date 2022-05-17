import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  static Future<int> getCityId({required String cityName}) async {
    String baseUrl = 'https://www.metaweather.com';
    final url = Uri.parse('$baseUrl/api/location/search/?query=$cityName');
    final response = await http.get(url);
    List data = json.decode(response.body);
    int id = data[0]['woeid'];
    print(id);
    return id;
  }

  static Future<WeatherModel> getWeather({required String cityName}) async {
    int id = await getCityId(cityName: cityName);
    String baseUrl = 'https://www.metaweather.com';
    final url = Uri.parse('$baseUrl/api/location/$id/');
    final response = await http.get(url);
    Map<String, dynamic> jsonData = json.decode(response.body);
    //print(data);
    Map<String, dynamic> data = jsonData['consolidated_weather'][0];
    WeatherModel weatherModel = WeatherModel.fromjson(data);
    print(weatherModel);
    return weatherModel;
  }
}
