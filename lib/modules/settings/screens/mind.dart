import 'package:flutter/material.dart';
import 'package:my_yellow_mind/modules/settings/models/mindCategoryModel.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

import '../../../constants/routeNames.dart';
import '../../../constants/style.dart';
import '../../authentication/provider/authProvider.dart';
import '../../questions/providers/questionProvider.dart';
import '../../questions/widgets/questionWidgets.dart';
import '../provider/categoriesProvider.dart';

class MindSettingsScreen extends StatefulWidget {
  const MindSettingsScreen({super.key});

  @override
  State<MindSettingsScreen> createState() => _MindSettingsScreenState();
}

class _MindSettingsScreenState extends State<MindSettingsScreen> {
  Future<MindCategoriesModel> getScreenData() async {
    String token =
        Provider.of<AuthProvider>(context, listen: false).localUser.token!;
    MindCategoriesModel some =
        await Provider.of<CategoriesProvider>(context, listen: false)
            .getData(token);
    selectedInterests = List.filled(
        Provider.of<CategoriesProvider>(context, listen: false)
            .categories
            .length,
        false);
    setState(() {
      isLoading = false;
    });
    return some;
  }

  List<String>? selectedCategories;
  List<bool>? selectedInterests;
  bool isLoading = true;

  @override
  void initState() {
    getScreenData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Mind',
          style: customTextStyle(16, FontWeight.w500),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : LayoutBuilder(builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          header('Change your mind category', ''),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 5,
                            children: [
                              for (var index = 0;
                                  index <
                                      Provider.of<CategoriesProvider>(context)
                                          .categories
                                          .length;
                                  index++)
                                GestureDetector(
                                  onTap: () {
                                    selectedCategories = [];
                                    setState(() {
                                      selectedInterests![index] =
                                          !selectedInterests![index];
                                    });
                                    for (int i = 0;
                                        i < selectedInterests!.length;
                                        i++) {
                                      if (selectedInterests![i]) {
                                        selectedCategories?.add(
                                            Provider.of<CategoriesProvider>(
                                                    context,
                                                    listen: false)
                                                .categories[i]
                                                .name!);
                                      }
                                    }
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Card(
                                      color: selectedInterests![index]
                                          ? const Color(0xff970000)
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 20),
                                        child: Text(
                                            Provider.of<CategoriesProvider>(
                                                    context)
                                                .categories[index]
                                                .name!,
                                            style: customTextStyle(
                                                14, FontWeight.w500,
                                                color: selectedInterests![index]
                                                    ? Colors.white
                                                    : Colors.black)),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Spacer(),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (selectedCategories!.isEmpty ||
                                    selectedCategories!.length > 3) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Select between 1-3 categories!'),
                                    ),
                                  );
                                  return;
                                }
                                UIBlock.block(context);
                                String token = Provider.of<AuthProvider>(
                                        context,
                                        listen: false)
                                    .localUser
                                    .token!;
                                Provider.of<QuestionProvider>(context,
                                        listen: false)
                                    .addUserCategories(
                                        token, selectedCategories!.toString())
                                    .then((value) {
                                  if (value) {
                                    UIBlock.unblock(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Categories changed successfully!'),
                                      ),
                                    );
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        HomeScreenRoute, (route) => false);
                                  } else {
                                    UIBlock.unblock(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Something went wrong'),
                                      ),
                                    );
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Save',
                                style: customTextStyle(15, FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
    );
  }
}
