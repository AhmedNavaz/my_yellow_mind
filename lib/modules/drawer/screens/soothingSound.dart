import 'package:flutter/material.dart';
import 'package:my_yellow_mind/modules/drawer/widgets/soothingSoundWidget.dart';
import 'package:provider/provider.dart';

import '../../../constants/routeNames.dart';
import '../../../constants/style.dart';
import '../../authentication/provider/authProvider.dart';
import '../models/soothingSoundModel.dart';
import '../providers/soothingSoundProvider.dart';

class SoothingSoundScreen extends StatefulWidget {
  const SoothingSoundScreen({super.key});

  @override
  State<SoothingSoundScreen> createState() => _SoothingSoundScreenState();
}

class _SoothingSoundScreenState extends State<SoothingSoundScreen> {
  Future<SoothingSoundModel> getScreenData() async {
    String token =
        Provider.of<AuthProvider>(context, listen: false).localUser.token!;
    return await Provider.of<SoothingSoundProvider>(context, listen: false)
        .getData(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Soothing Sound',
          style: customTextStyle(17, FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder(
          future: getScreenData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('What will you listen today?',
                          style: customTextStyle(16, FontWeight.w500)),
                    ),
                    const SizedBox(height: 20),
                    Consumer<SoothingSoundProvider>(
                        builder: (context, soothingSoundProvider, child) {
                      return Column(
                        children: [
                          for (int i = 0;
                              i < soothingSoundProvider.soothingSounds.length;
                              i++)
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, MediaPlayerRoute,
                                    arguments: soothingSoundProvider
                                        .soothingSounds[i]
                                        .toJson());
                              },
                              child: soundTile(
                                  soothingSoundProvider
                                      .soothingSounds[i].title!,
                                  soothingSoundProvider
                                      .soothingSounds[i].duration!,
                                  soothingSoundProvider.imagePath +
                                      soothingSoundProvider
                                          .soothingSounds[i].imageFile!),
                            )
                        ],
                      );
                    }),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Text(
                          'Favorites',
                          style: customTextStyle(15, FontWeight.w500),
                        ),
                        const Spacer(),
                        const Icon(Icons.favorite, color: Colors.red),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Consumer<SoothingSoundProvider>(
                        builder: (context, soothingSoundProvider, child) {
                      return Column(
                        children: [
                          for (int i = 0;
                              i < soothingSoundProvider.userFavorites.length;
                              i++)
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, MediaPlayerRoute,
                                    arguments: soothingSoundProvider
                                        .userFavorites[i]
                                        .toJson());
                              },
                              child: soundTile(
                                  soothingSoundProvider.userFavorites[i].title!,
                                  soothingSoundProvider
                                      .userFavorites[i].duration!,
                                  soothingSoundProvider.imagePath +
                                      soothingSoundProvider
                                          .userFavorites[i].imageFile!),
                            )
                        ],
                      );
                    }),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
