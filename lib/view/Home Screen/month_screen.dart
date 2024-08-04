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

class FilterByMonth extends StatefulWidget {
  FilterByMonth({super.key});

  @override
  State<FilterByMonth> createState() => _FilterByMonthState();
}

class _FilterByMonthState extends State<FilterByMonth> {

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

      viewModel.filterDataMonth(context, viewModel.valueMonthController.text);
      viewModel.displayMonthController.text = viewModel.formattedPrevMonth;
      viewModel.valueMonthController.text = viewModel.getValueForMonth(viewModel.formattedPrevMonth);
    }).onError((error, stackTrace) {

      setState(() {
        viewModel.isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.displayMonthController.dispose();
    viewModel.valueMonthController.dispose();

    viewModel.top5Choc.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => SafeArea(
          top: true, bottom: false, left: false, right: false,
          child: ColoredBox(color: Color(0xFFFFFFFF),
          child: viewModel.isLoading ? Center(child: CircularProgressIndicator(color: Colors.green)) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // month form
              _month(viewModel.listMonth),

              // graph
              _graph(),

              const SizedBox(height: 20),
              
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
    return chocTile(title: "FilterByMonth", list: viewModel.top5Choc);
  }

  Widget _month(List<GlobalDualValue> month) {
    List<Widget> bottomSheetContent = [
      ...month.map((e) => ListTile(
        minLeadingWidth: 0,
        minVerticalPadding: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: e.value == viewModel.valueMonthController.text ? const GlobalRadioButtonCheck(title: "Month",) : const GlobalRadioButton()),
          onTap: () {
            setState(() {
              viewModel.displayMonthController.text = e.title;
              viewModel.valueMonthController.text = e.value;

              viewModel.filterDataMonth(context, viewModel.valueMonthController.text);
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
    List<ChartData> chartData = viewModel.top5Choc.map((e) => ChartData(e.title, int.parse(e.value))).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromARGB(255, 126, 49, 173).withOpacity(0.6),
              blurRadius: 8.0,
              offset: const Offset(1.1, 4.0)
            )
          ],
          borderRadius: BorderRadius.circular(20),  
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
        title: ChartTitle(text: "Top 5 Chocolates", textStyle: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        enableAxisAnimation: true,
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <SplineAreaSeries<ChartData, String>>[
          SplineAreaSeries(
            markerSettings: const MarkerSettings(isVisible: true),
            name: "Volume",
            color: Colors.pink.withOpacity(0.5),
            borderColor: Colors.pink,
            borderWidth: 2,
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.chocolateType,
            yValueMapper: (ChartData data, _) => data.volume,
            enableTooltip: true,
          ),
        ],
      
      )),
    );
  }
}