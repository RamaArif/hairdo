import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:omahdilit/constant.dart';

class Policy extends StatefulWidget {
  final bool isPolicy;
  const Policy({Key? key, required this.isPolicy}) : super(key: key);

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xffFF4C30),
            size: 21,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.grey.shade100,
        iconTheme: IconThemeData(color: Color(0xFF6F6F6F)),
        title: Text(
          widget.isPolicy
              ? "Kebijakan Privasi"
              : "Syarat dan Ketentuan Layanan",
          style: textStyle.copyWith(
            color: primary,
            fontWeight: bold,
            fontSize: tinggi / lebar * 9,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: marginHorizontal,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: marginVertical,
                  ),
                  child: Html(
                      style: {
                        "p": htmlBlack,
                      },
                      data: widget.isPolicy
                          ? '<p>Ruang Digital Kratif membangun aplikasi Hairdo.yu sebagai aplikasi Gratis. LAYANAN ini disediakan oleh Ruang Digital Kratif tanpa biaya dan dimaksudkan untuk digunakan apa adanya.</p> <p>Halaman ini digunakan untuk memberi tahu pengunjung mengenai kebijakan saya dengan pengumpulan, penggunaan, dan pengungkapan Informasi Pribadi jika ada yang memutuskan untuk menggunakan Layanan saya.</p> <p>Jika Anda memilih untuk menggunakan Layanan saya, maka Anda menyetujui pengumpulan dan penggunaan informasi sehubungan dengan kebijakan ini. Informasi Pribadi yang saya kumpulkan digunakan untuk menyediakan dan meningkatkan Layanan. Saya tidak akan menggunakan atau membagikan informasi Anda dengan siapa pun kecuali sebagaimana dijelaskan dalam Kebijakan Privasi ini.</p> <p>Istilah yang digunakan dalam Kebijakan Privasi ini memiliki arti yang sama seperti dalam Syarat dan Ketentuan kami, yang dapat diakses di Hairdo.yu kecuali ditentukan lain dalam Kebijakan Privasi ini.</p> <p><strong>Pengumpulan dan Penggunaan Informasi</strong></p> <p>Untuk pengalaman yang lebih baik, saat menggunakan Layanan kami, saya mungkin meminta Anda untuk memberikan kami informasi pengenal pribadi tertentu, termasuk namun tidak terbatas pada Nama, Telepon, Alamat, Jenis Kelamin, Email. Informasi yang saya minta akan disimpan di perangkat Anda dan tidak saya kumpulkan dengan cara apa pun.</p> <div> <p>Aplikasi ini menggunakan layanan pihak ketiga yang dapat mengumpulkan informasi yang digunakan untuk mengidentifikasi Anda.</p> <p>Tautan ke kebijakan privasi penyedia layanan pihak ketiga yang digunakan oleh aplikasi</p> <ul> <li><a href="https://www.google.com/policies/privacy/" rel="nofollow" target="_blank">Layanan Google Play</a></li> <li><a href="https://firebase.google.com/support/privacy/" rel="nofollow" target="_blank">Firebase Crashlytics</a></li> </ul> </div> <p><strong>Data Masuk</strong></p> <p>Saya ingin memberi tahu Anda bahwa setiap kali Anda menggunakan Layanan saya, jika terjadi kesalahan dalam aplikasi, saya mengumpulkan data dan informasi (melalui produk pihak ketiga) di ponsel Anda yang disebut Data Log. Data Log ini dapat mencakup informasi seperti alamat Protokol Internet (“IP”) perangkat Anda, nama perangkat, versi sistem operasi, konfigurasi aplikasi saat menggunakan Layanan saya, waktu dan tanggal penggunaan Layanan oleh Anda, dan lainnya statistik.</p> <p><strong>Cookie</strong></p> <p>Cookie adalah file dengan sejumlah kecil data yang biasanya digunakan sebagai pengenal unik anonim. Ini dikirim ke browser Anda dari situs web yang Anda kunjungi dan disimpan di memori internal perangkat Anda.</p> <p>Layanan ini tidak menggunakan “cookie” secara eksplisit. Namun, aplikasi dapat menggunakan kode dan pustaka pihak ketiga yang menggunakan “cookies” untuk mengumpulkan informasi dan meningkatkan layanan mereka. Anda memiliki pilihan untuk menerima atau menolak cookie ini dan mengetahui kapan cookie dikirim ke perangkat Anda. Jika Anda memilih untuk menolak cookie kami, Anda mungkin tidak dapat menggunakan beberapa bagian dari Layanan ini.</p> <p><strong>Penyedia Layanan</strong></p> <p>Saya dapat mempekerjakan perusahaan dan individu pihak ketiga karena alasan berikut:</p> <ul> <li>Untuk memfasilitasi Layanan kami;</li> <li>Untuk menyediakan Layanan atas nama kami;</li> <li>Untuk melakukan layanan terkait Layanan; atau</li> <li>Untuk membantu kami dalam menganalisis bagaimana Layanan kami digunakan.</li> </ul> <p>Saya ingin memberi tahu pengguna Layanan ini bahwa pihak ketiga ini memiliki akses ke Informasi Pribadi mereka. Alasannya adalah untuk melakukan tugas yang diberikan kepada mereka atas nama kita. Namun, mereka berkewajiban untuk tidak mengungkapkan atau menggunakan informasi tersebut untuk tujuan lain apa pun.</p> <p><strong>Keamanan</strong></p> <p>Saya menghargai kepercayaan Anda dalam memberikan Informasi Pribadi Anda kepada kami, oleh karena itu kami berusaha untuk menggunakan cara yang dapat diterima secara komersial untuk melindunginya. Namun ingat bahwa tidak ada metode transmisi melalui internet, atau metode penyimpanan elektronik yang 100% aman dan andal, dan saya tidak dapat menjamin keamanan mutlaknya.</p> <p><strong>Tautan ke Situs Lain</strong></p> <p>Layanan ini mungkin berisi tautan ke situs lain. Jika Anda mengklik tautan pihak ketiga, Anda akan diarahkan ke situs itu. Perhatikan bahwa situs eksternal ini tidak dioperasikan oleh saya. Oleh karena itu, saya sangat menyarankan Anda untuk meninjau Kebijakan Privasi situs web ini. Saya tidak memiliki kendali atas dan tidak bertanggung jawab atas konten, kebijakan privasi, atau praktik situs atau layanan pihak ketiga mana pun.</p> <p><strong>Privasi Anak</strong></p> <div> <p>Layanan ini tidak ditujukan kepada siapa pun yang berusia di bawah 13 tahun. Saya tidak secara sengaja mengumpulkan informasi pengenal pribadi dari anak-anak di bawah 13 tahun. Jika saya menemukan bahwa seorang anak di bawah 13 tahun telah memberi saya informasi pribadi, saya segera menghapusnya dari server kami. Jika Anda adalah orang tua atau wali dan Anda mengetahui bahwa anak Anda telah memberikan informasi pribadi kepada kami, harap hubungi saya agar saya dapat melakukan tindakan yang diperlukan.</p> </div> <p><strong>Perubahan pada Kebijakan Privasi Ini</strong></p> <p>Saya dapat memperbarui Kebijakan Privasi kami dari waktu ke waktu. Oleh karena itu, Anda disarankan untuk meninjau halaman ini secara berkala untuk setiap perubahan. Saya akan memberi tahu Anda tentang perubahan apa pun dengan memposting new Kebijakan Privasi di halaman ini.</p> <p>Kebijakan ini berlaku mulai 27-05- 2022</p> <p><strong>Hubungi Kami</strong></p> <p>Jika Anda memiliki pertanyaan atau saran tentang Kebijakan Privasi saya, jangan ragu untuk menghubungi saya di halo@rdkreatif.com.</p>'
                          : '<p>Dengan mengunduh atau menggunakan aplikasi, persyaratan ini akan otomatis berlaku untuk Anda – Oleh karena itu, Anda harus memastikan bahwa Anda membacanya dengan cermat sebelum menggunakan aplikasi. Anda tidak diizinkan untuk menyalin atau memodifikasi aplikasi, bagian mana pun dari aplikasi, atau merek dagang kami dengan cara apa pun. Anda tidak diizinkan untuk mencoba mengekstrak kode sumber aplikasi, dan Anda juga tidak boleh mencoba menerjemahkan aplikasi ke bahasa lain atau membuat versi turunan. Aplikasi itu sendiri, dan semua merek dagang, hak cipta, hak basis data, dan hak kekayaan intelektual lainnya yang terkait dengannya, masih menjadi milik Ruang Digital Kratif.</p> <p>Ruang Digital Kratif berkomitmen untuk memastikan bahwa aplikasi ini berguna dan seefisien mungkin. Untuk alasan itu, kami berhak untuk membuat perubahan pada aplikasi atau membebankan biaya untuk layanannya, kapan saja dan untuk alasan apa pun. Kami tidak akan menagih Anda untuk aplikasi atau layanannya tanpa menjelaskan dengan jelas kepada Anda apa yang sebenarnya Anda bayar.</p> <p>Aplikasi Hairdo.yu menyimpan dan memproses data pribadi yang Anda berikan kepada kami, untuk menyediakan Layanan saya. Anda bertanggung jawab untuk menjaga keamanan ponsel dan akses ke aplikasi. Oleh karena itu, kami menyarankan Anda untuk tidak melakukan jailbreak atau root pada ponsel Anda, yang merupakan proses menghilangkan batasan dan batasan perangkat lunak yang diberlakukan oleh sistem operasi resmi perangkat Anda. Hal ini dapat membuat ponsel Anda rentan terhadap malware/virus/program berbahaya, membahayakan fitur keamanan ponsel Anda, dan ini dapat berarti bahwa aplikasi Hairdo.yu tidak akan berfungsi dengan baik atau tidak berfungsi sama sekali.</p> <div> <p>Aplikasi ini menggunakan layanan pihak ketiga yang menyatakan Persyaratan dan Ketentuan mereka.</p> <p>Tautan ke Persyaratan dan Ketentuan penyedia layanan pihak ketiga yang digunakan oleh aplikasi</p> <ul> <li><a href="https://policies.google.com/terms" rel="nofollow" target="_blank">Layanan Google Play</a></li> <li><a href="https://firebase.google.com/terms/crashlytics" rel="nofollow" target="_blank">Firebase Crashlytics</a></li> </ul> </div> <p>Anda harus menyadari bahwa ada hal-hal tertentu yang tidak menjadi tanggung jawab Ruang Digital Kratif. Fungsi aplikasi tertentu akan mengharuskan aplikasi memiliki koneksi internet aktif. Koneksi dapat berupa Wi-Fi atau disediakan oleh penyedia jaringan seluler Anda, tetapi Ruang Digital Kratif tidak dapat bertanggung jawab atas aplikasi yang tidak berfungsi secara penuh jika Anda tidak memiliki akses ke Wi-Fi, dan Anda tidak memilikinya sisa kuota data Anda.</p> <p><br></p> <p>Jika Anda menggunakan aplikasi di luar area dengan Wi-Fi, Anda harus ingat bahwa persyaratan perjanjian dengan penyedia jaringan seluler Anda akan tetap berlaku. Akibatnya, Anda mungkin dikenakan biaya oleh penyedia seluler Anda untuk biaya data selama koneksi saat mengakses aplikasi, atau biaya pihak ketiga lainnya. Dalam menggunakan aplikasi, Anda menerima tanggung jawab atas biaya tersebut, termasuk biaya data roaming jika Anda menggunakan aplikasi di luar wilayah asal Anda (yaitu wilayah atau negara) tanpa menonaktifkan roaming data. Jika Anda bukan pembayar tagihan untuk perangkat tempat Anda menggunakan aplikasi, harap perhatikan bahwa kami berasumsi bahwa Anda telah menerima izin dari pembayar tagihan untuk menggunakan aplikasi.</p> <p>Selain itu, Ruang Digital Kratif tidak selalu bertanggung jawab atas cara Anda menggunakan aplikasi, yaitu Anda harus memastikan perangkat Anda tetap terisi daya – jika baterai habis dan Anda tidak dapat menyalakannya untuk memanfaatkan Layanan, Ruang Digital Kratif tidak bertanggung jawab.</p> <p>Sehubungan dengan tanggung jawab Ruang Digital Kratif atas penggunaan Anda atas aplikasi, ketika Anda menggunakan aplikasi, penting untuk diingat bahwa meskipun kami berusaha untuk memastikan bahwa itu diperbarui dan benar setiap saat , kami mengandalkan pihak ketiga untuk memberikan informasi kepada kami sehingga kami dapat menyediakannya untuk Anda. Ruang Digital Kratif tidak bertanggung jawab atas kerugian apa pun, langsung atau tidak langsung, yang Anda alami sebagai akibat dari mengandalkan sepenuhnya fungsi aplikasi ini.</p> <p>Pada titik tertentu, kami mungkin ingin memperbarui aplikasi. Aplikasi saat ini tersedia di Android & iOS – persyaratan untuk kedua sistem (dan untuk sistem tambahan apa pun yang kami putuskan untuk memperluas ketersediaan aplikasi) dapat berubah, dan Anda harus mengunduh pembaruan jika ingin tetap menggunakan aplikasi. Ruang Digital Kratif tidak menjanjikan akan selalu mengupdate aplikasi agar relevan dengan Anda dan/atau bekerja dengan Android & versi iOS yang telah Anda instal di perangkat Anda. Namun, Anda berjanji untuk selalu menerima pembaruan aplikasi saat ditawarkan kepada Anda, Kami mungkin juga ingin berhenti menyediakan aplikasi, dan dapat menghentikan penggunaannya kapan saja tanpa memberikan pemberitahuan penghentian kepada Anda. Kecuali jika kami memberi tahu Anda sebaliknya, setelah penghentian apa pun, (a) hak dan lisensi yang diberikan kepada Anda dalam persyaratan ini akan berakhir; (b) Anda harus berhenti menggunakan aplikasi, dan (jika perlu) menghapusnya dari perangkat Anda.</p> <p><strong>Perubahan pada Syarat dan Ketentuan Ini</strong></p> <p>Saya dapat memperbarui Syarat dan Ketentuan kami dari waktu ke waktu. Oleh karena itu, Anda disarankan untuk meninjau halaman ini secara berkala untuk setiap perubahan. Saya akan memberi tahu Anda tentang perubahan apa pun dengan memposting Persyaratan dan Ketentuan baru di halaman ini.</p> <p>Syarat dan ketentuan ini berlaku mulai 27-05-22</p> <p><strong>Hubungi Kami</strong></p> <p>Jika Anda memiliki pertanyaan atau saran tentang Syarat dan Ketentuan saya, jangan ragu untuk menghubungi saya di halo@rdkreatif.com.</p>'),
                ),
                SizedBox(
                  height: marginVertical * 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
