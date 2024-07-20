import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
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
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const kAPIkey = 'INSERT YOUR API KEY HERE';

class CoinData {
  //3. Create the Asynchronous method getCoinData() that returns a Future (the price data).
  // Future getCoinData() async {
  //   //4. Create a url combining the coinAPIURL with the currencies we're interested, BTC to USD.
  //   String requestURL = '$coinAPIURL/BTC/USD?apikey=$kAPIkey';
  //   //5. Make a GET request to the URL and wait for the response.
  //   http.Response response = await http.get(Uri.https(requestURL));
  //
  //   //6. Check that the request was successful.
  //   if (response.statusCode == 200) {
  //     //7. Use the 'dart:convert' package to decode the JSON data that comes back from coinapi.io.
  //     var decodedData = jsonDecode(response.body);
  //     //8. Get the last price of bitcoin with the key 'last'.
  //     var lastPrice = decodedData['rate'];
  //     //9. Output the lastPrice from the method.
  //     return lastPrice;
  //   } else {
  //     //10. Handle any errors that occur during the request.
  //     print(response.statusCode);
  //     //Optional: throw an error if our request fails.
  //     throw 'Problem with the get request';
  //   }
  // }
  Future<dynamic> getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String baseUrl =
          '$coinAPIURL/$crypto/$selectedCurrency'; // Replace :asset_id_base with the desired asset identifier
      String apiKey =
          'EF62AF66-2BA5-4B0D-8891-2C0AB5DDAD29'; // Replace YOUR_API_KEY with your actual CoinApi API key

      var response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Accept': 'application/json',
          'X-CoinAPI-Key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var rates = data['rate'].round();
        //Create a new key value pair, with the key being the crypto symbol and the value being the lastPrice of that crypto currency.
        cryptoPrices[crypto] = rates.toString();
      } else {
        // Handle errors
        // print('Error: ${response.reasonPhrase}');
        return 0;
      }
    }
    return cryptoPrices;
  }
}
