import 'package:flutter/material.dart';
import 'package:hero_card/space.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(title: 'Animations'),
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: spaces
            .map((space) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return SpaceDetail(data: space);
                      },
                    ));
                  },
                  child: Column(children: [
                    Hero(
                        tag: space.id,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(space.image),
                        )),
                    Hero(
                        tag: '${space.id}-text',
                        child: Material(child: Text('${space.description}'))),
                    Hero(
                        tag: '${space.id}-button',
                        child: Material(
                            child: Container(
                                color: Colors.red,
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.play_arrow))))
                  ]),
                ))
            .toList(),
      ),
    );
  }
}

class SpaceDetail extends StatelessWidget {
  const SpaceDetail({Key key, this.data}) : super(key: key);
  final Space data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Hero(tag: data.id, child: Image.asset(data.image)),
              Positioned(
                right: 20,
                bottom: -24,
                child: Hero(
                    tag: '${data.id}-button',
                    child: Material(
                      child: Container(
                          color: Colors.red,
                          padding: EdgeInsets.all(20),
                          child: Icon(Icons.play_arrow)),
                    )),
              )
            ],
          ),
          Hero(
            tag: '${data.id}-text',
            child: Material(
              child: Text('${data.description}'),
            ),
          ),
        ]),
      ),
    );
  }
}
