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

// Samples
~samplesPath = "../../Samples/Live Coding/".resolveRelative;

// Tempo
~bpm = 117;
t = TempoClock.new(110 / 60).permanent_(true);
TempoClock.default.tempo = ~bpm / 60;

s.doWhenBooted({
    Task({
        var loadSCDFiles;

        3.wait;

        // Creates a dictionary with folders and files
        d = Dictionary.new;
        d.add(\foldernames -> PathName(~samplesPath).entries);
        for (0, d[\foldernames].size - 1,
            {
                arg i;
                if (d[\foldernames][i].folderName != "sets") {
                    d.add(d[\foldernames][i].folderName -> d[\foldernames][i].entries.collect({
                        arg sf;
                        Buffer.read(s, sf.fullPath);
                    }))
                }
            }
        );

        // Returns a buffer from the audio files in the sample folder
        ~buf = { |folder, file|
            var return, showTotal = { |folder|
                ("Folder" + folder + "maximum number is" + (d[folder].size - 1)).postln;
            };

            if (d[folder].size == 0)
            {
                ("Folder doesn't exist or empty").postln;
                d[folder].size;
            } {
                if (file.isNil)
                { d[folder] }
                {
                    if (file.isArray.not and: { file >= d[folder].size })
                    {
                        file = d[folder].size - 1;
                        showTotal.(folder);
                    };
                    d[folder][file];
                }
            };
        };

        // Sample sets
        ~drumkit = {
            arg set = "DrumSynth";
            var drumkitsPath = ~samplesPath.catArgs("sets/", set, "/").resolveRelative;
            var drumkitsFolder = PathName.new(drumkitsPath).folders;

            ~set = Dictionary.new;
            ~set.add(\foldernames -> PathName.new(drumkitsPath).entries);

            for (0, ~set[\foldernames].size - 1,
                {
                    arg i;
                    ~set.add(
                        ~set[\foldernames][i].folderName ->
                        ~set[\foldernames][i].entries.collect({
                        arg sf;
                        Buffer.read(s, sf.fullPath);
                    }))
                }
            );

            // Print set folders
            set.scatArgs("contains these folders:").postln;
            for (0, drumkitsFolder.size - 1, { | i |
                i.asString.scatArgs(drumkitsFolder.[i].folderName).postln;
            });
        };

        // Buffer for Granular SynthDefs
        ~g = { |folder, file|
            Buffer.readChannel(s, ~s.set(folder, file), channels:[0]);
        };

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