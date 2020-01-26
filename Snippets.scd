(

DDWSnippets.put("Effects", "
(
~filePath = \"~/Dropbox/Music/Supercollider/Setup/Effects.scd\";
(~filePath.standardizePath).load;##
)
");

DDWSnippets.put("BPM", "
(
TempoClock.default.tempo = ##~bpm## / 60;
~filePath = \"~/Dropbox/Music/Supercollider/SynthDefs/SynthDefs.scd\";
(~filePath.standardizePath).load;
)
");

)
