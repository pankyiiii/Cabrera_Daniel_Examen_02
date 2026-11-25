import 'package:flutter/material.dart';
import 'pantalla_dos.dart';

// primera ventana del examen
class PantallaUno extends StatefulWidget {
  const PantallaUno({super.key});

  @override
  State<PantallaUno> createState() => _PantallaUnoState();
}

class _PantallaUnoState extends State<PantallaUno> {
  // controladores de texto para los campos de solo lectura
  final TextEditingController _controladorNombres = TextEditingController();
  final TextEditingController _controladorApellidos = TextEditingController();
  final TextEditingController _controladorDividendo = TextEditingController();
  final TextEditingController _controladorDivisor = TextEditingController();
  final TextEditingController _controladorParteEntera = TextEditingController();
  final TextEditingController _controladorResiduo = TextEditingController();
  final TextEditingController _controladorNumInvertido = TextEditingController();

  // variables de estado
  bool _botonMostrarHabilitado = false;
  Map<String, dynamic>? _datosRecibidos;

  @override
  void dispose() {
    _controladorNombres.dispose();
    _controladorApellidos.dispose();
    _controladorDividendo.dispose();
    _controladorDivisor.dispose();
    _controladorParteEntera.dispose();
    _controladorResiduo.dispose();
    _controladorNumInvertido.dispose();
    super.dispose();
  }

  // navegar a la segunda pantalla y esperar resultados
  Future<void> _irAPantallaDos() async {
    final resultado = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => const PantallaDos(),
      ),
    );

    // si regresa con los datos completos se habilita el boton mostrar
    if (resultado != null) {
      setState(() {
        _datosRecibidos = resultado;
        _botonMostrarHabilitado = true;
      });
    }
  }

  // mostrar todos los datos al presionar el boton amarillo
  void _mostrarResultados() {
    if (_datosRecibidos != null) {
      setState(() {
        _controladorNombres.text = _datosRecibidos!['nombres'] ?? '';
        _controladorApellidos.text = _datosRecibidos!['apellidos'] ?? '';
        _controladorDividendo.text = _datosRecibidos!['dividendo'].toString();
        _controladorDivisor.text = _datosRecibidos!['divisor'].toString();
        _controladorParteEntera.text = _datosRecibidos!['parteEntera'].toString();
        _controladorResiduo.text = _datosRecibidos!['residuo'].toString();
        _controladorNumInvertido.text = _datosRecibidos!['numeroInvertido'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('VENTANA (UNO)'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: 360,
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Nombres
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            'Nombres:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controladorNombres,
                              readOnly: true,
                              showCursor: false,
                              enableInteractiveSelection: false,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Color(0xFFBDBDBD),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Apellidos
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            'Apellidos:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controladorApellidos,
                              readOnly: true,
                              showCursor: false,
                              enableInteractiveSelection: false,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Color(0xFFBDBDBD),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Dividendo
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            'Dividendo:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controladorDividendo,
                              readOnly: true,
                              showCursor: false,
                              enableInteractiveSelection: false,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Color(0xFFBDBDBD),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divisor
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            'Divisor:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controladorDivisor,
                              readOnly: true,
                              showCursor: false,
                              enableInteractiveSelection: false,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Color(0xFFBDBDBD),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Parte entera
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            'Parte entera:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controladorParteEntera,
                              readOnly: true,
                              showCursor: false,
                              enableInteractiveSelection: false,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Color(0xFFBDBDBD),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Residuo
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            'Residuo:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controladorResiduo,
                              readOnly: true,
                              showCursor: false,
                              enableInteractiveSelection: false,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Color(0xFFBDBDBD),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Numero invertido
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            'Num. Invertido:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controladorNumInvertido,
                              readOnly: true,
                              showCursor: false,
                              enableInteractiveSelection: false,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Color(0xFFBDBDBD),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // navegacion a pantalla dos
                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: _irAPantallaDos,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF92D050),
                        foregroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(
                            color: Colors.black,
                            width: 1.2,
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: const Text('Siguiente'),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // boton amarillo para mostrar resultados cuando esten listos
                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: _botonMostrarHabilitado
                          ? _mostrarResultados
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC000), // boton amarillo
                        foregroundColor: Colors.black,
                        disabledBackgroundColor: const Color(0xFF808080),
                        disabledForegroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(
                            color: Colors.black,
                            width: 1.2,
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: const Text('Mostrar resultados'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
