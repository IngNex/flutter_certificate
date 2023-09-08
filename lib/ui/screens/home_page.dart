import 'package:app_qr/ui/screens/pdf/widget/imprimir_pdf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qr/ui/models/user_models.dart';
import 'package:app_qr/ui/provider/api_provider.dart';
import 'package:app_qr/ui/screens/pdf/pdf_page.dart';

const List<String> list = ['nombre', 'dni', 'curso'];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool sort = true;
  int _currentSortColumn = 0;
  List<Certificate>? filterData;
  final List<int> _selectedRows = [];

  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getCertificados();
    filterData = apiProvider.certificate;

    super.initState();
  }

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    var certificate = apiProvider.certificate;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ESSAC | CERTIFICADOS'),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(milliseconds: 650), () {
              setState(() {
                final apiProvider =
                    Provider.of<ApiProvider>(context, listen: false);
                apiProvider.getCertificados();
              });
            });
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage('assets/images/logo-blanco.png'),
                          width: 120,
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 3,
                        color: Colors.red,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage('assets/images/brand.png'),
                          width: 120,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      // const Padding(
                      //   padding: EdgeInsets.symmetric(vertical: 8.0),
                      //   child: Text(
                      //     "CERTIFICADOS",
                      //     style: TextStyle(
                      //         fontSize: 25, fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      /* ======= Botones ======= */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Imprimir'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Eliminar'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Importar Excel'),
                          ),
                        ],
                      ),
                      /* Filtro*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'FILTRO',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54),
                            ),
                          ),
                          TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                                hintText: "Enter value to filter"),
                            onChanged: (value) {
                              setState(
                                () {
                                  switch (dropdownValue) {
                                    case "nombre":
                                      apiProvider.certificate = filterData!
                                          .where((element) =>
                                              element.fullName!.contains(value))
                                          .toList();
                                      break;
                                    case "dni":
                                      apiProvider.certificate = filterData!
                                          .where((element) =>
                                              element.dni!.contains(value))
                                          .toList();
                                      break;
                                    case "curso":
                                      apiProvider.certificate = filterData!
                                          .where((element) =>
                                              element.course!.contains(value))
                                          .toList();
                                      break;
                                  }
                                },
                              );
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'COLUMNA A FILTRAR',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54),
                            ),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            elevation: 8,
                            isExpanded: true,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.red.shade900,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                      /* ========= Tabla Pagina ========== */
                      PaginatedDataTable(
                        sortAscending: sort,
                        columnSpacing: 11,
                        rowsPerPage: 10,
                        sortColumnIndex: _currentSortColumn,
                        source: RowSource(
                          myData: certificate,
                          count: certificate.length,
                          newContext: context,
                          selectedRows: _selectedRows,
                        ),
                        columns: [
                          const DataColumn(
                            label: Text(
                              'Certificación',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                          DataColumn(
                              label: const Text(
                                'Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  _currentSortColumn = columnIndex;
                                  if (ascending) {
                                    filterData!.sort((a, b) =>
                                        a.fullName!.compareTo(b.fullName!));
                                  } else {
                                    filterData!.sort((a, b) =>
                                        b.fullName!.compareTo(a.fullName!));
                                  }
                                  sort = !sort;
                                });
                              }),
                          const DataColumn(
                            label: Text(
                              "DNI",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                          const DataColumn(
                            label: Text(
                              'Curso',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                          const DataColumn(
                            label: Text(
                              "Estado",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                          const DataColumn(
                            label: Text(
                              "Nota",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                          const DataColumn(
                            label: Text(
                              "Ultima Fecha",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                          const DataColumn(
                            label: Text(
                              "Vencimiento",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                          const DataColumn(
                            label: Text(
                              "Compania",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                          const DataColumn(
                            label: Text(
                              "Duración",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RowSource extends DataTableSource {
  final List<Certificate> myData;
  final count;
  BuildContext newContext;
  final List<int> selectedRows;
  RowSource(
      {required this.myData,
      required this.count,
      required this.newContext,
      required this.selectedRows});

  DataRow? getRow(int index) {
    assert(index >= 0);

    if (index >= myData.length) {
      return null;
    }
    final certificate = myData[index];

    return DataRow.byIndex(
      index: index,
      selected: selectedRows.contains(index),
      onSelectChanged: (isSelected) {
        if (isSelected != null) {
          _handleRowSelection(isSelected, index);
        }
      },
      onLongPress: () {
        Navigator.of(newContext).push(
          MaterialPageRoute(
            builder: (newContext) {
              return PdfPage(
                user_certificate: myData[index],
              );
            },
          ),
        );
      },
      cells: [
        DataCell(Text(certificate.certification.toString())),
        DataCell(Text(certificate.fullName.toString())),
        DataCell(Text(certificate.dni.toString())),
        DataCell(Text(certificate.course.toString())),
        DataCell(Text(certificate.status.toString())),
        DataCell(Text(certificate.mark.toString())),
        DataCell(Text(certificate.date.toString())),
        DataCell(Text(certificate.date.toString())),
        DataCell(Text(certificate.company.toString())),
        DataCell(Text(certificate.duration.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

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
}
