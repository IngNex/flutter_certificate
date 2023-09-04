import 'package:flutter/material.dart';


class DataTableDemo extends StatefulWidget {
  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  final List<int> _selectedRows = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PaginatedDataTable with Selection'),
      ),
      body: PaginatedDataTable(
        columns: [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Age')),
        ],
        source: MyDataTableSource(
          selectedRows: _selectedRows,
        ),
        header: Text('Sample Data Table'),
        rowsPerPage: 5,
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<int> selectedRows;

  MyDataTableSource({required this.selectedRows});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      onSelectChanged: (isSelected) {
        

        if (isSelected != null) {
          _handleRowSelection(isSelected, index);
      };},
      cells: [
        DataCell(Text('Name $index')),
        DataCell(Text('Age $index')),
      ],
      selected: selectedRows.contains(index),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => selectedRows.length;

  void _handleRowSelection(bool isSelected, int rowIndex) {
    
      if (isSelected) {
        selectedRows.add(rowIndex);
      } else {
        selectedRows.remove(rowIndex);
      }
    notifyListeners();
  }

  // void setState(VoidCallback fn) {
  //   // Esto es necesario para poder utilizar setState en una clase no estatal.
  //   // En una aplicación Flutter completa, esto sería manejado por un StatefulWidget
  //   // o un mecanismo de gestión de estado apropiado.
  //   fn();
  // }
}