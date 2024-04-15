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

// Tempo
~bpm = 117;
t = TempoClock.new(110 / 60).permanent_(true);
TempoClock.default.tempo = ~bpm / 60;
t = TempoClock.tempo;

s.doWhenBooted({
    Task({
        var loadSCDFiles;

        3.wait;

        // Samples
        Px.loadSamples("../../Samples/Live Coding/".resolveRelative);
        Nfx.setPresetsPath("../VST/presets/".resolveRelative);
        d = Px.samplesDict;
        ~buf = { |folder, file| Px.buf(folder, file) };

        // Px unit tests (PxTest.run)
        UnitTest.reportPasses = false;

        // Buffer for Granular SynthDefs
        ~g = { |folder, file|
            Buffer.readChannel(s, ~s.set(folder, file), channels:[0]);
        };

        // Ndef
        Ndef(\x).proxyspace.quant = 4;

        // Pattern Fading
        ~f = { |start, end, time, curve = 0|
            Pseg(Pseq([start, Pn(end)]), time, curve)
        };

        // Load SynthDefs and FX files
        loadSCDFiles = { |path|
            PathName.new(path.resolveRelative).files.select({ |file|
                file.extension == "scd";
            }).collect({ |file|
                file.fullPath.load;
            });
        };
        loadSCDFiles.("../Effects/");
        loadSCDFiles.("../SynthDefs/");

        // Wait, because otherwise it won't work for some reason
        3.wait;

        // Levels management and volume safety
        Server.default.options.safetyClipThreshold = 1;

        // Extensions
        "DDWSnippets.scd".loadRelative;
        EventShortcuts.on;

        // Confirmation
        "Setup done!".postln;
    }).start;
});

// Play it again, Sam
Pbind(\instrument, \tb303, \dur, 0.2, \freq, Pwhite(6, 10, 3) * 10 ).play;
)