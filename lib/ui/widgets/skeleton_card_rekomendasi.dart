import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonCardRekomendasi extends StatelessWidget {
  final String type;
  const SkeletonCardRekomendasi({super.key, this.type = 'listView'});
  Widget cardContent() {
    return Container(
      width: 180,
      height: 206,
      margin: EdgeInsets.only(right: type == 'listView' ? 20 : 0),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(1.4, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 90,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/brandBlue.png'),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Halal Certified Certified',
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 1),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                          ),
                          Text(
                            '10 km',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 16,
                                ),
                                Text('Halal Certified'),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Skeletonizer(
        ignorePointers: false,
        child: type == 'listView'
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return cardContent();
                },
              )
            : GridView.builder(
                padding: const EdgeInsets.only(
                  left: 18,
                  top: 30,
                  right: 18,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 206,
                  mainAxisExtent: 206,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: 2,
                itemBuilder: (BuildContext ctx, index) {
                  return cardContent();
                },
              ),
      ),
    );
  }
}
