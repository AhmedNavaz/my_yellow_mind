import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_yellow_mind/modules/cbt/models/cbtsessionModel.dart';
import 'package:provider/provider.dart';

import '../../../constants/routeNames.dart';
import '../../../constants/style.dart';
import '../../meditation/provider/meditationProvider.dart';

Column liveSessionTile(context, SpCBTSessionDtos data, bool joinButton) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Starts At: ${data.startAt!}',
            style: customTextStyle(
              9,
              FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          Text(
            'Ends At: ${data.endAt!}',
            style: customTextStyle(
              9,
              FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8), BlendMode.dstATop),
                    image: NetworkImage(
                        Provider.of<MeditationProvider>(context).imagePath! +
                            data.fileName!),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.75),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${data.targetParticipants! - data.participants!} seats left',
                          style: customTextStyle(10, FontWeight.w500,
                              color: Colors.white)),
                      Center(
                          child:
                              SvgPicture.asset('assets/icons/play-button.svg')),
                      Text(
                        data.title!,
                        style: customTextStyle(11, FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text('${data.participants} joined',
                  style: customTextStyle(10, FontWeight.w300))
            ],
          ),
          const Spacer(),
          joinButton
              ? liveSessionAction(context, 'Join', data)
              : const SizedBox.shrink(),
          liveSessionAction(context, 'Skip', data),
        ],
      ),
      const SizedBox(height: 10),
      Divider(
        color: Colors.grey.withOpacity(0.5),
        thickness: 1,
        indent: 150,
        endIndent: 150,
      ),
      const SizedBox(height: 10),
    ],
  );
}

GestureDetector liveSessionAction(
    BuildContext context, String title, SpCBTSessionDtos liveSession) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, LiveSessionRoute,
          arguments: liveSession.toJson());
    },
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ]),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xff600000)),
      ),
    ),
  );
}
