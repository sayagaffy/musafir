import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class UlasanCard extends StatelessWidget {
  const UlasanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 18,
            bottom: 11,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 31,
                    width: 31,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/image_destination1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Dewantara',
                    style: blackTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star_outline_rounded,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.star_outline_rounded,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.star_outline_rounded,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.star_outline_rounded,
                  size: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  '1 minggu lalu',
                  style: blackTextStyle.copyWith(fontSize: 11),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                'restonya mudah diakses menggunakan mobil. Untuk harganya lumayan terjangkau dan bisa dinikmati oleh keluarga. cocok untuk liburan akhir tahun.',
                style: blackTextStyle.copyWith(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const Divider(
              height: 1,
              color: Color(0xFFD9D9D9),
            ),
          ],
        ),
      ],
    );
  }
}
