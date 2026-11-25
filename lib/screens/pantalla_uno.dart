import 'package:flutter/material.dart';
import 'pantalla_dos.dart';

// primera ventana del examen con statelesswidget
class PantallaUno extends StatelessWidget {
  PantallaUno({super.key});

  // controladores de texto para los campos de solo lectura
  final TextEditingController _controladorNombres = TextEditingController();
  final TextEditingController _controladorApellidos = TextEditingController();
  final TextEditingController _controladorDividendo = TextEditingController();
  final TextEditingController _controladorDivisor = TextEditingController();
  final TextEditingController _controladorParteEntera = TextEditingController();
  final TextEditingController _controladorResiduo = TextEditingController();
  final TextEditingController _controladorNumInvertido = TextEditingController();

  // notificador para habilitar el boton mostrar resultados en statelesswidget
  final ValueNotifier<bool> _botonMostrarHabilitado = ValueNotifier<bool>(false);
  final ValueNotifier<Map<String, dynamic>?> _datosRecibidos = ValueNotifier<Map<String, dynamic>?>(null);

  // navegar a la segunda pantalla y esperar resultados
  Future<void> _irAPantallaDos(BuildContext context) async {
    final resultado = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => PantallaDos(),
      ),
    );

    // si regresa con los datos completos se habilita el boton mostrar
    if (resultado != null) {
      _datosRecibidos.value = resultado;
      _botonMostrarHabilitado.value = true;
    }
  }

  // mostrar todos los datos al presionar el boton amarillo
  void _mostrarResultados() {
    final datos = _datosRecibidos.value;
    if (datos != null) {
      _controladorNombres.text = datos['nombres'] ?? '';
      _controladorApellidos.text = datos['apellidos'] ?? '';
      _controladorDividendo.text = datos['dividendo'].toString();
      _controladorDivisor.text = datos['divisor'].toString();
      _controladorParteEntera.text = datos['parteEntera'].toString();
      _controladorResiduo.text = datos['residuo'].toString();
      _controladorNumInvertido.text = datos['numeroInvertido'].toString();
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
                      onPressed: () => _irAPantallaDos(context),
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

                  // boton amarillo para mostrar resultados usando valuelistenablebuilder
                  ValueListenableBuilder<bool>(
                    valueListenable: _botonMostrarHabilitado,
                    builder: (context, habilitado, _) {
                      return SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: habilitado
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
                      );
                    },
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
