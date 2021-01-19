import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen_provider.dart';

void main() {
  runApp(MaterialApp(
    title: 'Test App',
    theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme:
            InputDecorationTheme(border: OutlineInputBorder())),
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Consumer<HomeProvider>(builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Flutter Test Task')),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
                    onChanged: provider.searchText),
              ),
              Expanded(
                child: provider.hasLoaded
                    ? GestureDetector(
                        onPanDown: (_) => FocusScope.of(context).unfocus(),
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: provider?.filteredTextList?.length ?? 0,
                            itemBuilder: (_, i) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    provider?.filteredTextList[i] ?? '',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                )),
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        );
      }),
    );
  }
}
