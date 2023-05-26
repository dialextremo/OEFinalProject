SndBuf colombiaMusic => Gain colombiaGain => dac;
SndBuf purdueMusic => Gain purdueGain => dac;
SndBuf chinaMusic => Gain chinaGain => dac;

float inputVariable;
0.0 => inputVariable;
//keyboardInput
Hid hi;
HidMsg msg;

// which keyboard
0 => int device;
// get from command line
if (me.args()) me.arg(0) => Std.atoi => device;

// open keyboard (get device number from command line)
if (!hi.openKeyboard(device)) me.exit();
<<< "keyboard '" + hi.name() + "' ready", "" >>>;

//music
me.dir() + "colombiaMusic.wav" => string colombiaMusicName;
me.dir() + "USMusic.wav" => string purdueMusicName;
me.dir() + "chinaMusic.wav" => string chinaMusicName;
colombiaMusicName => colombiaMusic.read;
purdueMusicName => purdueMusic.read;
chinaMusicName => chinaMusic.read;

1.0 => purdueGain.gain;
0 => colombiaGain.gain;
0 => chinaGain.gain;

colombiaMusic.loop(1);
purdueMusic.loop(1);
chinaMusic.loop(1);


spork ~ playMusic(purdueMusic);
spork ~ playMusic(colombiaMusic);
spork ~ playMusic(chinaMusic);
fun void playMusic(SndBuf buffer) {
    while (true) {
        0 => buffer.pos;
        buffer.length() => now;
    }
}

// infinite event loop
while (true) {
    // wait on event
    hi => now;

    // get one or more messages
    while (hi.recv(msg)) {
        // check for action type
        if (msg.isButtonDown()) {
            inputVariable +0.1 => inputVariable ;
            if(inputVariable>1) 1=>inputVariable;
            crossFading(inputVariable);
            
        }
    }
}


fun void crossFading(float input)
{
    if(input<= 0.5){
        Math.fabs(2*(input-0.5)) => purdueGain.gain;
        input*2 => colombiaGain.gain;
        0 => chinaGain.gain;
        printGains();
    }else {
        Math.fabs(2*(1-input)) => colombiaGain.gain;
        2*(input - 0.5) => chinaGain.gain;
        printGains();
        
    }
}

fun void printGains(){
    <<< inputVariable, "input variable">>>;
    <<<purdueGain.gain(), "purdue">>>;
    <<<colombiaGain.gain(), "medellin">>>;
    <<<chinaGain.gain(), "china">>>;
    <<<"">>>;
}
