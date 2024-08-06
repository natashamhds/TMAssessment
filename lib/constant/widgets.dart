import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tm_assessment/constant/responsive.dart';

class GlobalWidget {
  RoundedRectangleBorder borderDialog() {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)));
  }

  BoxDecoration bottomsheetdeco() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10))
    );
  }

  Widget iconsheet() {
    return Icon(Icons.horizontal_rule_rounded,
        size: 40, color: Colors.grey[400]);
  }

  Widget headerMenu(context, String title) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 20, right: 10),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
          InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              },
              child: const Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Icon(Icons.close)))
        ],
      ),
    );
  }

   /// Global show modal bottom sheet
  modalBottom(BuildContext contexts, {required String title, required List<Widget> listTile}){
    return showModalBottomSheet(
      context: contexts,
        useSafeArea: true,
        shape: GlobalWidget().borderDialog(),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext context) => Container(
          margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
          child: InkWell(
            onTap: ()=> Navigator.pop(context),
            child: DecoratedBox(
              decoration: GlobalWidget().bottomsheetdeco(),
              child: ListView(
                shrinkWrap: true,
                children: [
                  GlobalWidget().iconsheet(),
            
                  GlobalWidget().headerMenu(context, title),
            
                  ...listTile,
            
                  const SizedBox(height: 30)
                ],
              ),
            ),
          ),
        )
    );
  }

  Future popup(BuildContext context, {
    required String title,
    required String msg,
    required ContentType contentType
    }) async {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AwesomeSnackbarContent(title: title, message: msg, contentType: contentType), 
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0
    ));
    }
}

/// radio button check
class GlobalRadioButtonCheck extends StatelessWidget {
  const GlobalRadioButtonCheck({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.radio_button_checked, color: title == "Chocolate" ?Colors.purple.shade200 : Colors.pink.shade200, size: 20);
  }
}

/// default radio button
class GlobalRadioButton extends StatelessWidget {
  const GlobalRadioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.brightness_1_outlined,
        color: Colors.grey, size: 18);
  }
}

/// reuse for form: CRUD
class GlobalForm extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String typeInput;
  final GestureTapCallback? ontap;
  final bool isReadOnly;
  const GlobalForm(
      {super.key,
      required this.typeInput,
      required this.controller,
      required this.title,
      required this.isReadOnly,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
          left: 15,
          right: 10),
      title: Text(title,
          style: GoogleFonts.poppins(textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveWidget.isLargeScreen(context) ? 8.sp : 16.sp))),
      subtitle: Column(
        
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
              onTap: ontap,
              readOnly: isReadOnly ? true : false,
              validator: (e) => e!.isEmpty ? 'Cannot empty' : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              keyboardType: typeInput == "0"
                  ? const TextInputType.numberWithOptions(
                      signed: true, decimal: true)
                  : TextInputType.emailAddress,
              style:  GoogleFonts.poppins(textStyle: TextStyle(
            fontSize: ResponsiveWidget.isLargeScreen(context) ? 7.5.sp : 15.5.sp)),
              minLines: 1,
              maxLines: null,

              /// set isReadOnly == false if ontap is null
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                suffixIcon: isReadOnly
                    ? Icon(Icons.chevron_right, color: Colors.pink.shade200)
                    : Transform.scale(
                        scale: .4,
                        child:
                        const Icon(Icons.edit)),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              )),
          const Divider(height: 0, color: Colors.black26, endIndent: 10),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}

/// reuse for red button
class GlobalRedButton extends StatelessWidget {
  final String title;
  final GestureTapCallback ontap;
  const GlobalRedButton({super.key, required this.title, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(
            bottom: 15,
            left: 20,
            right: 20,
            top: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 13),
              backgroundColor: const Color(0xffff0000),
              minimumSize: Size(MediaQuery.sizeOf(context).width * .9, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80))),
          onPressed: ontap,
          child: Text(title)
        ),
      ),
    );
  }
}

/// line divider
class GlobalDivider extends StatelessWidget {
  const GlobalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(indent: 20, endIndent: 20, height: 0);
  }
}

// ignore: must_be_immutable
class chocTile extends StatelessWidget {
  String title;
  List list;
  Widget? leadingImage;

  chocTile({super.key, required this.title, required this.list});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          ...list.map((e) => Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: title == "FilterByChoc" ?  Colors.purple.shade200 : Colors.pink.shade200,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(10.0),
                    ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.pink.shade200.withOpacity(0.6),
                      blurRadius: 8.0,
                      offset: const Offset(1.1, 4.0)
                      )
                  ]
                ),
                child: ListTile(
                  minLeadingWidth: 0,
                  minVerticalPadding: 0,
                  title: Text(e.title, style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                  trailing: Text(e.value, style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: ResponsiveWidget.isLargeScreen(context) ? 9.sp : 14.sp))),
                ),
              ),
              const GlobalDivider()
            ],
          )).toList()
        ],
      ),
    );
  }
  }
