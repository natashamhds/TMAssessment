import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tm_assessment/constant/config.dart';
import 'package:tm_assessment/constant/widgets.dart';
import 'package:tm_assessment/model/choc_model.dart';
import 'package:tm_assessment/services/service_locator.dart';
import 'package:tm_assessment/view%20model/home_viewmodel.dart';

class FilterByChoc extends StatefulWidget {
  FilterByChoc({super.key});

  @override
  State<FilterByChoc> createState() => _FilterByChocState();
}

class _FilterByChocState extends State<FilterByChoc> {

  HomeViewModel viewModel = serviceLocator<HomeViewModel>();

  @override
  void initState() {
    super.initState();

    setState(() {
      viewModel.isLoading = true;  
    });

    Future.delayed(Duration.zero, () {
      viewModel.getListData(context);
    }).then((value) {

      setState(() {
        viewModel.isLoading = false;
      });
      
      viewModel.displayChocController.text = viewModel.listChoc[0].title;
      viewModel.valueChocController.text = viewModel.listChoc[0].value;
    }).onError((error, stackTrace) {

      setState(() {
        viewModel.isLoading = false;
      });
    });

    viewModel.filterDataChoc(context, viewModel.valueChocController.text);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.displayChocController.dispose();
    viewModel.valueChocController.dispose();

    viewModel.chocVolume.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => SafeArea(
          top: true, bottom: false, left: false, right: false,
          child: ColoredBox(color: Colors.white,
          child: viewModel.isLoading ? Center(child: CircularProgressIndicator(color: Colors.green)) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // month form
              _choc(viewModel.listChoc),

              // graph
              _graph(),

              // top5
              _top5()
            ],
          ) 
          ),
        ),
      ),
    );
  }

  Widget _top5() {
    return Column( 
      children: [
        ...viewModel.chocVolume.map((e) => Column(
          children: [
            ListTile(
              minLeadingWidth: 0,
              minVerticalPadding: 0,
              title: Text(e.title),
              trailing: Text(e.value)
            ),
            const GlobalDivider()
          ],
        )).toList(),
      ],
    );
  }

  Widget _choc(List<GlobalDualValue> choc) {
    List<Widget> bottomSheetContent = [
      ...choc.map((e) => ListTile(
        minLeadingWidth: 0,
        minVerticalPadding: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: e.value == viewModel.valueChocController.text ? const GlobalRadioButtonCheck(title: "Chocolate") : const GlobalRadioButton()),
          onTap: () {
            setState(() {
              viewModel.displayChocController.text = e.title;
              viewModel.valueChocController.text = e.value;

              viewModel.filterDataChoc(context, viewModel.valueChocController.text);
            });
            Navigator.pop(context);
          },
          title: Text(e.title),
      )).toList()
    ];

    return GlobalForm(
      typeInput: "1", 
      controller: viewModel.displayChocController, 
      title: "Chocolate", isReadOnly: true, 
      ontap: () => GlobalWidget().modalBottom(context, listTile: bottomSheetContent, title: "Options"));
  }

  Widget _graph() {
    List<ChartDataChoc> chartData = viewModel.chocVolume.map((e) => ChartDataChoc(e.title, int.parse(e.value))).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),  
        gradient: const LinearGradient(colors: [
          Color(0xFFE1BEE7), 
          Color.fromARGB(255, 126, 49, 173),
          Color.fromARGB(255, 126, 49, 173), 
          Color.fromARGB(255, 126, 49, 173)
        ],
        stops: [0.0, 0.3, 0.7, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
        )),
        margin: const EdgeInsets.only(right: 5),
        child: SfCartesianChart(
          key: UniqueKey(),
        plotAreaBorderColor: Colors.transparent,
        primaryXAxis: const CategoryAxis(
          axisLine: AxisLine(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(width: 0),
          labelStyle: TextStyle(color: Colors.white),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(width: .5),
          labelStyle: const TextStyle(color: Colors.white),
          axisLine: const AxisLine(width: 0),
          numberFormat: NumberFormat.compact(),
        ),
        legend: const Legend(
          textStyle: TextStyle(color: Colors.white),
          position: LegendPosition.bottom,
          isVisible: true,
        ),
        title: ChartTitle(text: "Chocolate Sales", textStyle: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        enableAxisAnimation: true,
        tooltipBehavior: TooltipBehavior(enable: true),
          series: <SplineAreaSeries<ChartDataChoc, String>>[
          SplineAreaSeries(
            markerSettings: const MarkerSettings(isVisible: true),
            name: "Volume",
            color: Colors.pink.withOpacity(0.5),
            borderColor: Colors.pink,
            borderWidth: 2,
            dataSource: chartData,
            xValueMapper: (ChartDataChoc data, _) => data.month,
            yValueMapper: (ChartDataChoc data, _) => data.volume,
            enableTooltip: true,
          ),
        ]
      )),
    );
  }
}