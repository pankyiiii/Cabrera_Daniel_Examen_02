import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pantalla_tres.dart';

// formateador personalizado para no permitir numeros, caracteres raros, ni letras repetidas
class _FormateadorNombreApellido extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final texto = newValue.text;
    if (texto.isEmpty) return newValue;

    // solo permitir letras
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ]+$').hasMatch(texto)) {
      return oldValue;
    }

    // maximo 12 caracteres para un solo nombre o apellido
    if (texto.length > 12) {
      return oldValue;
    }

    // no permitir una letra repetida 3 o mas veces seguidas como eee o qqq
    if (RegExp(r'(.)\1{2,}').hasMatch(texto.toLowerCase())) {
      return oldValue;
    }

    // no permitir cadenas repetitivas donde casi todas las letras sean iguales
    if (texto.length >= 4) {
      final unicas = texto.toLowerCase().split('').toSet();
      if (unicas.length <= 2) {
        return oldValue;
      }
    }

    return newValue;
  }
}

// segunda ventana del examen con statelesswidget
class PantallaDos extends StatelessWidget {
  PantallaDos({super.key});

  // controladores de texto
  final TextEditingController _controladorNombres = TextEditingController();
  final TextEditingController _controladorApellidos = TextEditingController();
  final TextEditingController _controladorDividendo = TextEditingController();
  final TextEditingController _controladorDivisor = TextEditingController();
  final TextEditingController _controladorNumero = TextEditingController();

  // notificadores para habilitar botones en statelesswidget
  final ValueNotifier<bool> _botonSiguienteHabilitado =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> _botonCerrarHabilitado = ValueNotifier<bool>(false);

  // variable interna para almacenar datos de la tercera pantalla
  final ValueNotifier<Map<String, dynamic>?> _datosFinales =
      ValueNotifier<Map<String, dynamic>?>(null);

  // validar que sea un nombre o apellido valido sin letras repetidas ni muy largo
  bool _esTextoValido(String texto) {
    if (texto.isEmpty) return false;

    // longitud minima y maxima razonable para un solo nombre o apellido
    if (texto.length < 3 || texto.length > 12) return false;

    // solo letras
    final expresionSoloLetras = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ]+$');
    if (!expresionSoloLetras.hasMatch(texto)) return false;

    // no permitir una letra repetida 3 o mas veces seguidas como eee o qqq
    final letrasRepetidasSeguidas = RegExp(r'(.)\1{2,}');
    if (letrasRepetidasSeguidas.hasMatch(texto.toLowerCase())) return false;

    // no permitir cadenas donde casi todas las letras sean iguales
    final letrasDiferentes = texto.toLowerCase().split('').toSet();
    if (texto.length >= 4 && letrasDiferentes.length <= 2) return false;

    return true;
  }

  // validar ambos campos
  void _validarNombresApellidos() {
    final nombres = _controladorNombres.text.trim();
    final apellidos = _controladorApellidos.text.trim();

    final esValido = _esTextoValido(nombres) && _esTextoValido(apellidos);
    _botonSiguienteHabilitado.value = esValido;
  }

  // ir a la tercera pantalla pasando los nombres y apellidos
  Future<void> _irAPantallaTres(BuildContext context) async {
    final resultado = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => PantallaTres(
          nombres: _controladorNombres.text.trim(),
          apellidos: _controladorApellidos.text.trim(),
        ),
      ),
    );

    // si regresa de la tercera con datos correctos
    if (resultado != null) {
      _datosFinales.value = resultado;
      _controladorDividendo.text = resultado['dividendo'].toString();
      _controladorDivisor.text = resultado['divisor'].toString();
      _controladorNumero.text = resultado['numero'].toString();
      // se activa el boton cerrar
      _botonCerrarHabilitado.value = true;
    }
  }

  // cerrar la pantalla y retornar los datos a la primera
  void _cerrarVentana(BuildContext context) {
    Navigator.pop(context, _datosFinales.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('VENTANA (DOS)'),
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
                              inputFormatters: [
                                _FormateadorNombreApellido(),
                              ],
                              onChanged: (_) => _validarNombresApellidos(),
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Colors.white,
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
                              inputFormatters: [
                                _FormateadorNombreApellido(),
                              ],
                              onChanged: (_) => _validarNombresApellidos(),
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: Colors.white,
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

                  // Numero
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            'Número:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controladorNumero,
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

                  const SizedBox(height: 68),

                  // navegacion a pantalla tres con valuelistenablebuilder
                  ValueListenableBuilder<bool>(
                    valueListenable: _botonSiguienteHabilitado,
                    builder: (context, habilitado, _) {
                      return SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: habilitado
                              ? () => _irAPantallaTres(context)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF92D050),
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
                          child: const Text('Siguiente'),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  // boton cerrar para regresar a la primera pantalla
                  ValueListenableBuilder<bool>(
                    valueListenable: _botonCerrarHabilitado,
                    builder: (context, habilitado, _) {
                      return SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed:
                              habilitado ? () => _cerrarVentana(context) : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF92D050),
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
                          child: const Text('Cerrar'),
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
