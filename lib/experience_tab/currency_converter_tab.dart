

import 'package:client_app/controller/currency_controller.dart';
import 'package:client_app/experience_tab/select_currency_screen.dart';
import 'package:client_app/widget/currency_data_input_form.dart';
import 'package:client_app/widget/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyTab extends StatefulWidget {
  static const String route = '/';

  const CurrencyTab({super.key});

  @override
  State<CurrencyTab> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CurrencyTab> {

  CurrencyController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.getCurrencies();
    controller.getUSDToAnyExchangeRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 30.0),
          color: Colors.white,
          child: Center(
            child: Obx(()=>
            controller.isCurrencyLoading.value || controller.isExchangeRateLoading.value? const CustomLoader():Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  elevation: 3.0,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CurrencyDataInputForm(
                          title: 'Amount',
                          isInputEnabled: true,
                          textEditingController: controller.selectedFromTextEditController,
                          selectedCurrency: controller.selectedFromCurrency.value,
                          onCurrencySelection: () {
                            controller.updatingCurrencyType.value="From";

                            Get.to(const SelectCurrencyScreen());
                          },
                          onInputChanged: (val) {
                            controller.amount.value = val;
                            controller.selectedToTextEditController.text= controller.convertAnyToAny(
                                controller.amount.value,
                                controller.selectedFromCurrency.value,
                                controller.selectedToCurrency.value);
                            setState(() {

                            });
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1.0,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            IconButton.filled(
                              onPressed: () {
                                controller.swapFromAndTo();
                              },
                              icon: const Icon(Icons.swap_vert),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1.0,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),
                        CurrencyDataInputForm(
                          title: 'Converted Amount',
                          // val: controller.convertAnyToAny(
                          //     controller.amount.value,
                          //     controller.selectedFromCurrency.value,
                          //     controller.selectedToCurrency.value),
                          textEditingController:controller.selectedToTextEditController,
                          isInputEnabled: false,
                          selectedCurrency: controller.selectedToCurrency.value,
                          onCurrencySelection: () {
                            controller.updatingCurrencyType.value="To";

                            Get.to(const SelectCurrencyScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ))
          ),
        ),
      ),
    );
  }


}