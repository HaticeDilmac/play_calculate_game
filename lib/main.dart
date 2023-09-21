import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Çarpım Tablosu Oyunu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiplicationGame(),
    );
  }
}

class MultiplicationGame extends StatefulWidget {
  @override
  _MultiplicationGameState createState() => _MultiplicationGameState();
}

class _MultiplicationGameState extends State<MultiplicationGame> {
  int number1 = 1;
  int number2 = 1;
  int correctAnswer = 1; //sonuç değeri
  int userAnswer = 0; //kullanıcı cevabı
  int score = 0; //toplam doğru sayısı
  int totalQuestions = 0; //topam soru

  void generateQuestion() {
    final random = Random();
    number1 = random.nextInt(10) + 1; // 1-10 arası rastgele sayı
    number2 = random.nextInt(10) + 1; // 1-10 arası rastgele sayı
    correctAnswer = number1 * number2; //rastgele gelen iki değer sonucu
  }

  void checkAnswer() {
    if (userAnswer == correctAnswer) {
      //çarpılan değerlerin sonucu kullanıcının sonucu ile eşitse
      setState(() {
        score++; //doğru sayısını arttır
      });
    }
    totalQuestions++; //toplam soru sayısını arttır
    generateQuestion();
    controller.clear();
  }

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Çarpım Tablosu Oyunu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: userAnswer == correctAnswer
                      ? Colors.green
                      : userAnswer != correctAnswer
                          ? Colors.red
                          : Colors.white, // Pembeli arka plan rengi
                  borderRadius:
                      BorderRadius.circular(20), // Kenarları yuvarlatma
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Soru: $number1 x $number2 = ?',
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          userAnswer = int.tryParse(value) ?? 0;
                        });
                      },
                      decoration: const InputDecoration(
                          hintText: 'Cevap',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        checkAnswer();
                      },
                      child: const Text('Cevapla'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Puan: $score / $totalQuestions',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      //Eğer on üzerinde hiç yanlışsız cevap verilirse tebrik mesajı verilir.
                      score == 10 && score == totalQuestions
                          ? 'Tebrikler $score/$score yaptınızz'
                          : "",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
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
