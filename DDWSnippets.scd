DDWSnippets.autoEnable = nil;
DDWSnippets.verbose = true;
DDWSnippets.hotkeyCode = 33;
DDWSnippets.hotkeyMods = 262144;

DDWSnippets.put("Arguments", "Pbindef(##)");

DDWSnippets.put("DDWSnippets open", "Document.open(\"~/Library/Mobile Documents/com~apple~CloudDocs/Music/SuperCollider/Setup/DDWSnippets.scd\".standardizePath)");

DDWSnippets.put("Offbeat", "Pseq([0.5, Pseq([1], inf)], inf)");

DDWSnippets.put("Setup", "
ServerOptions.devices
s.options.outDevice = \"BlackHole 16ch\"
s.options.inDevice = \"MacBook Pro Microphone\"
s.options.outDevice = \"BlackHole 16ch\"
s.options.outDevice = \"External Headphones\"
s.options.outDevice = \"MacBook Pro Speakers\"
s.options.outDevice = \"Scarlett 4i4 USB\"
s.options.outDevice = \"Xavi's AirPods\"

Server.killAll
(\"~/Library/Mobile Documents/com~apple~CloudDocs/Music/SuperCollider/Setup/Setup.scd\".standardizePath).load;");

DDWSnippets.put("Setup open", "Document.open(\"~/Library/Mobile Documents/com~apple~CloudDocs/Music/SuperCollider/Setup/Setup.scd\".standardizePath)");

DDWSnippets.put("Offset", "Ptpar([0.5, ##])");

DDWSnippets.put("Melody", "(
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
).play.quant*(4, -1).fadeTime*(20));");

DDWSnippets.put("Kick", "Pdef(\\kick, Pbind(\\instrument, \\kick, \\amp, 1, \\dur, ##1)).play.quant\_(4);");

DDWSnippets.put("TB303", "(
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
)).play.quant\_(4);
)

Pdef(\\303, Pbind(\\instrument, \\tb303, \\amp, 1, \\dur, 0.75, \\freq, (Pwrand([0, 12], [8, 2].normalizeSum, inf) + 36).midicps, \\ctf, 10000, \\env, 5000)).play.quant\_(4);");

DDWSnippets.put("Loop", "Pdef(\\loop, Pbind(\\instrument, \\lplay, \\buf, ~buf.(\"break-4\", ##0), \\dur, 4, \\amp, 0.5)).play.quant\_(4);");

DDWSnippets.put("LoopTempo", "(
Pdef(\\loopTempo, Pbind(\\instrument, \\lplay, \\buf, ~loopTrack, \\dur, ~loopDur, \\amp, 0.1, \\tempo, Pfunc({~bpm/60})).play.quant\_(4);
)");

DDWSnippets.put("Pbjorklund2", "Pbjorklund2(##3##,8)/4");

DDWSnippets.put("Trap", "Pwrand([1,0.5,0.25,Pseq([0.125],2),Pseq([0.125/2],4)],[0.5,2,14,3,2].normalizeSum,inf)");

DDWSnippets.put("Drone1", "(
~drone1 = Ndef(\\drone1, {
PMOsc.ar(carfreq:[60, 60*1.1], modfreq:##100, pmindex:MouseX.kr(0, 0.5), mul:0.3);
}).play.fadeTime\_(10);
)
~drone1.clear;");

DDWSnippets.put("Henon", "Pdef(\\henon, Pbind(\\instrument, \\henon, \\amp, 0.1, \\freq, 44100, \\dur, 0.25, \\a, Pexprand(1.0, 0.5), \\b, Pexprand(0.3, 0.3), \\atk, 0, \\sus, 0, \\rel, Pexprand(0.01, 0.1))).play.quant\_(4);");

DDWSnippets.put("Snare", "Pdef(\\snare, Pbind(\\instrument, \\snare, \\amp, 1, \\dur, 2, \\timingOffset, 1)).play.quant\_(4);");

DDWSnippets.put("Pexprand", "Pexprand(##0.001,1##)");

DDWSnippets.put("RateNotes", "Pseq([0,0,0,12].midiratio,inf)");

DDWSnippets.put("Pseed", "Pseed(101, Prand([1,2,3], 3))");

DDWSnippets.put("Effects", "(
~filePath = \"~/Library/Mobile Documents/com~apple~CloudDocs/Music/Supercollider/Setup/Effects.scd\";
(~filePath.standardizePath).load;##
)");

DDWSnippets.put("Stop", "Pdef(\\##).stop;");

DDWSnippets.put("Pwrand", "Pwrand([##1,0##], [10,1].normalizeSum, inf)");

DDWSnippets.put("Playbuf", "Pdef(\\rave, Pbind(\\instrument, \\playbuf, \\amp, 0.3, \\buf, ~buf.(\"rave\", 0), \\dur, Pbjorklund2(3,8)/4)).play.quant\_(4);");

DDWSnippets.put("FadeTime", "Pdef(\\##).fadeTime\_(60);");

DDWSnippets.put("Hihats2", "Pdef(\\hat, Pbind(\\instrument, \\playbuf, \\buf, d[\"cy\"][0], \\amp, Pexprand(0.05, 1), \\dur, 0.25)).play.quant\_(4);");

DDWSnippets.put("Pseq", "Pseq([##1,2,3,4,5##],inf)");

DDWSnippets.put("Tempo", "(
~bpm = 120;
TempoClock.default.tempo = ~bpm / 60;
)");

DDWSnippets.put("ProxySpace", "(
// Start Proxy
p = ProxySpace(s).push;
p[\\tempo] = 110 / 60;
p.quant = 4;
p.fadeTime = 20;
StageLimiter.new(2);
)

(
// Panes
s.plotTree;
s.scope(2);
s.makeWindow;
m = ProxyMixer(p, 8);
m.parent.alwaysOnTop\_(true);
PdefAllGui.new;
)");

DDWSnippets.put("Hihats", "Pdef(\\hihat, Pbind(\\instrument, \\hihat, \\amp, 1, \\dur, 1, \\timingOffset, 0.5)).play.quant\_(4);");

DDWSnippets.put("SampleRand", "
~sampleRand = Array.rand(##2##, 0, d[\"rave\"].size - 1);
d[\"rave\"][~sampleRand]");

DDWSnippets.put("Drone2", "(
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
}).play.fadeTime\_(10);
)
~drone2.clear;");

"DDWSnippets loaded".postln;