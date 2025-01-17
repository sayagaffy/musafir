import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/shared/theme.dart';

class Privasi extends StatefulWidget {
  const Privasi({super.key});

  @override
  State<Privasi> createState() => _PrivasiState();
}

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
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackTextStyle.copyWith(
            fontWeight: bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 30,
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

class _PrivasiState extends State<Privasi> {
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
                            'Privasi',
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: extraBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30.5,
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bigTitle(),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading('Kebijakan Privasi'),
                                Text(
                                  'Musafir (“Perusahaan”) berkomitmen untuk mempertahankan perlindungan privasi yang kuat bagi para penggunanya. Kebijakan Privasi kami ("Kebijakan Privasi") dirancang untuk membantu Anda memahami bagaimana kami mengumpulkan, menggunakan, dan menjaga informasi yang Anda berikan kepada kami dan untuk membantu Anda membuat keputusan yang tepat saat menggunakan Layanan kami.',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.5,
                                ),
                                Text(
                                  "Untuk tujuan Perjanjian ini, “Situs” mengacu pada situs web Perusahaan, yang dapat diakses melalui aplikasi seluler kami. 'Layanan' mengacu pada layanan Perusahaan yang diakses melalui Situs,dimana pengguna dapat melakukannya pasca proyek dan/atau proyek lelang.Istilah 'kami', 'kami', dan 'milik kami' mengacu pada Perusahaan. “Anda” mengacu pada Anda, sebagai pengguna Situs kami atau Layanan kami.",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.5,
                                ),
                                Text(
                                  'Dengan mengakses Situs kami atau Layanan kami, Anda menerima Kebijakan Privasi dan Ketentuan Penggunaan kami (ditemukan di sini: Indo - Terms of use Musafir), dan Anda menyetujui pengumpulan, penyimpanan, penggunaan, dan pengungkapan Informasi Pribadi Anda oleh kami sebagaimana dijelaskan dalam Kebijakan Privasi ini.',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: line(),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading('Informasi yang kami kumpulkan'),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'Kami mengumpulkan “Informasi Non-Pribadi” dan ', // Teks pertama dengan gaya bold
                                        style: blackTextStyle.copyWith(
                                          fontSize: 11,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '“Informasi Pribadi.” ', // Teks kedua dengan gaya normal
                                        style: blackTextStyle.copyWith(
                                          fontSize: 11,
                                          fontWeight: bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'Informasi Non-Pribadi termasuk informasi yang tidak dapat digunakan untuk mengidentifikasi Anda secara pribadi, seperti data penggunaan anonim, informasi demografis umum yang mungkin kami kumpulkan, halaman dan URL perujuk/keluar, jenis platform, preferensi yang Anda kirimkan, dan preferensi yang dibuat berdasarkan data dan nomor yang Anda kirimkan klik ', // Teks pertama dengan gaya bold
                                        style: blackTextStyle.copyWith(
                                            fontSize: 11),
                                      ),
                                      TextSpan(
                                        text:
                                            '“Informasi Pribadi.” ', // Teks kedua dengan gaya normal
                                        style: blackTextStyle.copyWith(
                                          fontSize: 11,
                                          fontWeight: bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'termasuk email Anda, pengalaman individu, profil perusahaan, dan detail proyek, yang Anda serahkan kepada kami melalui proses pendaftaran dilokasi.', // Teks pertama dengan gaya bold
                                        style: blackTextStyle.copyWith(
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: line(),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading(
                                    '1. Informasi dikumpulkan melalui Teknologi'),
                                Text(
                                  'Untuk mengaktifkan Layanan, Anda tidak perlu mengirimkan Informasi Pribadi apa pun selain alamat email Anda. Untuk menggunakan Layanan setelahnya, AndaMengerjakan perlu mengirimkan Informasi Pribadi lebih lanjut. Namun, dalam upaya meningkatkan kualitas Layanan, kami melacak informasi yang diberikan kepada kami oleh browser Anda atau oleh aplikasi perangkat lunak kami saat Anda melihat atau menggunakan Layanan, seperti situs web asal Anda (dikenal sebagai "URL perujuk" ), jenis browser yang Anda gunakan, perangkat tempat Anda terhubung ke Layanan, waktu dan tanggal akses, dan informasi lain yang tidak mengidentifikasi Anda secara pribadi. Kami melacak informasi ini menggunakan cookie, atau file teks kecil yang menyertakan pengidentifikasi unik anonim. Cookie dikirim ke browser pengguna dari server kami dan disimpan di hard drive komputer pengguna. Mengirim cookie ke browser pengguna memungkinkan kami untuk mengumpulkan informasi Non-Pribadi tentang pengguna tersebut dan mencatat preferensi pengguna saat menggunakan layanan kami, baik secara individu maupun agregat.',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.5,
                                ),
                                Text(
                                  "Perusahaan dapat menggunakan cookie persisten dan sesi; cookie persisten tetap ada di komputer Anda setelah Anda menutup sesi dan sampai Anda menghapusnya, sementara cookie sesi kedaluwarsa saat Anda menutup browser.",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                heading(
                                    '2. Informasi yang Anda berikan kepada kami dengan mendaftar akun'),
                                Text(
                                  'Untuk mengaktifkan Layanan, Anda tidak perlu mengirimkan Informasi Pribadi apa pun selain alamat email Anda. Untuk menggunakan Layanan setelahnya, AndaMengerjakan perlu mengirimkan Informasi Pribadi lebih lanjut. Namun, dalam upaya meningkatkan kualitas Layanan, kami melacak informasi yang diberikan kepada kami oleh browser Anda atau oleh aplikasi perangkat lunak kami saat Anda melihat atau menggunakan Layanan, seperti situs web asal Anda (dikenal sebagai "URL perujuk" ), jenis browser yang Anda gunakan, perangkat tempat Anda terhubung ke Layanan, waktu dan tanggal akses, dan informasi lain yang tidak mengidentifikasi Anda secara pribadi. Kami melacak informasi ini menggunakan cookie, atau file teks kecil yang menyertakan pengidentifikasi unik anonim. Cookie dikirim ke browser pengguna dari server kami dan disimpan di hard drive komputer pengguna. Mengirim cookie ke browser pengguna memungkinkan kami untuk mengumpulkan informasi Non-Pribadi tentang pengguna tersebut dan mencatat preferensi pengguna saat menggunakan layanan kami, baik secara individu maupun agregat.',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.5,
                                ),
                                Text(
                                  "Perusahaan dapat menggunakan cookie persisten dan sesi; cookie persisten tetap ada di komputer Anda setelah Anda menutup sesi dan sampai Anda menghapusnya, sementara cookie sesi kedaluwarsa saat Anda menutup browser.",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                heading('3. Privasi Anak-anak'),
                                Text(
                                  'Situs dan Layanan tidak ditujukan kepada siapa pun yang berusia di bawah 17 tahun.Situs tidak dengan sengaja mengumpulkan atau meminta informasi dari siapa pun yang berusia di bawah 17 tahun, atau mengizinkan siapa pun yang berusia di bawah 17 tahun untuk mendaftar ke Layanan. Jika kami mengetahui bahwa kami telah mengumpulkan informasi pribadi dari siapa pun yang berusia di bawah 17 tahun tanpa persetujuan orang tua atau wali, kami akan menghapus informasi tersebut sesegera mungkin.',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: line(),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading(
                                    'Bagaimana kami menggunakan dan berbagi informasi'),
                                Text(
                                  'Informasi Pribadi',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 13,
                                    fontWeight: bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Kecuali dinyatakan lain dalam Kebijakan Privasi ini, kami tidak menjual, memperdagangkan, menyewakan, atau membagikan untuk tujuan pemasaran Informasi Pribadi Anda dengan pihak ketiga tanpa persetujuan Anda. Kami membagikan Informasi Pribadi dengan vendor yang menyediakan layanan untuk Perusahaan, seperti server untuk komunikasi email kami yang menyediakan akses ke alamat email pengguna untuk tujuan pengiriman email dari kami. Vendor tersebut menggunakan Informasi Pribadi Anda hanya atas arahan kami dan sesuai dengan Kebijakan Privasi kami.',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.5,
                                ),
                                Text(
                                  "Secara umum, Informasi Pribadi yang Anda berikan kepada kami digunakan untuk membantu kami berkomunikasi dengan Anda. Misalnya, kami menggunakan Informasi Pribadi untuk menghubungi pengguna sebagai tanggapan atas pertanyaan, meminta umpan balik dari pengguna, memberikan dukungan teknis, dan memberitahu pengguna tentang penawaran promosi.",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.5,
                                ),
                                Text(
                                  "Kami dapat membagikan Informasi Pribadi dengan pihak luar jika kami memiliki keyakinan dengan itikad baik bahwa akses, penggunaan, penyimpanan, atau pengungkapan informasi tersebut secara wajar diperlukan untuk memenuhi setiap proses hukum yang berlaku atau permintaan pemerintah yang dapat dilaksanakan; untuk menegakkan Ketentuan Layanan yang berlaku, termasuk investigasi potensi pelanggaran; menangani masalah penipuan, keamanan, atau teknis; atau untuk melindungi dari bahaya terhadap hak, properti, atau keamanan pengguna kami atau publik sebagaimana diharuskan atau diizinkan oleh hukum.",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Informasi Non-Pribadi',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 13,
                                    fontWeight: bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Secara umum, kami menggunakan Informasi Non-Pribadi untuk membantu kami meningkatkan Layanan dan menyesuaikan pengalaman pengguna. Kami juga mengumpulkan Informasi Non-Pribadi untuk melacak tren dan menganalisis pola penggunaan di Situs. Kebijakan Privasi ini tidak membatasi penggunaan atau pengungkapan Informasi Non-Pribadi kami dengan cara apa pun dan kami berhak untuk menggunakan dan mengungkapkan Informasi Non-Pribadi tersebut kepada mitra kami, pengiklan, dan pihak ketiga lainnya atas kebijaksanaan kami.',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.5,
                                ),
                                Text(
                                  "Jika kami menjalani transaksi bisnis seperti merger, akuisisi oleh perusahaan lain, atau penjualan semua atau sebagian aset kami, Informasi Pribadi Anda mungkin termasuk dalam aset yang dialihkan. Anda mengakui dan menyetujui bahwa transfer tersebut dapat terjadi dan diizinkan oleh Kebijakan Privasi ini, dan bahwa setiap pengakuisisi aset kami dapat terus memproses Informasi Pribadi Anda sebagaimana diatur dalam Kebijakan Privasi ini. Jika praktik informasi kami berubah sewaktu-waktu di masa mendatang, kami akan memposting perubahan kebijakan ke Situs sehingga Anda dapat memilih keluar dari praktik informasi baru. Kami menyarankan Anda untuk memeriksa Situs secara berkala jika Anda khawatir tentang bagaimana informasi Anda digunakan.",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: line(),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading('Bagaimana Kami Melindungi Informasi'),
                                Text(
                                  'Kami menerapkan langkah-langkah keamanan yang dirancang untuk melindungi informasi Anda dari akses yang tidak sah. Akun Anda dilindungi oleh kata sandi akun Anda dan kami mendorong Anda untuk mengambil langkah-langkah untuk menjaga keamanan informasi pribadi Anda dengan tidak mengungkapkan kata sandi Anda dan dengan keluar dari akun Anda setelah digunakan. Kami selanjutnya melindungi informasi Anda dari potensi pelanggaran keamanan dengan menerapkan langkah-langkah keamanan teknologi tertentu termasuk enkripsi, firewall, dan teknologi lapisan soket aman. Namun, langkah-langkah ini tidak menjamin bahwa informasi Anda tidak akan diakses, diungkapkan, diubah, atau dihancurkan oleh pelanggaran firewall dan perangkat lunak server aman tersebut. Dengan menggunakan Layanan kami, Anda mengakui bahwa Anda memahami dan setuju untuk menanggung risiko ini.',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: line(),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading(
                                    'Hak Anda Terkait Penggunaan Informasi Pribadi Anda'),
                                Text(
                                  'Anda berhak setiap saat untuk mencegah kami menghubungi Anda untuk tujuan pemasaran. Saat kami mengirimkan komunikasi promosi kepada pengguna, pengguna dapat memilih untuk tidak mengikuti komunikasi promosi lebih lanjut dengan mengikuti petunjuk berhenti berlangganan yang disediakan di setiap email promosi. Harap perhatikan bahwa terlepas dari preferensi promosi yang Anda tunjukkan dengan berhenti berlangganan, kami dapat terus mengirimi Anda email administratif termasuk, misalnya, pembaruan berkala terhadap Kebijakan Privasi kami.',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: line(),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading('Link ke Website Lain'),
                                Text(
                                  'Sebagai bagian dari Layanan, kami dapat menyediakan tautan ke atau kompatibilitas dengan situs web atau aplikasi lain. Namun, kami tidak bertanggung jawab atas praktik privasi yang diterapkan oleh situs web tersebut atau informasi atau konten yang dikandungnya. Kebijakan Privasi ini hanya berlaku untuk informasi yang dikumpulkan oleh kami melalui Situs dan Layanan. Oleh karena itu, Kebijakan Privasi ini tidak berlaku untuk penggunaan Anda atas situs web pihak ketiga yang diakses dengan memilih tautan di Situs kami atau melalui Layanan kami. Sejauh Anda mengakses atau menggunakan Layanan melalui atau di situs web atau aplikasi lain, maka kebijakan privasi situs web atau aplikasi lain tersebut akan berlaku untuk akses atau penggunaan Anda atas situs atau aplikasi tersebut. Kami mendorong pengguna kami untuk membaca pernyataan privasi situs web lain sebelum melanjutkan untuk menggunakannya.',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: line(),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading('Perubahan Kebijakan Privasi Kami'),
                                Text(
                                  'Perusahaan berhak mengubah kebijakan ini dan Ketentuan Layanan kami kapan saja. Kami akan memberi tahu Anda tentang perubahan signifikan pada Kebijakan Privasi kami dengan mengirimkan pemberitahuan ke alamat email utama yang ditentukan di akun Anda atau dengan menempatkan pemberitahuan yang jelas di situs kami. Perubahan signifikan akan berlaku 30 hari setelah pemberitahuan tersebut. Perubahan atau klarifikasi non-materi akan segera berlaku. Anda harus secara berkala memeriksa Situs dan halaman privasi ini untuk pembaruan.',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: line(),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Terakhir Diperbarui: Kebijakan Privasi ini terakhir diperbarui pada 30 Agustus 2024.',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
