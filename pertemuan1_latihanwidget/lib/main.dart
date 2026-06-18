import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan Widget',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Latihan Widget Andhika'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // =========================
                // CONTAINER & DECORATION
                // =========================

                const SizedBox(height: 40),

                Container(
                  width: 250,
                  height: 150,

                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25),

                    border: Border.all(
                      color: Colors.black,
                      width: 4,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.3),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: const Center(
                    child: Text(
                      'Andhika Box',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // =========================
                // ROW & COLUMN
                // =========================

                const Text(
                  'Belajar Row & Column',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,

                  children: [
                    kotak(Colors.red, 'A'),
                    kotak(Colors.green, 'B'),
                    kotak(Colors.blue, 'C'),
                  ],
                ),

                const SizedBox(height: 40),

                // =========================
                // BUTTON
                // =========================

                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Tap Saya'),
                ),

                const SizedBox(height: 40),

                // =========================
                // ICON SECTION
                // =========================

                const Text(
                  'Favorite Icons',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                const Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,

                  children: [

                    Icon(
                      Icons.home,
                      size: 40,
                      color: Colors.red,
                    ),

                    Icon(
                      Icons.favorite,
                      size: 40,
                      color: Colors.green,
                    ),

                    Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.purple,
                    ),

                    Icon(
                      Icons.settings,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),

        // =========================
        // BOTTOM NAVIGATION
        // =========================

        bottomNavigationBar: Container(
          padding:
          const EdgeInsets.symmetric(vertical: 12),

          decoration: BoxDecoration(
            color: Colors.grey.shade200,

            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(0, -2),
                color: Colors.black12,
              ),
            ],
          ),

          child: const Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,

            children: [

              Icon(
                Icons.home,
                size: 32,
                color: Colors.red,
              ),

              Icon(
                Icons.favorite,
                size: 32,
                color: Colors.green,
              ),

              Icon(
                Icons.person,
                size: 32,
                color: Colors.purple,
              ),

              Icon(
                Icons.settings,
                size: 32,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget kotak(
      Color warna,
      String huruf,
      ) {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,

      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Text(
        huruf,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}