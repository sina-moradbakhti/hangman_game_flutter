import 'package:flutter/material.dart';
import 'package:hangman_game/hangman.dart';
import 'package:hangman_game/playground_provider.dart';
import 'package:provider/provider.dart';

class Playground extends StatelessWidget {
  Playground({super.key});

  final letters = 'abcdefghijklmnopqrstuvwxyz'.split('').toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hangman Game'), centerTitle: false, actions: [
        Text(
            'Win: ${HangmanHelper().wins} Lose: ${HangmanHelper().losses}     ')
      ]),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (context.watch<PlaygorundController>().player.chances == 6)
                    Image.asset('assets/hangman_0.png'),
                  if (context.watch<PlaygorundController>().player.chances == 5)
                    Image.asset('assets/hangman_01.png'),
                  if (context.watch<PlaygorundController>().player.chances == 4)
                    Image.asset('assets/hangman_02.png'),
                  if (context.watch<PlaygorundController>().player.chances == 3)
                    Image.asset('assets/hangman_03.png'),
                  if (context.watch<PlaygorundController>().player.chances == 2)
                    Image.asset('assets/hangman_04.png'),
                  if (context.watch<PlaygorundController>().player.chances == 1)
                    Image.asset('assets/hangman_05.png'),
                  if (context.watch<PlaygorundController>().player.chances == 0)
                    Image.asset('assets/hangman_06.png'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              context.watch<PlaygorundController>().player.guessWord,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: context.read<PlaygorundController>().player.isFinished
                ? _finishWidget(context)
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: letters.length,
                    itemBuilder: (context, index) {
                      return IconButton(
                        onPressed: () {
                          context
                              .read<PlaygorundController>()
                              .guessLetter(letters[index]);
                        },
                        icon: Text(letters[index].toUpperCase(),
                            style: Theme.of(context).textTheme.headlineSmall),
                      );
                    }),
          ))
        ],
      )),
    );
  }

  Widget _finishWidget(BuildContext context) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  context.read<PlaygorundController>().refresh();
                },
                icon: const Icon(Icons.refresh)),
            const SizedBox(width: 20),
            Text(
                context.read<PlaygorundController>().player.word ==
                        context.read<PlaygorundController>().player.guessWord
                    ? 'You Win'
                    : 'You Lose!',
                style: Theme.of(context).textTheme.headlineSmall)
          ],
        ),
      );
}
