import 'package:client_app/constant/app_text_style.dart';
import 'package:client_app/controller/currency_controller.dart';
import 'package:client_app/widget/custom_loader.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widgetTitle(text:"Amount"),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            widgetCurrencyTypeDropDown(),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: TextFormField(
                                  controller: controller.selectedFromTextEditController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 0),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                  onChanged:(value){
                                    if(controller.selectedFromCurrency.value == "IDR"){
                                      controller.inrTextEditController.text= controller.convertAnyToAny(
                                          value,
                                          controller.selectedFromTextEditController.text,
                                          "INR");
                                      controller.usdTextEditController.text= controller.convertAnyToAny(
                                          value,
                                          controller.selectedFromTextEditController.text,
                                          "USD");
                                      setState(() {

                                      });
                                    }else if(controller.selectedFromCurrency.value == "INR"){
                                      controller.idrTextEditController.text= controller.convertAnyToAny(
                                          value,
                                          controller.selectedFromTextEditController.text,
                                          "IDR");
                                      controller.idrTextEditController.text= controller.convertAnyToAny(
                                          value,
                                          controller.selectedFromTextEditController.text,
                                          "USD");
                                      setState(() {

                                      });

                                    }else if(controller.selectedFromCurrency.value == "USD"){
                                      controller.idrTextEditController.text= controller.convertAnyToAny(
                                          value,
                                          controller.selectedFromTextEditController.text,
                                          "IDR");
                                      controller.inrTextEditController.text= controller.convertAnyToAny(
                                          value,
                                          controller.selectedFromTextEditController.text,
                                          "INR");
                                      setState(() {

                                      });
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        // CurrencyDataInputForm(
                        //   title: 'Amount',
                        //   isInputEnabled: true,
                        //   textEditingController: controller.selectedFromTextEditController,
                        //   selectedCurrency: controller.selectedFromCurrency.value,
                        //   onCurrencySelection: () {
                        //     controller.updatingCurrencyType.value="From";
                        //
                        //     Get.to(const SelectCurrencyScreen());
                        //   },
                        //   onInputChanged: (val) {
                        //     controller.amount.value = val;
                        //     controller.selectedToTextEditController.text= controller.convertAnyToAny(
                        //         controller.amount.value,
                        //         controller.selectedFromCurrency.value,
                        //         controller.selectedToCurrency.value);
                        //     setState(() {
                        //
                        //     });
                        //   },
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Divider(
                        //         thickness: 1.0,
                        //         color: Colors.grey.shade300,
                        //       ),
                        //     ),
                        //     // const SizedBox(
                        //     //   width: 10.0,
                        //     // ),
                        //     // IconButton.filled(
                        //     //   onPressed: () {
                        //         controller.swapFromAndTo();
                        //     //     controller.selectedFromTextEditController.clear();
                        //     //     controller.selectedToTextEditController.clear();
                        //     //   },
                        //     //   icon: const Icon(Icons.swap_vert),
                        //     // ),
                        //     // const SizedBox(
                        //     //   width: 10.0,
                        //     // ),
                        //     Expanded(
                        //       child: Divider(
                        //         thickness: 1.0,
                        //         color: Colors.grey.shade300,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Divider(
                          thickness: 1.0,
                          color: Colors.grey.shade300,
                        ),
                        widgetTitle(text:"Converted Amount"),
                        const SizedBox(
                          height: 10.0,
                        ),
                        if(controller.selectedFromCurrency.value == "IDR")...[
                          widgetConvertCurrency(
                              currencyType: "INR",
                              textEditingController:controller.inrTextEditController
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          widgetConvertCurrency(
                              currencyType: "USD",
                              textEditingController:controller.usdTextEditController
                          ),
                        ]else if(controller.selectedFromCurrency.value == "INR")...[
                          widgetConvertCurrency(
                              currencyType: "IDR",
                              textEditingController:controller.idrTextEditController
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          widgetConvertCurrency(
                              currencyType: "USD",
                              textEditingController:controller.usdTextEditController
                          ),

                        ]else if(controller.selectedFromCurrency.value == "USD")...[
                          widgetConvertCurrency(
                              currencyType: "IDR",
                              textEditingController:controller.idrTextEditController
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          widgetConvertCurrency(
                              currencyType: "INR",
                              textEditingController:controller.inrTextEditController
                          ),

                        ],
                        // CurrencyDataInputForm(
                        //   title: 'Converted Amount',
                        //   // val: controller.convertAnyToAny(
                        //   //     controller.amount.value,
                        //   //     controller.selectedFromCurrency.value,
                        //   //     controller.selectedToCurrency.value),
                        //   textEditingController:controller.selectedToTextEditController,
                        //   isInputEnabled: false,
                        //   selectedCurrency: controller.selectedToCurrency.value,
                        //   onCurrencySelection: () {
                        //     controller.updatingCurrencyType.value="To";
                        //
                        //     Get.to(const SelectCurrencyScreen());
                        //   },
                        // ),
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


  Widget widgetTitle({text}){
    return Text(
      "$text",
      style: const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
    );
  }

  Widget widgetConvertCurrency({currencyType,TextEditingController?textEditingController}){
    return  Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      child: Row(
        children: [
          Container(
             constraints: const BoxConstraints(minWidth:65, maxHeight: 35),
              child: Center(child: Text(currencyType,style:AppTextStyle.textStyleRegular12))),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextFormField(
              controller:textEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 0),
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              onChanged:(value){

              },
            ),
          )
        ],
      ),
    );
  }



  Widget widgetCurrencyTypeDropDown(){
    return DropdownButtonFormField2(
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          constraints: BoxConstraints(maxWidth:70, maxHeight: 35)),
      isExpanded: true,
      hint: Text(
       controller.selectedFromCurrency.value,
        style: AppTextStyle.textStyleRegular14,
      ),
      items: controller.currencyTypeList
          .map((value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value,
          style: AppTextStyle.textStyleRegular12,
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select city.';
        }
        return null;
      },
      onChanged: (newValue) {
        controller.selectedFromCurrency.value = newValue!;
      },
      menuItemStyleData: const MenuItemStyleData(
        height: 35,
      ),
      buttonStyleData: ButtonStyleData(
        height: 50,
        width: Get.width,
        padding: const EdgeInsets.only(left: 16),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Colors.black,
        ),
        iconSize: 22,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 500,
        useSafeArea: true,
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }




}