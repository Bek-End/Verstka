import 'package:flutter/material.dart';
import 'package:testVerstka/bloc/result_of_search_bloc.dart';
import 'package:testVerstka/const.dart';
import 'package:testVerstka/models/repo_model.dart';

class ResultOfSearch extends StatefulWidget {
  @override
  _ResultOfSearchState createState() => _ResultOfSearchState();
  static final routeName = "/result";
}

class _ResultOfSearchState extends State<ResultOfSearch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: resultOfSearchBloc.subject.stream,
        builder: (context, AsyncSnapshot<ResultOfSearchStates> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.runtimeType) {
              case InitialState:
                InitialState myState = snapshot.data;
                return Scaffold(
                  appBar: AppBar(
                    leading: null,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    title: Text(
                      "РЕЗУЛЬТАТ ПОИСКА",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          letterSpacing: 0.05),
                    ),
                    centerTitle: true,
                  ),
                  body: Container(
                    child: Stack(
                      children: [
                        ListView(
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 19, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('ПО ЗАПРОСУ: ',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: 0.05,
                                              color: secondColor),
                                          textAlign: TextAlign.center),
                                      Text('"${myState.q}"',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF58AFFF)))
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      "НАЙДЕНО: ${myState.repoModel.totalCount}",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0.05,
                                          color: secondColor),
                                    ),
                                  ),
                                ),
                              ] +
                              buildList(myState.repoModel),
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: firstColor,
                        )
                      ],
                    ),
                  ),
                );
              default:
                return Container();
                break;
            }
          } else {
            return Scaffold(
              body: Center(
                child: Text("Loading..."),
              ),
            );
          }
        });
  }

  List<Widget> buildList(RepositoryModel repoModel) {
    List<Widget> results = [];
    for (int i = 0; i < repoModel.items.length; i++) {
      results.add(buildNews(repoModel.items[i]));
    }
    return results;
  }

  Widget buildNews(Items item) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, right: 16, left: 16),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: firstColor, width: 1)),
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${item.name}",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal)),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child:
                          ClipOval(child: Image.network(item.owner.avatarUrl)),
                      radius: 15,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      item.owner.login,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
                  height: 1,
                  color: firstColor,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text("Обновлено: ",
                        style: TextStyle(
                            color: secondColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal)),
                    Text(
                      "${item.updatedAt}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Colors.black),
                    )
                  ],
                )
              ],
            ),
          ),
          FittedBox(
            child: Container(
              padding: EdgeInsets.all(7),
              margin: EdgeInsets.only(top: 12, right: 16),
              decoration: BoxDecoration(
                color: secondColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.star_border,
                    size: 16,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "${item.score.toInt()}",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
