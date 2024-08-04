import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class GlobalWidget {
  RoundedRectangleBorder borderDialog() {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)));
  }

  BoxDecoration bottomsheetdeco() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
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
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
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
        builder: (BuildContext context) => InkWell(
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
    return Icon(Icons.radio_button_checked, color: title == "Chocolate" ?Colors.purple.shade200 : Colors.pink.shade200, size: 18);
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
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13)),
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
              style: const TextStyle(
                  color: Colors.black,
                  fontSize:
                      13),
              minLines: 1,
              maxLines: null,

              /// set isReadOnly == false if ontap is null
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                suffixIcon: isReadOnly
                    ? const Icon(Icons.chevron_right)
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