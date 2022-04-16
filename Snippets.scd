(

// Arturia BeatStep
/*DDWSnippets.put("Arturia BeatStep", "(
~filePath = \"~/Dropbox/Music/Supercollider/MIDI-controllers/Arturia-BeatStep.scd\";
(~filePath.standardizePath).load;
~oscPitch = OSCFunc({ |msg| \~changePitch.value(msg) }, 'pitch');
~changePitch = { |msg|
    var ch = msg[1];
    var value = msg[2];
    ~bpm = value.linlin(0, 127, 40, 200);
    TempoClock.default.tempo = ~bpm / 60;
    scatArgs(\"Tempo:\", ~bpm.asInteger).postln;
};
)");*/

// Drone 1
DDWSnippets.put("drone1", "(
~drone1 = Ndef(\\drone1, {
    PMOsc.ar(carfreq:[60, 60*1.1], modfreq:##100, pmindex:MouseX.kr(0, 0.5), mul:0.3);
}).play.fadeTime_(10);
)
~drone1.clear;");

// Drone 2
DDWSnippets.put("drone2", "(
~drone2 = Ndef(\\drone2, {
    DFM1.ar(
        in: SinOsc.ar([100, 101], 0, 0.1),
        freq: 200,
        res: SinOsc.kr(0.05).range(0.9, 1.1),
        inputgain: 1,
        type: 0,
        noiselevel: 0.0003,
        mul: 0.5
    );
}).play.fadeTime_(10);
)
~drone2.clear;");

// Effects Busses Loader
DDWSnippets.put("effects", "(\"~/Dropbox/Music/Supercollider/Setup/Effects.scd\".standardizePath).load;##");

// FadeTime
DDWSnippets.put("fadeTime", "Pdef(\\##).fadeTime_(60);");

// Henon SynthDef
DDWSnippets.put("henon", "Pdef(\\henon, Pbind(\\instrument, \\henon, \\amp, 0.1, \\freq, 44100, \\dur, 0.25, \\a, \Pexprand(1.0, 0.5), \\b, Pexprand(0.3, 0.3), \\atk, 0, \\sus, 0, \\rel, Pexprand(0.01, 0.1))).play.quant_(4);");

// DrumKit
DDWSnippets.put("hihats", "Pdef(\\hihat, Pbind(\\instrument, \\hihat, \\amp, 1, \\dur, 1, \\timingOffset, 0.5)).play.quant_(4);");
DDWSnippets.put("hihats2", "Pdef(\\hat, Pbind(\\instrument, \\playbuf, \\buf, d[\"cy\"][0], \\amp, Pexprand(0.05, 1), \\dur, 0.25)).play.quant_(4);");
DDWSnippets.put("kick", "Pdef(\\kick, Pbind(\\instrument, \\kick, \\amp, 1, \\dur, ##1)).play.quant_(4);");
DDWSnippets.put("snare", "Pdef(\\snare, Pbind(\\instrument, \\snare, \\amp, 1, \\dur, 2, \\timingOffset, 1)).play.quant_(4);");

// Loop
DDWSnippets.put("loop", "Pdef(\\loop, Pbind(\\instrument, \\lplay, \\buf, ~s.(\"break4\", ##0), \\dur, 4, \\amp, 0.5)).play.quant_(4);");

// Loop with Tempo
DDWSnippets.put("loopTempo", "(
~bpm = 120;
TempoClock.default.tempo = ~bpm / 60;
Pdef(\\loopTempo, Pbind(\\instrument, \\lplay, \\buf, ~s.(\"break4\", 2), \\dur, 4, \\amp, 0.2, \\tempo, ~bpm/60)).play.quant_(4, -1);
)");

// Melody
DDWSnippets.put("melody", "(
Pdef(\\melody,
	Pbind(
		\\instrument, \\rhodes,
		\\scale, Scale.minor,
		\\octave, 3,
		\\degree, Pwhite(0, 10, inf),
		\\amp, 0.5,
		\\dur, 1,
		\\sus, Pkey(\\dur),
		\\out, 0,
	)
).play.quant_(4, -1).fadeTime_(20));");

// Patterns: Bouncing Ball
DDWSnippets.put("P Bouncing","Pseq([Pgeom(1.0,0.95,64)], inf)");

// Playbuf
DDWSnippets.put("playbuf", "Pdef(\\rave, Pbind(\\instrument, \\playbuf, \\amp, 0.2, \\buf, ~s.(\"voice\", 0), \\dur, Pbjorklund2(3,8)/4)).play.quant_(4);");

// Sample Random
DDWSnippets.put("sampleRand", "
~bufas = Array.rand(##2##, 0, d[\"rave\"].size - 1);
\\buf, Pseq(d[\"cy\"][~bufas], inf)");

// Setup
DDWSnippets.put("setup", "
ServerOptions.devices
s.options.outDevice = \"BlackHole 16ch\"
s.options.inDevice  = \"MacBook Pro Microphone\"
s.options.outDevice = \"BlackHole 16ch\"
s.options.outDevice = \"External Headphones\"
s.options.outDevice = \"MacBook Pro Speakers\"
s.options.outDevice = \"Scarlett 4i4 USB\"
s.options.outDevice = \"Xavi's AirPods\"

Server.killAll
(\"~/Dropbox/Music/SuperCollider/Setup/Setup.scd\".standardizePath).load;");

// Stop
DDWSnippets.put("stop","Pdef(\\##).stop;");

// TB-303
DDWSnippets.put("tb303","(
Pdef(\\tb303, Pbind(
    \\instrument, \\tb303,
	\\dur, Pseq([0.25], inf),
	\\freq, Pseq([Pseed(Pstutter(16, Pwhite(1,1000).trace), Pwrand([1, 9, -3], [9, 3, 3].normalizeSum, 16))] + 36, inf).midicps,
    \\amp, 1,
	\\ctf, 1000,
	\\env, 1000,
	\\dec, 1,
	\\vol, 0.2,
	\\wave, 0
)).play.quant_(4);
)

Pdef(\\303, Pbind(\\instrument, \\tb303, \\amp, 1, \\dur, 0.75, \\freq, (Pwrand([0, 12], [8, 2].normalizeSum, inf) + 36).midicps, \\ctf, 10000, \\env, 5000)).play.quant_(4);");

// Tempo Switcher
DDWSnippets.put("tempo","(
~bpm = 120;
TempoClock.default.tempo = ~bpm / 60;
)");

// Specific Pattern Generators
DDWSnippets.put("Pwrand","Pwrand([##1,0##], [10,1].normalizeSum, inf)");
DDWSnippets.put("Pbjorklund2", "Pbjorklund2(##3##,8)/4");
DDWSnippets.put("offbeat","Pseq([0.5, Pseq([1], inf)], inf)");
DDWSnippets.put("Pexprand","Pexprand(##0.001,1##)");
DDWSnippets.put("Pseq","Pseq([##1,2,3,4,5##],inf)");
DDWSnippets.put("Pseed","Pseed(101, Prand([1,2,3], 3))");
DDWSnippets.put("rateNotes","Pseq([0,0,0,12].midiratio,inf)");
// DDWSnippets.put("rateNotes","Pseq([0,0,0,12].midicps/8.1757989156437,inf)");


// Rhythms
DDWSnippets.put("trap","Pwrand([1,0.5,0.25,Pseq([0.125],2),Pseq([0.125/2],4)],[0.5,2,14,3,2].normalizeSum,inf)");

)
