import 'package:casa/app/core/utils/app_strings.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/components/custom_button.dart';
import 'package:casa/features/language/provider/language_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../app/localization/localization/language_constant.dart';
import '../../app/localization/provider/localization_provider.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context, listen: false)
        .initializeAllLanguages();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated("language", context),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) => Expanded(
                        child: Scrollbar(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Center(
                          child: SizedBox(
                            width: 1170,
                            child: ListView.builder(
                                itemCount: languageProvider.languages.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        Provider.of<LocalizationProvider>(
                                                context,
                                                listen: false)
                                            .setLanguage(Locale(
                                          AppStrings
                                              .languages[
                                                  languageProvider.selectIndex]
                                              .languageCode!,
                                          AppStrings
                                              .languages[
                                                  languageProvider.selectIndex]
                                              .countryCode,
                                        ));
                                      },
                                      child: _languageWidget(
                                          context: context,
                                          languageModel:
                                              languageProvider.languages[index],
                                          index: index),
                                    )),
                          ),
                        ),
                      ),
                    ))),
            Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) => Center(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20),
                        child: CustomButton(
                          text: getTranslated('save', context),
                          onTap: () {
                            Navigator.pop(context);
                            Provider.of<LocalizationProvider>(context,
                                    listen: false)
                                .setLanguage(Locale(
                              AppStrings.languages[languageProvider.selectIndex]
                                  .languageCode!,
                              AppStrings.languages[languageProvider.selectIndex]
                                  .countryCode,
                            ));
                          },
                        ),
                      ),
                    )),
            Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) => Center(
                      child: SafeArea(
                        bottom: true,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            height: 0.06.h,
                            width: 0.9.h,
                            padding: EdgeInsets.symmetric(horizontal: 0.05.h),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                  elevation: 5,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  getTranslated('save', context),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Provider.of<LocalizationProvider>(context,
                                          listen: false)
                                      .setLanguage(Locale(
                                    AppStrings
                                        .languages[languageProvider.selectIndex]
                                        .languageCode!,
                                    AppStrings
                                        .languages[languageProvider.selectIndex]
                                        .countryCode,
                                  ));
                                }),
                          ),
                        ),
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  Widget _languageWidget(
      {required BuildContext context,
      required LanguageModel languageModel,
      required int index}) {
    LanguageProvider languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          languageProvider.setSelectIndex(index);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: languageProvider.selectIndex == index
                ? Theme.of(context).primaryColor.withOpacity(.15)
                : null,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 30),
                    Text(
                      languageModel.languageName!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                  ],
                ),
                languageProvider.selectIndex == index
                    ? Icon(Icons.done, color: Theme.of(context).primaryColor)
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
