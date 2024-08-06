import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tm_assessment/services/service_locator.dart';
import 'package:tm_assessment/view%20model/home_viewmodel.dart';
import 'package:tm_assessment/view/Home%20Screen/choc_screen.dart';
import 'package:tm_assessment/view/Home%20Screen/month_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeViewModel viewModel = serviceLocator<HomeViewModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar(),
        body: buildUi(viewModel)
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      leading: const Icon(IconlyLight.category, color: Colors.black, size: 19),
      centerTitle: true,
      title: Text("Products", style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500)))
    );
  }

  Widget buildUi(HomeViewModel viewModel) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => SafeArea(
          top: true, bottom: false, left: false, right: false,
          child: Stack(
            children: [
             Padding(
                padding: const EdgeInsets.all(12.0),
                child: SegmentedTabControl(tabs: [
                  SegmentTab(label: "Month", color: Colors.pink.shade200),
                  SegmentTab(label: "Choc Type", color: Colors.purple.shade200)
                ],
                textStyle: GoogleFonts.poppins(textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                tabTextColor: Colors.black45,
                selectedTabTextColor: Colors.white,
                tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                squeezeIntensity: 2,
                height: 45,
                barDecoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(40)
                ),
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: TabBarView(children: [
                  FilterByMonth(),
          
                  FilterByChoc()
                ]),
              )
            ],
          ),
        )
        ),
      );
  }
}