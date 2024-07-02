import 'dart:convert';
import 'package:http/http.dart';

const kapikey = "EA7F046C-F0E8-497F-970D-883BFE8C8296";
List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
  'IN'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<Map<String, dynamic>> getdata(String currency) async {
    Map<String, dynamic> cryptoRates = {};
    try {
      for (String crypto in cryptoList) {
        Response response = await get(
          Uri.parse(
              "https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$kapikey"),
        );
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          cryptoRates[crypto] = data['rate'];
        } else {
          throw "Failed to get rate for $crypto";
        }
      }
      return cryptoRates;
    } catch (e) {
      throw "ERROR GETTING PRICE WAIT FOR FEW SEC";
    }
  }
}