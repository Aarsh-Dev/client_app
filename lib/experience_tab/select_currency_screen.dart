import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/controller/currency_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCurrencyScreen extends StatefulWidget {
  const SelectCurrencyScreen({super.key});

  static const String route = 'select-currency';

  @override
  State<SelectCurrencyScreen> createState() => _SelectCurrencyScreenState();
}

class _SelectCurrencyScreenState extends State<SelectCurrencyScreen> {


  CurrencyController controller = Get.find();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select currency'),
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Column(
            children: [
              SearchBar(
                elevation: const MaterialStatePropertyAll(1),
                leading: const Icon(Icons.search),
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 10.0),
                ),
                hintText: 'Search currency',
                onChanged: (value) {
                  // Provider.of<CurrencyDataProvider>(context, listen: false)
                  //     .updateFilteredCurrencies(value);
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: controller.currencies.length,
                    itemBuilder: (context, index) {
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.symmetric(vertical: 6.0),
                        child: InkWell(
                          onTap: () {
                            controller.updateSelectedCurrency(controller.currencies[index].shortName);
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 8.0,
                            ),
                            child: Row(
                              children: [
                                Image.network(
                                  "https://www.countryflagicons.com/SHINY/64/${controller.currencies[index].shortName.substring(0, 2)}.png",
                                  width: 30,
                                  height: 30,
                                  errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                      size: 30,
                                      Icons.currency_exchange_sharp),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Text(
                                    controller.currencies[index].name,
                                    style: AppTextStyle.textStyleBold12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Flexible(
                                  child: Text(
                                    controller.currencies[index].shortName,
                                    style: AppTextStyle.textStyleBold12
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}