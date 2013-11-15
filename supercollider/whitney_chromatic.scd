// Whitney Music Box - Chromatic Pitch Assignment - Jim Bumgardner

(
    var n = 48;
    var period = 180;

    SynthDef(\chime, { |freq = 440, amp = 0.2, sustain = 1|
	  var sig;
	  sig = SinOsc.ar(freq, 0, amp) * EnvGen.kr(Env.perc(0.01, sustain), doneAction: 2);
	  Out.ar(0, sig ! 2);    // sig ! 2 is the same as [sig, sig]
    }).add;

    // thanks to hjh
    p = Ppar(
      Array.fill(n, { arg i;
        Pbind(
            \instrument, \chime,
            \freq, 55 * (2**(i/12)),
            \amp, 1/n,
            \dur, period / (i + 1),
            \legato, 0.5
        )
    })
  ).play;

)

// p.play;
// p.stop;