import 'package:client_app/constant/app_colors.dart';
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
        elevation: 0,
        title: const Text("Select Currency"),
        backgroundColor: AppColor.themeColor,
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
                  controller.updateFilteredCurrencies(value);
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child:Obx(() =>  ListView.builder(
                    itemCount:controller.filteredCurrencies.isEmpty? controller.currencies.length:controller.filteredCurrencies.length,
                    itemBuilder: (context, index) {
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.symmetric(vertical: 6.0),
                        child: InkWell(
                          onTap: () {
                            if(controller.filteredCurrencies.isEmpty){
                              controller.updateSelectedCurrency(controller.currencies[index].shortName);
                            }else{
                              controller.updateSelectedCurrency(controller.filteredCurrencies[index].shortName);
                            }
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
                            controller.filteredCurrencies.isEmpty?"https://www.countryflagicons.com/SHINY/64/${controller.currencies[index].shortName.substring(0, 2)}.png":"https://www.countryflagicons.com/SHINY/64/${controller.filteredCurrencies[index].shortName.substring(0, 2)}.png",
                                  width: 30,
                                  height: 30,
                                  errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                      size: 20,
                                      Icons.currency_exchange_sharp),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    controller.filteredCurrencies.isEmpty?controller.currencies[index].name:controller.filteredCurrencies[index].name,
                                    style: AppTextStyle.textStyleBold14,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 0,
                                  child: Text(
                                      controller.filteredCurrencies.isEmpty?controller.currencies[index].shortName:controller.filteredCurrencies[index].shortName,
                                      style: AppTextStyle.textStyleBold14
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}