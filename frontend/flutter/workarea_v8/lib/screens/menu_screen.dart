import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:workarea_v8/blocs/word_pair/word_pair_bloc.dart';
import 'package:workarea_v8/blocs/word_pair/word_pair_event.dart';
import 'package:workarea_v8/blocs/word_pair/word_pair_state.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onWordPairsRequested() {
    if (_controller.text.isEmpty) {
      return;
    }

    int count = 0;
    try {
      count = int.parse(_controller.text);
    } catch (e) {
      count = 0;
    }

    BlocProvider.of<WordPairDataBloc>(context).add(
      WordPairDataRequested(count: count),
    );
    _controller.clear();
    _focusNode.unfocus();
  }

  void _onWordPairsRefreshRequested() {
    BlocProvider.of<WordPairDataBloc>(context).add(
      const WordPairDataRefreshRequested(),
    );
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Menu Screen"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text("Enter the number of word pairs you want to generate"),
                    const SizedBox(height: 20.0),
                    TextField(
                      focusNode: _focusNode,
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Number of word pairs",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Material(
                              color: Colors.purple,
                              child: InkWell(
                                onTap: _onWordPairsRequested,
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: const Text(
                                      "Request Word Pairs",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          flex: 3,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Material(
                              color: Color.fromARGB(255, 50, 241, 136),
                              child: InkWell(
                                onTap: _onWordPairsRefreshRequested,
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: const Icon(
                                      Icons.refresh,
                                      size: 20,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      width: 1,
                      color: Color.fromARGB(255, 216, 216, 216),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: BlocBuilder<WordPairDataBloc, WordPairDataState>(
                        builder: (context, state) {
                      if (state is WordPairDataLoaded) {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: state.wordPairs.length,
                          itemBuilder: (context, index) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                  width: 0.3,
                                  color: Color.fromARGB(255, 43, 43, 43),
                                )),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Original: ${state.wordPairs[index].original}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 59, 59, 59))),
                                    Text(
                                        "Translation: ${state.wordPairs[index].translation}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 104, 104, 104))),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is WordPairDataUninitialized) {
                        return const Center(
                          child: Text("No word pairs generated yet"),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
