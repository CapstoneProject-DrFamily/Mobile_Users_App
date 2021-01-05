import 'package:drFamily_app/Helper/fire_base_link.dart';
import 'package:flutter/material.dart';

class GlobalAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // actions: <Widget>[
      //   IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      // ],
      // centerTitle: true
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, 0.0),
            end: Alignment(1.0, 0.0),
            colors: [const Color(0xFF6aa6f8), const Color(0xFF1a60be)],
          ),
        ),
      ),
      // title: Text('Title'),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class GlobalDrawer extends StatefulWidget {
  @override
  _GlobalDrawerState createState() => _GlobalDrawerState();
}

class _GlobalDrawerState extends State<GlobalDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 170.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0, 0.0),
                end: Alignment(1.0, 0.0),
                colors: [const Color(0xFF6aa6f8), const Color(0xFF1a60be)],
              ),
            ),
            child: DrawerHeader(
              child: Row(
                children: [
                  new Container(
                    margin: EdgeInsets.only(
                      right: 15.0,
                    ),
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                          ImagesLinks.logoLink,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            'Welcome back, User',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            'How can we help you today?',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xAAFFFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {},
          ),
          // ListTile(
          //   leading: Icon(Icons.favorite_border),
          //   title: Text('My Health'),
          //   onTap: () {},
          // ),
          // ListTile(
          //   leading: Icon(Icons.star),
          //   title: Text('Top Doctors'),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}

Widget sectionTitle(String title) {
  return Container(
    margin: const EdgeInsets.only(
      top: 20.0,
      left: 20.0,
      right: 20.0,
      bottom: 20.0,
    ),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF4894e9),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: Divider(
            color: Colors.black12,
            height: 1,
            thickness: 1,
          ),
        ),
      ],
    ),
  );
}
