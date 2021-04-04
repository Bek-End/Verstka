import 'package:flutter/material.dart';
import 'package:testVerstka/bloc/search_bloc.dart';
import 'package:testVerstka/const.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
  static final routeName = "/search";
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    searchBloc.mapEventToState(InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: searchBloc.subject.stream,
        builder: (context, AsyncSnapshot<SearchStates> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.runtimeType) {
              case InitialState:
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        title: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            "ПОИСК",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                        centerTitle: true,
                      ),
                      body: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(
                                flex: 14,
                              ),
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: firstColor, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: TextField(
                                            controller: _controller,
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    bottom: 5, left: 10),
                                                border: InputBorder.none),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    searchBloc.mapEventToState(
                                                        ShowResultEvent(
                                                            q: _controller
                                                                .text));
                                                  },
                                                  child: FittedBox(
                                                    fit: BoxFit.fill,
                                                    child: Text(
                                                      "НАЙТИ",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          letterSpacing: 0.05),
                                                    ),
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                      primary: const Color(
                                                          0xFF58AFFF))),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(
                                flex: 50,
                              )
                            ],
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: firstColor,
                          )
                        ],
                      )),
                );
              default:
                return Container();
                break;
            }
          } else {
            return Container();
          }
        });
  }
}
