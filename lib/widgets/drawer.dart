import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).bottomAppBarColor,
      color: Theme.of(context).highlightColor,
      child: ListView(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(top: 15),
            leading: Container(
              height: 80.0,
              width: 80.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/Images/myPic.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            ),
            trailing: FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  QrImage(
                    data: 'https://github.com/Wasim-Zaman/daily_expenses',
                    version: QrVersions.auto,
                    size: 80,
                    gapless: false,
                  ),
                  const Text(
                    "Scan Me",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          ListTile(
            title: FittedBox(
              child: Text(
                "Wasim Zaman",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            subtitle: FittedBox(
              child: Text(
                "wasimxaman13@gmail.com",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ],
      ),
    );

    // return Drawer(
    //   // backgroundColor: Theme.of(context).primaryColor,

    //   child: ListView(
    //     children: [
    //       DrawerHeader(
    //         child: Column(
    //           children: [
    //             ListTile(
    //               leading: Container(
    //                 height: 80.0,
    //                 width: 80.0,
    //                 decoration: const BoxDecoration(
    //                   image: DecorationImage(
    //                     image: AssetImage('Assets/Images/myPic.png'),
    //                     fit: BoxFit.fill,
    //                   ),
    //                   shape: BoxShape.circle,
    //                 ),
    //               ),
    //               trailing: FittedBox(
    //                 child: Column(
    //                   children: <Widget>[
    //                     QrImage(
    //                       data: 'https://github.com/Wasim-Zaman/daily_expenses',
    //                       version: QrVersions.auto,
    //                       size: 80,
    //                       gapless: false,
    //                     ),
    //                     const Text(
    //                       "Scan Me",
    //                       style: TextStyle(fontSize: 13),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               height: MediaQuery.of(context).size.height * 0.01,
    //             ),
    //             const ListTile(
    //               title: Text(
    //                 "Wasim Zaman",
    //                 style: TextStyle(
    //                   fontSize: 30,
    //                 ),
    //               ),
    //               subtitle: Text("wasimxaman13@gmail.com"),
    //             )
    //           ],
    //         ),
    //       ),
    //       ListTile(
    //         leading: const Icon(Icons.color_lens),
    //         title: const Text('Select Theme'),
    //         onTap: () {},
    //         selected: true,
    //       ),
    //     ],
    //   ),
    // );
  }
}
