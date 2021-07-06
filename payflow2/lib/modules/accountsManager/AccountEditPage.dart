import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/shared/widgets/inputText/InputTextWidget.dart';

class AccountEditPage extends StatefulWidget {
  const AccountEditPage({Key? key}) : super(key: key);

  @override
  _AccountEditPageState createState() => _AccountEditPageState();
}

class _AccountEditPageState extends State<AccountEditPage> {
  String nomeCidade = "";
  var _cidades = ['Santos', 'Porto Alegre', 'Campinas', 'Rio de Janeiro'];
  var _itemSelecionado = 'Santos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova conta"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputTextWidget(
                label: "Nome da conta",
                icon: FontAwesomeIcons.wallet,
                onChanged: (txt) {}),
            Container(
              child: DropdownButton<String>(
                  items: _cidades.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _itemSelecionado = value!;
                    setState(() {});
                  },
                  value: _itemSelecionado),
            ),
          ],
        ),
      ),
    );
  }
}
