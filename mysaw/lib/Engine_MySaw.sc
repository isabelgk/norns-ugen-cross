Engine_MySaw : CroneEngine {
	var params;

	alloc {
		SynthDef("MySaw", {
			arg out = 0,
			freq, sub_div, noise_level,
			cutoff, resonance,
			attack, release,
			amp, pan;

			var pulse = Pulse.ar(freq: freq);

			var saw = MySaw.ar(freq: freq);
            //        ^~~~~~~~~~~~~~~ Use our own sawtooth generator

			var sub = Pulse.ar(freq: freq/sub_div);
			var noise = WhiteNoise.ar(mul: noise_level);
			var mix = Mix.ar([pulse,saw,sub,noise]);

			var envelope = Env.perc(attackTime: attack, releaseTime: release, level: amp).kr(doneAction: 2);
			var filter = MoogFF.ar(in: mix, freq: cutoff * envelope, gain: resonance);

			var signal = Pan2.ar(filter*envelope,pan);

			Out.ar(out,signal);
		}).add;

		params = Dictionary.newFrom([
			\sub_div, 2,
			\noise_level, 0.1,
			\cutoff, 8000,
			\resonance, 3,
			\attack, 0,
			\release, 0.4,
			\amp, 0.5,
			\pan, 0;
		]);

		params.keysDo({ arg key;
			this.addCommand(key, "f", { arg msg;
				params[key] = msg[1];
			});
		});

		this.addCommand("hz", "f", { arg msg;
			Synth.new("MySaw", [\freq, msg[1]] ++ params.getPairs)
		});
	}
}
