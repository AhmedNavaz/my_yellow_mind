import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';
import 'package:provider/provider.dart';

import '../../../constants/style.dart';
import '../../../widgets/drawer.dart';
import '../../authentication/provider/authProvider.dart';
import '../models/sleepModel.dart';
import '../providers/sleepProvider.dart';
import '../widgets/sleepWidgets.dart';

class SleepHomeScreen extends StatefulWidget {
  const SleepHomeScreen({super.key});

  @override
  State<SleepHomeScreen> createState() => _SleepHomeScreenState();
}

class _SleepHomeScreenState extends State<SleepHomeScreen> {
  Future<SleepModel> getScreenData() async {
    String token =
        Provider.of<AuthProvider>(context, listen: false).localUser.token!;
    return await Provider.of<SleepProvider>(context, listen: false)
        .getData(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sleep',
          style: customTextStyle(17, FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: drawer(context),
      body: FutureBuilder(
          future: getScreenData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Categories',
                    style: customTextStyle(15, FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 20),
                Consumer<SleepProvider>(
                    builder: (context, sleepProvider, child) {
                  return Container(
                    height: 220,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sleepProvider.sleepCategories.length + 1,
                        itemBuilder: ((context, index) {
                          return index == sleepProvider.sleepCategories.length
                              ? const SizedBox(width: 25)
                              : sleepCategoryBox(context,
                                  sleepProvider.sleepCategories[index]);
                        })),
                  );
                }),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text(
                        'Suggested Music',
                        style: customTextStyle(15, FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      Consumer<SleepProvider>(
                          builder: (context, sleepMusicProvider, child) {
                        return Column(
                          children: [
                            for (int i = 0;
                                i < sleepMusicProvider.sleepAudios.length;
                                i++)
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, MediaPlayerRoute,
                                          arguments: sleepMusicProvider
                                              .sleepAudios[i]
                                              .toJson())
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: playerTile(
                                    sleepMusicProvider.sleepAudios[i].title!,
                                    sleepMusicProvider
                                            .sleepAudios[i].duration ??
                                        0,
                                    sleepMusicProvider
                                            .sleepAudios[i].noOfWatch ??
                                        0,
                                    Provider.of<SleepProvider>(context,
                                                listen: false)
                                            .imagePath! +
                                        sleepMusicProvider
                                            .sleepAudios[i].imageFile!),
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
                      Consumer<SleepProvider>(
                          builder: (context, sleepMusicProvider, child) {
                        return Column(
                          children: [
                            for (int i = 0;
                                i < sleepMusicProvider.userFavorites.length;
                                i++)
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, MediaPlayerRoute,
                                      arguments: sleepMusicProvider
                                          .sleepAudios[i]
                                          .toJson());
                                },
                                child: playerTile(
                                    sleepMusicProvider.userFavorites[i].title!,
                                    sleepMusicProvider
                                            .userFavorites[i].duration ??
                                        0,
                                    sleepMusicProvider
                                            .userFavorites[i].noOfWatch ??
                                        0,
                                    Provider.of<SleepProvider>(context)
                                            .imagePath! +
                                        sleepMusicProvider
                                            .userFavorites[i].imageFile!),
                              )
                          ],
                        );
                      }),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ));
          }),
    );
  }
}
