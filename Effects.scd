
(

// Delay //////////////////////////////////////

~delay = Bus.audio(s, 2);

Ndef(\delay, {
    var tempo = 60/~bpm;
    CombC.ar(In.ar(~delay)!2, maxdelaytime: tempo*4, delaytime: tempo/2, decaytime: 2)
}).play;


// High Pass /////////////////////////////////

~hpf = Bus.audio(s, 2);

Ndef(\hpf, {
    RHPF.ar(In.ar(~hpf)!2, freq:SinOsc.kr(0.1).range(440, 440), rq:0.1)
}).play;

// Reverb ////////////////////////////////////

~reverb = Bus.audio(s, 2);
~reverb.numChannels;

Ndef(\reverb, {
    FreeVerb.ar(
        In.ar(~reverb)!2,
        mix: 0.8,
        room: 0.9,
        damp: 0.9
    )
}).play;


// Vibrato ///////////////////////////////////

~vibrato = Bus.audio(s, 2);

Ndef(\vibrato, {
    DelayC.ar(In.ar(~vibrato)!2, 0.01, SinOsc.ar(Rand(5,10),0,0.0025,0.0075));
}).play;

"Efects loaded".postln;

)
