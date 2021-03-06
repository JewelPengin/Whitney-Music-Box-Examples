// Whitney Music Box - Harmonic Pitch Assignment - Jim Bumgardner

(
    var n = 48;
    var period = 180;

    SynthDef(\chime, { |freq = 440, amp = 0.2, sustain = 1|
	  var sig;
	  sig = SinOsc.ar(freq, 0, amp) * EnvGen.kr(Env.perc(0.01, sustain), doneAction: 2);
	  Out.ar(0, sig ! 2);
    }).add;

    // thanks to hjh
    p = Ppar(
      Array.fill(n, { arg i;
        Pbind(
            \instrument, \chime,
            \freq, 20 * (i + 1),
            \amp, 1/n,
            \dur, period / (i + 1),
            \legato, 0.5
        )
    })
  ).play;
)

// p.play;
// p.stop;


// Whitney - Another method - Jim Bumgardner
(
{
n = 48;
Mix.ar(
	i = (1..n);
	SinOsc.ar(
		20*i,
		mul: EnvGen.kr(
			Env.perc(0, 1),
			Impulse.kr(i/180),
			levelScale: 2/n,
			timeScale: 180/i
		)
	)
)
}.scope(1)
)

// one liner
play{mean({|i|SinOsc.ar((i+1)*20,mul:EnvGen.kr(Env.perc(0,180/48),Impulse.kr(i/180)))}!48)!2}

