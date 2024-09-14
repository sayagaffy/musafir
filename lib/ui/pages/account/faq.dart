import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/shared/theme.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  Widget bigTitle() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'MUSAFIR',
            style: blackTextStyle.copyWith(
              fontWeight: bold,
              fontSize: 26,
              letterSpacing: 2.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget heading(title) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontWeight: bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionBox(title, content) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kNeutral20,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsetsDirectional.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title,
              style: blackTextStyle.copyWith(
                fontSize: 13,
                fontWeight: bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Divider(
            color: kNeutral40,
            height: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              content,
              style: blackTextStyle.copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionBoxCutom(title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kNeutral20,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsetsDirectional.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title,
              style: blackTextStyle.copyWith(
                fontSize: 13,
                fontWeight: bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Divider(
            color: kNeutral40,
            height: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status halal dalam aplikasi Musafir terdapat 2 jenis yaitu :',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        '•',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Halal Certified : ', // Teks pertama dengan gaya bold
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'yaitu restoran sudah bersertifikat halal melalui Lembaga/organisasi Halal secara resmi dinegara tersebut, berbahan makanan halal, dan tidak menjual minuman beralkohol.', // Teks kedua dengan gaya normal
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        '•',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Halal Certified : ', // Teks pertama dengan gaya bold
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'yaitu restoran yang belum memiliki sertifikat halal namun menggunakan bahan-bahan halal. Adapun jenis restoran Muslim Friendly mungkin saja masih menyajikan menu alkohol dan non halal lainnya.', // Teks kedua dengan gaya normal
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionUmum() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kNeutral20,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsetsDirectional.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Apa tujuan aplikasi ini?',
              style: blackTextStyle.copyWith(
                fontSize: 13,
                fontWeight: bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Divider(
            color: kNeutral40,
            height: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Aplikasi ini dirancang untuk mempermudah dan meningkatkan pengalaman perjalanan bagi wisatawan Muslim di seluruh dunia. Menyediakan fitur penting untuk merencanakan perjalanan, menemukan makanan halal, terhubung dengan komunitas Muslim, dan memastikan perjalanan yang lancar.',
              style: blackTextStyle.copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget line() {
    return Container(
      width: double.infinity,
      height: 7,
      decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: kWhiteColor,
                padding: const EdgeInsets.only(
                  bottom: 14,
                  top: 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child:
                                  const Icon(Icons.keyboard_backspace_rounded)),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'FAQ',
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: extraBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Column(
                        children: [
                          bigTitle(),
                          const SizedBox(
                            height: 50,
                          ),
                          heading('Pertanyaan Umum'),
                          const SizedBox(
                            height: 20,
                          ),
                          sectionBox('Apa tujuan aplikasi ini?',
                              'Aplikasi ini dirancang untuk mempermudah dan meningkatkan pengalaman perjalanan bagi wisatawan Muslim di seluruh dunia. Menyediakan fitur penting untuk merencanakan perjalanan, menemukan makanan halal, terhubung dengan komunitas Muslim, dan memastikan perjalanan yang lancar.'),
                          sectionBox(
                              'Apakah aplikasi tersedia dalam beberapa bahasa?',
                              'Untuk saat ini Musafir baru tersedia dalam Bahasa Indonesia.'),
                          sectionBox(
                              'Bagaimana aplikasi memastikan akurasi informasi restoran dan makanan halal?',
                              'Kami mengandalkan kombinasi konten yang dihasilkan pengguna, validasi moderator, dan riset ke badan sertifikasi halal yang terpercaya untuk menjaga akurasi database halal kami.'),
                          sectionBox(
                              'Dapatkah saya menggunakan aplikasi secara offline?',
                              'Anda dapat mengunduh peta dan panduan offline untuk tujuan tertentu untuk digunakan saat tidak memiliki akses internet.'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: line(),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Column(
                        children: [
                          heading('Makanan Halal dan Restoran'),
                          const SizedBox(
                            height: 20,
                          ),
                          sectionBoxCutom('Apa itu status halal?'),
                          sectionBox(
                            'Bagaimana aplikasi membantu saya menemukan makanan halal?',
                            'Aplikasi ini memiliki fitur Pencari Makanan Halal yang memungkinkan Anda mencari restoran atau makanan halal terdekat. Anda dapat memfilter hasil berdasarkan masakan, lokasi, dan peringkat pengguna.',
                          ),
                          sectionBox(
                            'Dapatkah saya berkontribusi pada database makanan halal?',
                            'Ya, Anda dapat mengirimkan lokasi restoran atau makanan halal baru, dan pengguna lain dapat memvalidasi pengiriman Anda. Kontribusi Anda membantu memperluas database kami dan bermanfaat bagi wisatawan Muslim lainnya.',
                          ),
                          sectionBox(
                            'Bagaimana cara saya memverifikasi status halal restoran atau makanan?',
                            'Kami memprioritaskan konten yang dihasilkan pengguna dan validasi untuk informasi halal. Selain itu, kami melakukan riset dan kroscek ke badan sertifikasi halal yang terpercaya untuk memberikan informasi yang diverifikasi.',
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: line(),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Column(
                        children: [
                          heading('Perencanaan Perjalanan dan Itinerary'),
                          const SizedBox(
                            height: 20,
                          ),
                          sectionBox(
                            'Dapatkah saya membuat itinerary yang disesuaikan menggunakan aplikasi ini?',
                            'Ya, Anda dapat membuat rencana perjalanan terperinci dengan menambahkan tujuan, penerbangan, akomodasi, aktivitas, dan waktu sholat untuk setiap hari.',
                          ),
                          sectionBox(
                            'Dapatkah saya membagikan rencana perjalanan saya dengan teman atau keluarga',
                            'Meskipun belum tersedia pada awalnya, kami mempertimbangkan fitur ini untuk pembaruan.',
                          ),
                          sectionBox(
                            'Apakah aplikasi menawarkan layanan pemesanan untuk penerbangan dan akomodasi?',
                            'Kami bertujuan untuk mengintegrasikan layanan pemesanan untuk penerbangan dan akomodasi ramah halal dalam pembaruan mendatang. Saat ini, kami menyediakan informasi dan tautan ke platform pemesanan eksternal.',
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: line(),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Column(
                        children: [
                          heading('Komunitas dan Fitur Sosial'),
                          const SizedBox(
                            height: 20,
                          ),
                          sectionBox(
                            'Bagaimana saya dapat terhubung dengan wisatawan Muslim lainnya?',
                            'Aplikasi ini menawarkan fitur komunitas tempat Anda dapat bergabung dalam grup berdasarkan minat, berbagi pengalaman perjalanan, dan terhubung dengan pengguna lain melalui pesan langsung.',
                          ),
                          sectionBox(
                            'Dapatkah saya memberikan tips dan rekomendasi perjalanan?',
                            'Ya, Anda dapat berbagi pengalaman perjalanan, foto, dan tips dengan komunitas melalui fitur feed dan grup aplikasi.',
                          ),
                          sectionBox(
                            'Bagaimana aplikasi menjaga privasi dan keamanan pengguna?',
                            'Kami memprioritaskan privasi pengguna dan menerapkan langkah-langkah keamanan yang kuat untuk melindungi informasi pribadi Anda.',
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: line(),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Column(
                        children: [
                          heading('Pertanyaan Tambahan'),
                          const SizedBox(
                            height: 20,
                          ),
                          sectionBox(
                            'Apakah ada biaya untuk menggunakan aplikasi ini?',
                            'Untuk saat ini, kami menawarkan aplikasi secara gratis sepenuhnya.',
                          ),
                          sectionBox(
                            'Bagaimana cara memberikan umpan balik atau melaporkan masalah?',
                            'Anda dapat memberikan umpan balik melalui aplikasi, situs web kami, atau dengan menghubungi layanan pelanggan kami.',
                          ),
                          sectionBox(
                            'Di platform apa aplikasi ini tersedia?',
                            'Aplikasi ini saat ini tersedia di Android.',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
