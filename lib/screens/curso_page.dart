import 'package:enrollment_system/db/db_helper.dart';
import 'package:flutter/material.dart';

class CursosScreen extends StatefulWidget { // Cambiado a StatefulWidget
  @override
  State<CursosScreen> createState() => _CursosScreenPageState();  
}

class _CursosScreenPageState extends State<CursosScreen> {
  List<Map<String, dynamic>> _alldata = [];
  bool _isLoading = true;
// Get All data From Database
  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _alldata = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData(); // Llama a _refreshData al iniciar
  }

  Future <void> _addData(String nombre, String? profesor, String? aula, int? horas, String? grupo) async {
    await SQLHelper.createData(_nombreController.text, _profesorController.text, _aulaController.text, int.parse(_horasController.text), _grupoController.text);
    _refreshData();
  }

  Future <void> _updateData(int id, String nombre, String? profesor, String? aula, int? horas, String? grupo) async {
    await SQLHelper.updateData(id, _nombreController.text, _profesorController.text, _aulaController.text, int.parse(_horasController.text), _grupoController.text);
    _refreshData();
  }

  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Text('Data deleted successfully!')));
    _refreshData();
  }

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _profesorController = TextEditingController();
  final TextEditingController _aulaController = TextEditingController();
  final TextEditingController _horasController = TextEditingController();
  final TextEditingController _grupoController = TextEditingController();

  void showBottomSheet(int? id) async {
    if (id != null) {
      final exitingData = 
        _alldata.firstWhere((element) => element['id'] == id);
      _nombreController.text = exitingData['nombre'];
      _profesorController.text = exitingData['profesor'];
      _aulaController.text = exitingData['aula'];
      _horasController.text = exitingData['horas'].toString();
      _grupoController.text = exitingData['grupo']; 
    }

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nombre',
              ),
            ),
            TextField(
              controller: _profesorController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Profesor',
              ),
            ),
            TextField(
              controller: _aulaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Aula',
              ),
            ),
            TextField(
              controller: _horasController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Horas',
              ),
            ),
            TextField(
              controller: _grupoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Grupo',
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addData(_nombreController.text, _profesorController.text, _aulaController.text, int.parse(_horasController.text), _grupoController.text);
                  }if (id != null) {
                    await _updateData(id, _nombreController.text, _profesorController.text, _aulaController.text, int.parse(_horasController.text), _grupoController.text); //id solo
                  } 
                  _nombreController = "";
                  _profesorController = "";     
                  _aulaController = "";
                  _horasController = "";
                  _grupoController = "";

                  Navigator.of(context).pop();
                  print("Data Added Successfully");
                },
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    id == null ? 'Agregar' : 'Actualizar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  ),
                )
              ), 
              ),
            )

          ],
        ),
      ),
    )
  }

  @override
  Widget build(BuildContext context) { // No es async
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        title: Text("Carga de Cursos"),
      ),
      body: _isLoading 
        ? Center (
          child: CircularProgressIndicator(),
          )
        : ListView.builder(
          itemCount: _alldata.length,
          itemBuilder: (context, index) => Card(
            margin: EdgeInsets.all(15),
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  _alldata[index]['nombre'], //allData
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
            ),
            subtitle: Text(_alldata[index]['profesor']),
            trailing: Row(children: [IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit,color: Colors.indigo,),), IconButton(onPressed: () => _deleteData(_alldata[index]['id']), icon: Icon(Icons.delete) ,)],),
          ),  
        ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => showBottomSheet(null), // null = no onPressed,
      child: Icon(Icons.add),
      )
  }
}
