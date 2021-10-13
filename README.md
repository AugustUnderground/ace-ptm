# ace-PTM

[PTM](http://ptm.asu.edu/) ported to 
[Cadence® Spectre®](https://www.cadence.com/ko_KR/home/tools/custom-ic-analog-rf-design/circuit-simulation/spectre-simulation-platform.html),
mainly intended as backend for [AC²E](https://github.com/matthschw/ace).

## Technology

Includes 

+ 130nm (`./pdk/ptm-130.scs`)
+ 90nm (`./pdk/ptm-090.scs`) 
+ 65nm (`./pdk/ptm-065.scs`)
+ 45nm (`./pdk/ptm-045.scs`)
+ 32nm (`./pdk/ptm-032.scs`)

## Device Characterization

The primitive devices may be characterized by adjusting the `include` statement
in `chr/ptm-<n|p>mos.scs` and running:

```bash
$ spectre ./chr/ptm-nmos.scs
$ spectre ./chr/ptm-pmos.scs
```

This will produce a `.raw` file.

## Circuits

### op1

... under construction

### op2

Symmetrical Operational Amplifier with NMOS Differential-Pair.
Utilize the `SingleEndedOpampEnvironment` for characterization.

#### Schematic

![Symmetrical Operational Amplifier (`op2`)](fig/op2.png)

Parameters and performances can be found in `./op2/properties.json`.
