import 'package:bees_prueba/tools/responsive.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _responsive = Responsive(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Color(0xff191939),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "search");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                            width: _responsive.widthCustom(.9),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Buscar",
                                prefixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                              ),
                              enabled: false,
                              onTap: () {
                                Navigator.pushNamed(context, "search");
                              },
                              onEditingComplete: () {},
                              onChanged: (v) {
                                // if (v.isNotEmpty) {
                                //   _homeBloc.add(ChangeTextToSearch(v));
                                // } else {
                                //   FocusScope.of(context).unfocus();
                                //   if (state.homeStatus ==
                                //       HomeEnum.withSearch) {
                                //     _homeBloc.add(LoadFirstBooks());
                                //   }
                                // }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text("Search Page"),
            ),
          ],
        ),
      ),
    );
  }
}
