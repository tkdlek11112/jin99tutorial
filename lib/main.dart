import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context){
    String title = 'title입니다.';
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.only(bottom: 12),
                    child:Text("Oeschinen Lake Compground",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    )
                ),
                Text("Kandersteg, Switzerland",
                  style: TextStyle(
                      color: Colors.grey[500]
                  ),
                ),
                Text("Kandersteg, Switzerland",
                  style: TextStyle(
                      color: Colors.grey[900]
                  ),
                ),
              ],
            )),
            FavoriteWidget(),
          ],
        )
    );
    Widget buttonSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
            _buildButtonColumn(Colors.blue, Icons.near_me, 'ROUTE'),
            _buildButtonColumn(Colors.blue, Icons.share, 'SHARE'),
          ],
        )
    );
    Widget textSection = Container(
      padding: EdgeInsets.all(24),
      child: Text(
        'this is text are you ok? so this page is introduce adove figure. hones'
            'idont know what i am saying but, is this new line? with 2 indent? '
            'really? oh shit, I hope to work it well',
        textAlign: TextAlign.left,
        softWrap: true
      ),
    );
    Widget ImageSection = Container(
      child: Image.asset('images/lake.jpg',width: 600, height: 240,fit: BoxFit.cover,),
    );
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: ListView(
            children: [
              Image.asset('images/lake.jpg',width: 600, height: 240,fit: BoxFit.cover,),
              titleSection,
              buttonSection,
              textSection,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabBoxA(),
                  ParentWidget(),
                  MixParentWidget()
                ],
              )
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,// This trailing comma makes auto-formatting nicer for build methods.
        )
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          icon,
          color: color,
        ),
        Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            )

        )
      ],
    );
  }
}

class FavoriteWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FavoriteWidgetState();
  }
  // @override
  // _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget>{
  bool _isfavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite(){
    setState(() {
      if(_isfavorited){
        _favoriteCount --;
      }else{
        _favoriteCount ++;
      }
      _isfavorited = !_isfavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isfavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
            child: Container(
              child:Text('$_favoriteCount'),
            ),
        )
      ],
    );
  }
}

class TabBoxA extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TabBoxAState();
  }
}

class _TabBoxAState extends State<TabBoxA>{
  bool _active = true;

  void _onTap(){
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        width: 200,
        height: 200,
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: _active ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}


class ParentWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ParentWidgetState();
  }

}

class _ParentWidgetState extends State<ParentWidget>{
  bool _active = true;

  void _onTap(bool newValue){
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBoxB(
        active: _active,
          onChanged: _onTap,
      ),
    );
  }
}


class TabBoxB extends StatelessWidget{
  TabBoxB({Key? key, this.active: true, required this.onChanged}):super(key:key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _onTap(){
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        width: 200,
        height: 200,
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: active ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}


class MixParentWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MixParentWidgetState();
  }

}

class _MixParentWidgetState extends State<MixParentWidget>{
  bool _active = true;

  void _onTap(bool newValue){
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TapBoxC(
      active: _active,
      onChanged: _onTap
    );
  }
}

class TapBoxC extends StatefulWidget{
  TapBoxC({Key? key, this.active: false, required this.onChanged}):super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  State<StatefulWidget> createState() {
    return _TabBoxCState();
  }
}

class _TabBoxCState extends State<TapBoxC>{
  bool _highLight = false;

  void _handleTapDown(TapDownDetails details){
    setState(() {
      _highLight = true;
    });
  }

  void _handleTapUp(TapUpDetails details){
    setState(() {
      _highLight = false;
    });
  }

  void _handleTapCancel(){
    setState(() {
      _highLight = false;
    });
  }

  void _handleTap(){
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: _handleTap,
      child: Container(
        width: 200,
        height: 200,
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'Inactive',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: widget.active ? Colors.green : Colors.grey,
          border: _highLight ? Border.all(
            color: Colors.teal[700]!,
            width: 10) : null
          ),
        ),
      );
  }
}