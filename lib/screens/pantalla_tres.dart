import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// tercera ventana del examen
class PantallaTres extends StatefulWidget {
  final String nombres;
  final String apellidos;

  const PantallaTres({
    super.key,
    required this.nombres,
    required this.apellidos,
  });

  @override
  State<PantallaTres> createState() => _PantallaTresState();
}

class _PantallaTresState extends State<PantallaTres> {
  // controladores para los campos de texto
  late final TextEditingController _controladorNombres;
  late final TextEditingController _controladorApellidos;
  final TextEditingController _controladorDividendo = TextEditingController();
  final TextEditingController _controladorDivisor = TextEditingController();
  final TextEditingController _controladorNumero = TextEditingController();

  // variables de estado
  bool _botonCerrarHabilitado = false;
  int _parteEntera = 0;
  int _residuo = 0;
  int _numeroInvertido = 0;

  @override
  void initState() {
    super.initState();
    // cargar nombres y apellidos recibidos
    _controladorNombres = TextEditingController(text: widget.nombres);
    _controladorApellidos = TextEditingController(text: widget.apellidos);
  }

  @override
  void dispose() {
    _controladorNombres.dispose();
    _controladorApellidos.dispose();
    _controladorDividendo.dispose();
    _controladorDivisor.dispose();
    _controladorNumero.dispose();
    super.dispose();
  }

  // validar que sean numeros positivos mayores a cero y resultado mayor a cero
  void _validarCampos() {
    final textoDividendo = _controladorDividendo.text.trim();
    final textoDivisor = _controladorDivisor.text.trim();
    final textoNumero = _controladorNumero.text.trim();

    final dividendo = int.tryParse(textoDividendo);
    final divisor = int.tryParse(textoDivisor);
    final numero = int.tryParse(textoNumero);

    // validar que todos sean mayores a cero
    if (dividendo != null && dividendo > 0 &&
        divisor != null && divisor > 0 &&
        numero != null && numero > 0) {
      
      // calcular parte entera y residuo usando solo restas y sumas
      int cociente = 0;
      int resto = dividendo;
      while (resto >= divisor) {
        resto = resto - divisor; // resta
        cociente = cociente + 1; // suma
      }
      final resultadoParteEntera = cociente;
      final resultadoResiduo = resto;

      // el resultado de la division debe ser mayor a cero
      if (resultadoParteEntera > 0) {
        // invertir el numero matematicamente
        int invertido = 0;
        int temporal = numero;
        while (temporal > 0) {
          int digito = temporal;
          int decenas = 0;
          while (digito >= 10) {
            digito = digito - 10;
            decenas = decenas + 1;
          }
          invertido = (invertido * 10) + digito;
          temporal = decenas;
        }

        setState(() {
          _parteEntera = resultadoParteEntera;
          _residuo = resultadoResiduo;
          _numeroInvertido = invertido;
          _botonCerrarHabilitado = true;
        });
        return;
      }
    }

    // si no cumple se deshabilita el boton cerrar
    setState(() {
      _botonCerrarHabilitado = false;
    });
  }

  // retornar los datos a la segunda pantalla
  void _cerrarVentana() {
    final dividendo = int.parse(_controladorDividendo.text.trim());
    final divisor = int.parse(_controladorDivisor.text.trim());
    final numero = int.parse(_controladorNumero.text.trim());

    Navigator.pop(context, {
      'nombres': widget.nombres,
      'apellidos': widget.apellidos,
      'dividendo': dividendo,
      'divisor': divisor,
      'numero': numero,
      'parteEntera': _parteEntera,
      'residuo': _residuo,
      'numeroInvertido': _numeroInvertido,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('VENTANA (TRES)'),
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
                  const Text(
                    'PASAR Y MOSTRAR: Nombre y Apellido',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

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

                  const SizedBox(height: 12),

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
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                // no dejar escribir nada que no sean numeros
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (_) => _validarCampos(),
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
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                // solo numeros
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (_) => _validarCampos(),
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
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                // solo numeros positivos
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (_) => _validarCampos(),
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

                  const SizedBox(height: 90),

                  // boton cerrar habilitado solo si el resultado es mayor a cero
                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: _botonCerrarHabilitado ? _cerrarVentana : null,
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
