import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseTest extends StatefulWidget{
DatabaseTest({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _DatabaseTestState createState() => _DatabaseTestState();
}

class _DatabaseTestState extends State<DatabaseTest>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista veicoli e vendite')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Oggetti').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.nome),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.nome),
          trailing: Text(record.vendite.toString()),

          onTap: () => Firestore.instance.runTransaction((transaction) async {
            final freshSnapshot = await transaction.get(record.reference);
            final fresh = Record.fromSnapshot(freshSnapshot);

            await transaction
                .update(record.reference, {'vendite': fresh.vendite + 1000});
          }),
        ),
      ),
    );
  }
}

class Record {
  final String nome;
  final int vendite;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['nome'] != null),
        assert(map['vendite'] != null),
        nome = map['nome'],
        vendite = map['vendite'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$nome:$vendite>";
}