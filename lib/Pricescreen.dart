import 'package:flutter/material.dart';
import 'package:bitcoin/coindata.dart';

CoinData coin = CoinData();

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  Map<String, double>? cryptoRates;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdownItems.add(item);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      onChanged: (String? newValue) {
        setState(() {
          selectedCurrency = newValue!;
          fetchData();
        });
      },
      items: dropdownItems,
    );
  }

  void fetchData() async {
    var data = await coin.getdata(selectedCurrency);
    setState(() {
      cryptoRates = {
        'BTC': data['BTC'],
        'ETH': data['ETH'],
        'LTC': data['LTC'],
      };
    });
  }

  Widget buildCryptoCard(String crypto) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            "1 $crypto = ${cryptoRates?[crypto]?.toStringAsFixed(2) ?? '...'} $selectedCurrency",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildCryptoCard('BTC'),
              buildCryptoCard('ETH'),
              buildCryptoCard('LTC'),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getDropdownButton(),
          ),
        ],
      ),
    );
  }
}
