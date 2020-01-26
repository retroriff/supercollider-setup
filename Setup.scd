// Live Coding Set Up

(

// Increase number of buffers the server has access to for loading samples
s.options.numBuffers = 1024 * 16;

// Increase the memory available to the server
s.options.memSize = 8192 * 64;

// Boot the server
s.boot;

TempoClock.default.tempo = 90/60;

Task({

	3.wait;

	d = Dictionary.new;
	d.add(\foldernames -> PathName("~/Dropbox/Music/Samples/Live Coding/").entries);
	for (0, d[\foldernames].size - 1,
		{arg i; d.add(d[\foldernames][i].folderName -> d[\foldernames][i].entries.collect({
			arg sf;
			Buffer.read(s,sf.fullPath);
		});
	)});

    // Check if sample
    ~sample = { |folder, file|
        if (file >= d[folder].size) {
            "Folder \"".catArgs(folder, "\" maximum number is ", d[folder].size -1).postln;
            file = d[folder].size -1;
        };
        d[folder][file];
    };

	("../SynthDefs/SynthDefs.scd").loadRelative;

	("Snippets.scd").loadRelative;

	// Wait, because otherwise it won't work for some reason
	3.wait;

	// Activate StageLimiter - Part of the BatLib quark
	StageLimiter.activate;

	~bpm = 110;
	TempoClock.default.tempo = ~bpm / 60;

	"Setup done!".postln;

}).start;

Pbind(\instrument, \tb303, \dur, 0.2, \freq, Pwhite(6, 10, 3) * 10 ).play;

)