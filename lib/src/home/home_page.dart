import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController editController;
  late TextEditingController textController;
  final homeStore = HomeStore();
  final Uri _url = Uri.parse('https://google.com');

  @override
  void initState() {
    editController = TextEditingController();
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    editController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Observer(
            builder: (_) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: homeStore.items.isEmpty
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Insara um valor',
                              textAlign: TextAlign.center,
                            ),
                            Icon(Icons.arrow_downward_outlined)
                          ],
                        )
                      : ListView.separated(
                          itemCount: homeStore.items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                editController.text =
                                    homeStore.items[index].description;
                                setState(() {});
                                _editDialog(index);
                              },
                              title: Text(homeStore.items[index].description),
                              trailing: IconButton(
                                onPressed: () {
                                  _removeDialog(index);
                                },
                                icon: const Icon(Icons.delete_outline),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Divider(
                                height: 0,
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              autofocus: true,
              controller: textController,
              focusNode: _focusNode,
              onFieldSubmitted: (value) {
                homeStore.addItem(textController.text);
                textController.clear();
                FocusScope.of(context).requestFocus(_focusNode);
              },
              decoration: const InputDecoration(
                hintText: 'Digite seu texto',
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }
            },
            child: const Text('Politica de Privacidade'),
          ),
        ],
      ),
    );
  }

  Future<void> _editDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  onFieldSubmitted: (e) {
                    homeStore.editItem(index, e);
                    editController.clear();
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  controller: editController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Editar'),
              onPressed: () {
                homeStore.editItem(index, editController.text);
                editController.clear();
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _removeDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tem certeza disso?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Não será possivel reverter.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Apagar'),
              onPressed: () {
                homeStore.removeItem(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
