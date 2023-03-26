import 'package:example/showcase_app/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
// import 'package:flutter_highlight/themes/xcode.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';

int selectedIndex = 0;

//ignore: must_be_immutable
class HomePage extends StatefulWidget {
  int selectedItem = 0;
  HomePage({super.key, required this.selectedItem});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showCaseIsOpen = true;
  bool playgroundIsOpen = true;
  @override
  Widget build(BuildContext context) {
    bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return Scaffold(
        appBar: const MainHeader(),
        backgroundColor: Colors.white,
        body: Row(
          children: [
            if (!displayMobileLayout)
              Container(
                margin: const EdgeInsets.all(8),
                child: Drawer(
                  elevation: 0,
                  width: 250,
                  // backgroundColor: Color(0xfff5f8fa),
                  backgroundColor: Colors.white,
                  child: ListView(
                    children: [
                      ExpansionPanelList(
                        expandedHeaderPadding: EdgeInsets.all(0),
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            showCaseIsOpen = !showCaseIsOpen;
                          });
                        },
                        children: [
                          ExpansionPanel(
                            backgroundColor: Color(0xfff5f8fa),
                            canTapOnHeader: true,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) =>
                                    const ShowCaseHeader(),
                            body: showCaseListView(),
                            isExpanded: showCaseIsOpen,
                          ),
                        ],
                      ),
                      ExpansionPanelList(
                        expandedHeaderPadding: const EdgeInsets.all(0),
                        expansionCallback: (panelIndex, isExpanded) {
                          setState(() {
                            playgroundIsOpen = !playgroundIsOpen;
                          });
                        },
                        children: [
                          ExpansionPanel(
                              backgroundColor: const Color(0xfff5f8fa),
                              headerBuilder:
                                  (BuildContext context, isExpanded) =>
                                      const ListTile(
                                        minLeadingWidth: 10,
                                        title: Text("PlayGround"),
                                      ),
                              body: showCasePlaygroundView(),
                              isExpanded: playgroundIsOpen)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            SizedBox(
              width: displayMobileLayout ? null : 2,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                ),
                margin: displayMobileLayout ? null : const EdgeInsets.all(10),
                child: Scaffold(
                  appBar: AppBar(
                    iconTheme:
                        const IconThemeData().copyWith(color: Colors.black),
                    elevation: 0,
                    centerTitle: false,
                    title: Text(
                      menuItems[selectedIndex].title,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    automaticallyImplyLeading:
                        displayMobileLayout ? true : false,
                    backgroundColor: Colors.white,
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.code_outlined),
                        tooltip: 'Source Code',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('This is a snackbar')));
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => Container(
                                child: AlertDialog(
                                  backgroundColor: Colors.white,
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Close'))
                                  ],
                                  content: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: menuItems[selectedIndex].widget),
                                ),
                              ),
                            );

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             linearGaugeUseCases[selectedIndex]
                            //                 ["widget"]));
                          },
                          icon: const Icon(Icons.fullscreen_exit_rounded)),
                      IconButton(
                          onPressed: () async {
                            String sourceCode = await rootBundle
                                .loadString('assets/random_code.dart');

                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => Container(
                                child: AlertDialog(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Source Code'),
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                text: sourceCode));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Code copied to clipboard'),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.copy_rounded),
                                          label: Text("copy"))
                                    ],
                                  ),
                                  content: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: SingleChildScrollView(
                                      child: Container(
                                        color: Colors.red,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child:
// WidgetWithCodeView()

                                            HighlightView(
                                          textStyle: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                            // color: Colors.black,
                                          ),
                                          sourceCode,
                                          tabSize: 2,
                                          language: 'dart',
                                          theme: atomOneDarkTheme,
                                          // theme: gaugesTheme,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.source_outlined))
                    ],
                  ),
                  drawer: displayMobileLayout
                      ? Drawer(
                          child: ListView(
                            children: [
                              ExpansionPanelList(
                                children: [
                                  ExpansionPanel(
                                    headerBuilder: (BuildContext context,
                                            bool isExpanded) =>
                                        const ListTile(
                                      leading: Icon(
                                        Icons.linear_scale_outlined,
                                        color: Colors.red,
                                      ),
                                      title: Text(
                                        'Linear Gauge',
                                      ),
                                    ),
                                    body: MobileDrawerList(
                                      onSelected: (i) {
                                        setState(() {
                                          selectedIndex = i;
                                        });
                                      },
                                    ),
                                    isExpanded: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : null,
                  body: menuItems[selectedIndex].widget,
                ),
              ),
            )
          ],
        ));
  }

  Widget showCasePlaygroundView() {
    return PlayGroundList(
      onSelected: (i) {
        setState(() {
          selectedIndex = i;
        });
      },
    );
  }

  Widget showCaseListView() {
    return ShowCaseList(
      onSelected: (i) {
        setState(() {
          selectedIndex = i;
        });
      },
    );
  }
}

class ShowCaseHeader extends StatelessWidget {
  const ShowCaseHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: Icon(
        Icons.linear_scale_outlined,
      ),
      minLeadingWidth: 10,
      title: Text(
        'Linear Gauge',
      ),
    );
  }
}

class MainHeader extends StatelessWidget with PreferredSizeWidget {
  const MainHeader({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,

      centerTitle: false,
      title: const Text(
        " Flutter Gauges",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
      // backgroundColor: Color(0xfff5f8fa),
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              icon: const FlutterLogo(),
              label: const Text("Get Package")),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

class ShowCaseList extends StatelessWidget {
  final Function(int) onSelected;
  const ShowCaseList({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic> useCases =
        menuItems.where((item) => item.type == 'UseCase').toList();

    return Column(
      children: [
        for (var i = 0; i < useCases.length; i++)
          DrawerListTile(onSelected: onSelected, index: i),
      ],
    );
  }
}

class PlayGroundList extends StatelessWidget {
  final Function(int) onSelected;
  const PlayGroundList({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic> useCases =
        menuItems.where((item) => item.type == 'UseCase').toList();
    List<dynamic> playgroundList =
        menuItems.where((item) => item.type == 'API').toList();

    return Column(
      children: [
        for (var i = 0; i < playgroundList.length; i++)
          DrawerListTile(onSelected: onSelected, index: useCases.length + i),
      ],
    );
  }
}

class MobileDrawerList extends StatelessWidget {
  final Function(int) onSelected;
  const MobileDrawerList({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < menuItems.length; i++)
          DrawerListTile(onSelected: onSelected, index: menuItems[i].index),
      ],
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.onSelected,
    required this.index,
  });
  final int index;
  final Function(int p1) onSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      autofocus: true,
      selectedTileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      dense: true,
      selected: index == selectedIndex ? true : false,
      hoverColor: Colors.red.withOpacity(0.1),
      selectedColor: Colors.red,
      onTap: () {
        onSelected(index);
      },
      title: Text(
        menuItems[index].title,
      ),
    );
  }
}

Color getBackgroundColor(int index) {
  if (selectedIndex == index) {
    return Colors.red;
  } else {
    return Colors.white;
  }
}

Color getTextColor(int index) {
  if (selectedIndex == index) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}
