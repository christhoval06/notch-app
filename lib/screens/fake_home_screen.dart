import 'package:flutter/material.dart';

class FakeHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      backgroundColor: Colors.white, // Fondo blanco aburrido
      body: ListView(
        children: [
          _buildTaskItem("Comprar leche", true),
          _buildTaskItem("Llamar al seguro", false),
          _buildTaskItem("Revisar correos", false),
          _buildTaskItem("Pagar internet", true),
          _buildTaskItem("Cita dentista - Jueves", false),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskItem(String title, bool done) {
    return ListTile(
      leading: Checkbox(value: done, onChanged: (v) {}),
      title: Text(
        title,
        style: TextStyle(
          decoration: done ? TextDecoration.lineThrough : null,
          color: Colors.black87,
        ),
      ),
    );
  }
}
