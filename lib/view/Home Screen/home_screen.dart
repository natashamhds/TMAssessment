import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tm_assessment/constant/config.dart';
import 'package:tm_assessment/constant/widgets.dart';
import 'package:tm_assessment/model/choc_model.dart';
import 'package:tm_assessment/services/service_locator.dart';
import 'package:tm_assessment/view%20model/home_viewmodel.dart';

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

    Future.delayed(Duration.zero, () {
      viewModel.getListData(context);
      /// TODO: buat latest month as first load
    }).then((value) {
      /// TODO: stop loading

    }).onError((error, stackTrace) {
      /// TODO: stop loading

    });
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.displayMonthController.dispose();
    viewModel.valueMonthController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildUi(viewModel)
    );
  }

  Widget buildUi(HomeViewModel viewModel) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: ColoredBox(color: Colors.white,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // chocolate type
                  // _chocType(viewModel.listChoc),

                  // month form
                  _month(viewModel.listMonth),

                  // graph
                  _graph(),

                  // TODO: list top 5
                  Label(title: "Top 5 Products")
                  // ListTile
                  
                ],
              )
            )
            ),
          )
          )
        ),
      );
  }

  Widget _month(List<GlobalDualValue> month) {
    List<Widget> bottomSheetContent = [
      ...month.map((e) => ListTile(
        minLeadingWidth: 0,
        minVerticalPadding: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: e.value == viewModel.valueMonthController.text ? const GlobalRadioButtonCheck() : const GlobalRadioButton()),
          onTap: () {
            setState(() {
              viewModel.displayMonthController.text = e.title;
              viewModel.valueMonthController.text = e.value;

              viewModel.getAllData(context);
            });
            Navigator.pop(context);
          },
          title: Text(e.title),
      )).toList()
    ];

    return GlobalForm(
      typeInput: "1", 
      controller: viewModel.displayMonthController, 
      title: "Month", isReadOnly: true, 
      ontap: () => GlobalWidget().modalBottom(context, listTile: bottomSheetContent, title: "Options"));
  }

  Widget _graph() {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      margin: const EdgeInsets.only(right: 5),
      child: SfCartesianChart(
        key: UniqueKey(),
      plotAreaBorderColor: Colors.transparent,
      primaryXAxis: const CategoryAxis(
        axisLine: AxisLine(width: 0),
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        majorTickLines: const MajorTickLines(width: .5),
        axisLine: const AxisLine(width: 0),
        numberFormat: NumberFormat.compact(),
      ),
      legend: const Legend(
        position: LegendPosition.bottom,
        isVisible: true,
      ),
      enableAxisAnimation: true,
      series: <StackedLineSeries<ChocVolume, String>>[
        /// Flake
        StackedLineSeries<ChocVolume, String>(
          markerSettings: const MarkerSettings(isVisible: true),
          name: "Flake",
          dataSource: <ChocVolume>[
            ChocVolume(viewModel.listMonth[0].title, 1),
            ChocVolume(viewModel.listMonth[1].title, 2),
            ChocVolume(viewModel.listMonth[2].title, 3),
            ChocVolume(viewModel.listMonth[3].title, 4),
            ChocVolume(viewModel.listMonth[4].title, 5),
            ChocVolume(viewModel.listMonth[5].title, 6),
            ChocVolume(viewModel.listMonth[6].title, 7)
          ],
          xValueMapper: (ChocVolume month, _) => month.month, 
          yValueMapper: (ChocVolume month, _) => month.volume,
          enableTooltip: true,
          ),
          
          /// Caramel
          StackedLineSeries<ChocVolume, String>(
          markerSettings: const MarkerSettings(isVisible: true),
          name: "Caramel",
          /// Flake
          dataSource: <ChocVolume>[
            ChocVolume(viewModel.listMonth[0].title, 1),
            ChocVolume(viewModel.listMonth[1].title, 2),
            ChocVolume(viewModel.listMonth[2].title, 3),
            ChocVolume(viewModel.listMonth[3].title, 4),
            ChocVolume(viewModel.listMonth[4].title, 5),
            ChocVolume(viewModel.listMonth[5].title, 6),
            ChocVolume(viewModel.listMonth[6].title, 7)
          ],
          xValueMapper: (ChocVolume month, _) => month.month, 
          yValueMapper: (ChocVolume month, _) => month.volume,
          enableTooltip: true,
          ),

          /// Twirl
          StackedLineSeries<ChocVolume, String>(
          markerSettings: const MarkerSettings(isVisible: true),
          name: "Twirl",
          /// Flake
          dataSource: <ChocVolume>[
            ChocVolume(viewModel.listMonth[0].title, 1),
            ChocVolume(viewModel.listMonth[1].title, 2),
            ChocVolume(viewModel.listMonth[2].title, 3),
            ChocVolume(viewModel.listMonth[3].title, 4),
            ChocVolume(viewModel.listMonth[4].title, 5),
            ChocVolume(viewModel.listMonth[5].title, 6),
            ChocVolume(viewModel.listMonth[6].title, 7)
          ],
          xValueMapper: (ChocVolume month, _) => month.month, 
          yValueMapper: (ChocVolume month, _) => month.volume,
          enableTooltip: true,
          ),

          /// Wispa
          StackedLineSeries<ChocVolume, String>(
          markerSettings: const MarkerSettings(isVisible: true),
          name: "Wispa",
          dataSource: <ChocVolume>[
            ChocVolume(viewModel.listMonth[0].title, 1),
            ChocVolume(viewModel.listMonth[1].title, 2),
            ChocVolume(viewModel.listMonth[2].title, 3),
            ChocVolume(viewModel.listMonth[3].title, 4),
            ChocVolume(viewModel.listMonth[4].title, 5),
            ChocVolume(viewModel.listMonth[5].title, 6),
            ChocVolume(viewModel.listMonth[6].title, 7)
          ],
          xValueMapper: (ChocVolume month, _) => month.month, 
          yValueMapper: (ChocVolume month, _) => month.volume,
          enableTooltip: true,
          ),

          /// Chomp
          StackedLineSeries<ChocVolume, String>(
          markerSettings: const MarkerSettings(isVisible: true),
          name: "Chomp",
          dataSource: <ChocVolume>[
            ChocVolume(viewModel.listMonth[0].title, 1),
            ChocVolume(viewModel.listMonth[1].title, 2),
            ChocVolume(viewModel.listMonth[2].title, 3),
            ChocVolume(viewModel.listMonth[3].title, 4),
            ChocVolume(viewModel.listMonth[4].title, 5),
            ChocVolume(viewModel.listMonth[5].title, 6),
            ChocVolume(viewModel.listMonth[6].title, 7)
          ],
          xValueMapper: (ChocVolume month, _) => month.month, 
          yValueMapper: (ChocVolume month, _) => month.volume,
          enableTooltip: true,
          ),

          /// Fudge
          StackedLineSeries<ChocVolume, String>(
          markerSettings: const MarkerSettings(isVisible: true),
          name: "Fudge",
          dataSource: <ChocVolume>[
            ChocVolume(viewModel.listMonth[0].title, 1),
            ChocVolume(viewModel.listMonth[1].title, 2),
            ChocVolume(viewModel.listMonth[2].title, 3),
            ChocVolume(viewModel.listMonth[3].title, 4),
            ChocVolume(viewModel.listMonth[4].title, 5),
            ChocVolume(viewModel.listMonth[5].title, 6),
            ChocVolume(viewModel.listMonth[6].title, 7)
          ],
          xValueMapper: (ChocVolume month, _) => month.month, 
          yValueMapper: (ChocVolume month, _) => month.volume,
          enableTooltip: true,
          ),

          /// Crunchie
          StackedLineSeries<ChocVolume, String>(
          markerSettings: const MarkerSettings(isVisible: true),
          name: "Crunchie",
          dataSource: <ChocVolume>[
            ChocVolume(viewModel.listMonth[0].title, 1),
            ChocVolume(viewModel.listMonth[1].title, 2),
            ChocVolume(viewModel.listMonth[2].title, 3),
            ChocVolume(viewModel.listMonth[3].title, 4),
            ChocVolume(viewModel.listMonth[4].title, 5),
            ChocVolume(viewModel.listMonth[5].title, 6),
            ChocVolume(viewModel.listMonth[6].title, 7)
          ],
          xValueMapper: (ChocVolume month, _) => month.month, 
          yValueMapper: (ChocVolume month, _) => month.volume,
          enableTooltip: true,
          ),

          /// DoubleDecker
          StackedLineSeries<ChocVolume, String>(
          markerSettings: const MarkerSettings(isVisible: true),
          name: "Double Decker",
          dataSource: <ChocVolume>[
            ChocVolume(viewModel.listMonth[0].title, 1),
            ChocVolume(viewModel.listMonth[1].title, 2),
            ChocVolume(viewModel.listMonth[2].title, 3),
            ChocVolume(viewModel.listMonth[3].title, 4),
            ChocVolume(viewModel.listMonth[4].title, 5),
            ChocVolume(viewModel.listMonth[5].title, 6),
            ChocVolume(viewModel.listMonth[6].title, 7)
          ],
          xValueMapper: (ChocVolume month, _) => month.month, 
          yValueMapper: (ChocVolume month, _) => month.volume,
          enableTooltip: true,
          ),

          /// WispaGold
          StackedLineSeries<ChocVolume, String>(
          markerSettings: const MarkerSettings(isVisible: true),
          name: "Wispa Gold",
          dataSource: <ChocVolume>[
            ChocVolume(viewModel.listMonth[0].title, 1),
            ChocVolume(viewModel.listMonth[1].title, 2),
            ChocVolume(viewModel.listMonth[2].title, 3),
            ChocVolume(viewModel.listMonth[3].title, 4),
            ChocVolume(viewModel.listMonth[4].title, 5),
            ChocVolume(viewModel.listMonth[5].title, 6),
            ChocVolume(viewModel.listMonth[6].title, 7)
          ],
          xValueMapper: (ChocVolume month, _) => month.month, 
          yValueMapper: (ChocVolume month, _) => month.volume,
          enableTooltip: true,
          ),

          /// Picnic
          StackedLineSeries<ChocVolume, String>(
          markerSettings: const MarkerSettings(isVisible: true),
          name: "Picnic",
          dataSource: <ChocVolume>[
            ChocVolume(viewModel.listMonth[0].title, 1),
            ChocVolume(viewModel.listMonth[1].title, 2),
            ChocVolume(viewModel.listMonth[2].title, 3),
            ChocVolume(viewModel.listMonth[3].title, 4),
            ChocVolume(viewModel.listMonth[4].title, 5),
            ChocVolume(viewModel.listMonth[5].title, 6),
            ChocVolume(viewModel.listMonth[6].title, 7)
          ],
          xValueMapper: (ChocVolume month, _) => month.month, 
          yValueMapper: (ChocVolume month, _) => month.volume,
          enableTooltip: true,
          ),
      ],
      )
    );
  }
}