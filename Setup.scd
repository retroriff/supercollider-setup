// Live Coding Set Up

(

// Increase number of buffers the server has access to for loading samples
s.options.numBuffers = 1024 * 16;

// Increase the memory available to the server
s.options.memSize = 8192 * 64;

// Change num. of hardware output audio busses
s.options.numOutputBusChannels = 8;

// Change num. of hardware input busses
s.options.numInputBusChannels = 8;

// Boot the server
s.boot;

// t = TempoClock.new(110 / 60).permanent_(true);
~bpm = 110;
// TempoClock.default.tempo = ~bpm / 60;
s.doWhenBooted({
    Task({

        3.wait;

        d = Dictionary.new;
        d.add(\foldernames -> PathName("~/Dropbox/Music/Samples/Live Coding/").entries);
        for (0, d[\foldernames].size - 1,
            {
                arg i;
                d.add(d[\foldernames][i].folderName -> d[\foldernames][i].entries.collect({
                    arg sf;
                    Buffer.read(s, sf.fullPath);
                }))
            }
        );

        // Buffer Function for Playbuf and LPlay SynthDef
        ~s = { |folder, file|
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

        // Buffer for Granular SynthDefs
        ~g = { |folder, file|
            Buffer.readChannel(s, ~s.set(folder, file), channels:[0]);
        };

        // Pattern Fading
        ~f = { |start, end, time, curve = 0|
            Pseg(Pseq([start, Pn(end)]), time, curve)
        };

        ("~/Dropbox/Music/SuperCollider/SynthDefs/SynthDefs.scd".standardizePath).load;

        // ("~/Dropbox/Music/SuperCollider/Setup/Snippets.scd".standardizePath).load;

        // Wait, because otherwise it won't work for some reason
        3.wait;

        // Activate StageLimiter - Part of the BatLib quark
        StageLimiter.deactivate;
        StageLimiter.activate(2);

        // miSCellaneous
        EventShortcuts.on;

        ~snareSets = [
            "2, 0.75, 1.25",
            "0.75",
        ];

        "Setup done!".postln;

    }).start;
});

Pbind(\instrument, \tb303, \dur, 0.2, \freq, Pwhite(6, 10, 3) * 10 ).play;

)