
(

/*
Arguments: Ndef(\reverb).set(\mix, 0.9);
*/

// Chorus ///////////////////////////////////

~chorus = Bus.audio(s, 2);

Ndef(\chorus, {

	var chorus;
	var env = Linen.kr(1, 0.1, 1, 0.1, 2);
	var source = In.ar(~chorus)!2;

	chorus = Splay.ar(Array.fill(4, {
		var maxdelaytime = rrand(0.005, 0.02);
		DelayC.ar(source[0], maxdelaytime, LFNoise1.kr(Rand(0.1,0.6), 0.25*maxdelaytime, 0.75*maxdelaytime) )
	}));

	chorus = Compander.ar(4*(source + chorus), source, 0.4, 1, 4);
}).play;


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
    |damp = 0.9, mix = 1, room = 1, mul = 1|
    FreeVerb.ar(In.ar(~reverb)!2, mix, room, damp, mul)
}).play;

~illBient = Bus.audio(s, 2);

Ndef(\illbientReverb, {
    FreeVerb.ar(
        In.ar(~illBient, 2),
        room: 0.9,
        damp: 0.9,
        mix: 0.9,
        mul: 0.2
    )
}).play;

// Vibrato ///////////////////////////////////

~vibrato = Bus.audio(s, 2);

Ndef(\vibrato, {
    DelayC.ar(In.ar(~vibrato)!2, 0.01, SinOsc.ar(Rand(5,10),0,0.0025,0.0075));
}).play;

"Efects loaded".postln;

)
