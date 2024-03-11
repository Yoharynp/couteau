import 'package:couteau/Screens/Inicio/menu_provider.dart';
import 'package:couteau/Widgets/elementos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenuScreen extends StatefulWidget {
  final ValueChanged<int>? onSelectionChanged;
  const SideMenuScreen({
    super.key,
    this.onSelectionChanged,
  });

  @override
  State<SideMenuScreen> createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 288,
            height: double.infinity,
            color: Colors.blueGrey[900],
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Couteau Menu',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    indent: 10,
                    color: Colors.white,
                    thickness: 2,
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Buscador',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 20)),
                        ],
                      )),
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: elementos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                            Provider.of<MenuIndexProvider>(context, listen: false)
                                .setIndex(index);
                            if (widget.onSelectionChanged != null) {
                              widget.onSelectionChanged!(index);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            width: 288,
                            height: 50,
                            child: Stack(
                              children: [
                                elementos[index],
                                AnimatedContainer(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 11),
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  width: _selectedIndex == index ? 288 : 0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue.withOpacity(0.5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}