// Live Coding Set Up

(

// Increase number of buffers the server has access to for loading samples
s.options.numBuffers = 1024 * 16;

// Increase the memory available to the server
s.options.memSize = 8192 * 64;

// Boot the server
s.boot;


~bpm = 110;
TempoClock.default.tempo = ~bpm / 60;

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
        var showTotal;
        if (file == nil) {
            file = 0;
            showTotal = true;
        } {
           if (file >= d[folder].size) {
                file = d[folder].size -1;
                showTotal = true;
            };
        };
        if (showTotal == true) {
           "Folder \"".catArgs(folder, "\" maximum number is ", d[folder].size -1).postln;
        };
        d[folder][file];
    };

	("../SynthDefs/SynthDefs.scd").loadRelative;

	("Snippets.scd").loadRelative;

	// Wait, because otherwise it won't work for some reason
	3.wait;

	// Activate StageLimiter - Part of the BatLib quark
    StageLimiter.deactivate;
	StageLimiter.activate;

    ~snareSets = [
        "2, 0.75, 1.25",
        "0.75",
    ];

	"Setup done!".postln;

}).start;

Pbind(\instrument, \tb303, \dur, 0.2, \freq, Pwhite(6, 10, 3) * 10 ).play;

)