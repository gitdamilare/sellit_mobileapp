import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellit_mobileapp/bloc/bloc.dart';
import 'package:sellit_mobileapp/data/searchrepository.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';

class DataSearch extends SearchDelegate {
  final BuildContext bloccontext;
  DataSearch({this.bloccontext});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query == "") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Center(child: Text("Please enter a product name"))],
      );
    }
    BlocProvider.of<SearchBloc>(bloccontext)
        .add(SearchProduct(productname: query));

    return Column(
      children: <Widget>[
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )),
                ],
              );
            }
            if (state is SearchLoaded) {
              if (state.searchresult.isEmpty) {
                return Column(
                  children: <Widget>[
                    Text(
                      "No Results Found.",
                    ),
                  ],
                );
              } else {
                var results = state.searchresult;
                return Expanded(
                                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (BuildContext context, int index) {
                      var result = results[index];
                      return ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Image.network(result.images.first.url , fit: BoxFit.contain,),
                        ),
                        title: Text(
                          result.name,
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.w500),
                        ), //_trailing(_data,context),
                        onTap: () {
                          Navigator.pushNamed(context, ProductDetailsRoute, arguments: result);
                          //_navigationLogic(category, context);
                        },
                      );
                    },
                  ),
                );
              }
            }
          },
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
