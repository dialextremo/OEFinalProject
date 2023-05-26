// Código ChucK para recibir mensajes OSC

OscRecv osc;
440 => float freq; // Variable para almacenar la frecuencia

// Configurar receptor OSC en el puerto 8888
osc => OscRecv.recv(8888);

while (true) {
  // Esperar mensajes OSC
  osc => now;
  
  while (osc.message()) {
    // Comprobar la dirección del mensaje
    if (osc.address() == "/chuck/play") {
      // Leer argumento de frecuencia del mensaje
      osc => freq;
      
      // Reproducir sonido
      SinOsc s => dac;
      freq => s.freq;
      0.3 => s.gain;
      1::second => now;
      0 => s.gain;
    }
  }
}
