import 'package:flutter/material.dart';
import 'package:my_yellow_mind/modules/questions/providers/questionProvider.dart';
import 'package:provider/provider.dart';

import '../../../../constants/style.dart';
import '../../../authentication/provider/authProvider.dart';
import '../../../settings/models/mindCategoryModel.dart';
import '../../../settings/provider/categoriesProvider.dart';
import '../../widgets/questionWidgets.dart';

class InterestsQuestionScreen extends StatefulWidget {
  const InterestsQuestionScreen({super.key});

  @override
  State<InterestsQuestionScreen> createState() =>
      _InterestsQuestionScreenState();
}

class _InterestsQuestionScreenState extends State<InterestsQuestionScreen> {
  List<bool>? selectedInterests;
  bool isLoading = true;
  @override
  void initState() {
    getScreenData();
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(color: Colors.transparent))
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
                        header('What are you interested in?', ''),
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
                                  Provider.of<QuestionProvider>(context,
                                          listen: false)
                                      .empty();
                                  setState(() {
                                    selectedInterests![index] =
                                        !selectedInterests![index];
                                  });
                                  for (int i = 0;
                                      i < selectedInterests!.length;
                                      i++) {
                                    if (selectedInterests![i]) {
                                      Provider.of<QuestionProvider>(context,
                                              listen: false)
                                          .addCategory(
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
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
  }
}
