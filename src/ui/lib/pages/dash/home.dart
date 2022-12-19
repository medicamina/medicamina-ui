import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:medicamina/pages/dash/map/choropleth_map.dart';
import 'package:medicamina/globals.dart' as globals;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (900 > MediaQuery.of(context).size.width) {
      return mobile(context);
    }
    return desktop(context);
  }
}

Widget _map(BuildContext context) {
  return Expanded(
    child: Card(
      semanticContainer: true,
      child: Column(
        children: const [
          ListTile(
            title: Text(
              'Your ancestry',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 32)),
          ChoroplethMap(),
          Padding(padding: EdgeInsets.only(bottom: 32)),
        ],
      ),
    ),
  );
}

Widget _personalDetails(BuildContext context) {
  return Expanded(
    child: Card(
      child: Column(
        children: const [
          ListTile(
            title: Text(
              'Personal details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // trailing: IconButton(
            //   icon: const Icon(Icons.more_vert),
            //   onPressed: () {},
            // ),
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Name'),
            subtitle: Text("Jake Spencer Walklate"),
          ),
          ListTile(
            leading: Icon(CommunityMaterialIcons.gender_male_female),
            title: Text('Gender'),
            subtitle: Text('M'),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text('Birthdate'),
            subtitle: Text('26 Jun 1997'),
          ),
          ListTile(
            leading: Icon(Icons.bloodtype),
            title: Text('Blood type'),
            subtitle: Text('O+'),
          ),
          ListTile(
            leading: Icon(Icons.height),
            title: Text('Height'),
            subtitle: Text('5"5\' [165cm]'),
          ),
          ListTile(
            leading: Icon(Icons.scale),
            title: Text('Weight'),
            subtitle: Text("132lb [60kg]"),
          ),
        ],
      ),
    ),
  );
}

class ResultsTable extends StatefulWidget {
  const ResultsTable({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ResultsTableState();
}

class _ResultsTableState extends State<ResultsTable> {
  String _searchTerm = '';
  int _defaultRowsPerPage = 4;
  late int _rowsPerPage;

  @override
  void initState() {
    super.initState();
    setState(() {
      _rowsPerPage = _defaultRowsPerPage;
    });
  }

  void updateSearch(val) {
    setState(() {
      _searchTerm = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                    suffixIcon: Padding(padding: EdgeInsets.only(right: 12), child: Icon(Icons.search)),
                  ),
                  onChanged: updateSearch,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: PaginatedDataTable(
                      sortColumnIndex: 1,
                      source: ResultsData(context: context, search: _searchTerm),
                      columns: [
                        DataColumn(
                          label: Expanded(
                            flex: 1,
                            child: Text(
                              'Condition',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            flex: 1,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Text(
                                  'Risk',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      columnSpacing: constraints.maxWidth * 0.45,
                      rowsPerPage: _rowsPerPage,
                      availableRowsPerPage: const <int>[4, 8, 12, 16],
                      onRowsPerPageChanged: (rows) {
                        setState(() {
                          _rowsPerPage = rows!;
                        });
                      },
                      showCheckboxColumn: false,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultsData extends DataTableSource {
  ResultsData({required this.context, required this.search});

  String? search;
  BuildContext context;

  // Generate some made-up data
  final List<Map<String, dynamic>> _data = [
    {
      'condition': "A1AT deficiency",
      'risk': "High",
      'alt_names': [
        'Alpha One antitrypsin deficiency',
        'Alpha 1 antitrypsin deficiency',
      ]
    },
    {
      'condition': "Type 2 diabetes",
      'risk': "Medium",
      'alt_names': [
        'Adult onset diabetes',
        'Adult-onset diabetes',
      ]
    },
    {'condition': "Cystic fibrosis", 'risk': "Low", 'alt_names': []},
    {'condition': "Latex allergy", 'risk': "Low", 'alt_names': []},
    {'condition': "Tachycardia", 'risk': "Low", 'alt_names': []},
    {'condition': "Latex allergy", 'risk': "Low", 'alt_names': []},
    {'condition': "Tachycardia", 'risk': "Low", 'alt_names': []},
    {'condition': "Latex allergy", 'risk': "Low", 'alt_names': []},
    {'condition': "Tachycardia", 'risk': "Low", 'alt_names': []},
    {'condition': "Latex allergy", 'risk': "Low", 'alt_names': []},
    {'condition': "Tachycardia", 'risk': "High", 'alt_names': []},
    {'condition': "Latex allergy", 'risk': "Low", 'alt_names': []},
    {'condition': "Tachycardia", 'risk': "Medium", 'alt_names': []},
    {'condition': "Latex allergy", 'risk': "Low", 'alt_names': []},
    {'condition': "Tachycardia", 'risk': "Low", 'alt_names': []},
  ];

  List<Map<String, dynamic>> _searchedData = [];

  int initSearchedData() {
    if (search!.isEmpty == true) {
      _searchedData = _data;
      return _searchedData.length;
    }

    for (var i = 0; i < _data.length; i++) {
      if (_data[i]['condition'].toLowerCase().contains(search!.toLowerCase())) {
        _searchedData.add(_data[i]);
      }
      for (var j = 0; j < _data[i]['alt_names'].length; j++) {
        if (_data[i]['alt_names'][j].toLowerCase().contains(search!.toLowerCase())) {
          _searchedData.add(_data[i]);
        }
      }
    }
    return _searchedData.length;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => initSearchedData();

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            _searchedData[index]['condition'].toString(),
            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).textTheme.caption!.color),
          ),
        ),
        DataCell(
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                _searchedData[index]['risk'],
                style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).textTheme.caption!.color),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget mobile(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          Row(
            children: [_map(context)],
          ),
          Row(
            children: [_personalDetails(context)],
          ),
          Row(
            children: const [
              ResultsTable(),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget desktop(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          Row(
            children: [
              _map(context),
              _personalDetails(context),
            ],
          ),
          Row(
            children: const [
              ResultsTable(),
            ],
          ),
        ],
      ),
    ),
  );
}
