# ace-PTM

[PTM](http://ptm.asu.edu/) ported to 
[Cadence® Spectre®](https://www.cadence.com/ko_KR/home/tools/custom-ic-analog-rf-design/circuit-simulation/spectre-simulation-platform.html),
mainly intended as backend for [AC²E](https://github.com/matthschw/ace).

## Technology

Includes the following device models:

+ 130nm: `./pdk/130/ptm.scs`
+ 90nm: `./pdk/090/ptm.scs`
+ 65nm: `./pdk/065/ptm.scs`
+ 45nm: `./pdk/045/ptm.scs`
+ 32nm: `./pdk/032/ptm.scs`

## Device Characterization

The primitive devices may be characterized by adjusting the `include` statement
in `chr/ptm-<n|p>mos.scs` or passing the include directory to spectre via the
`-I` flag and running:

```bash
$ spectre -I./pdk/XXX ./chr/ptm-nmos.scs
$ spectre -I./pdk/XXX ./chr/ptm-pmos.scs
```

## Circuits

### op1

... under construction

### op2

Symmetrical Operational Amplifier with NMOS Differential-Pair.
Utilize the `SingleEndedOpampEnvironment` in ACE for characterization.

Or run from the command line via

```bash
$ spectre -I./pdk/XXX ./op2/input.scs
```

#### Schematic

![Symmetrical Operational Amplifier (`op2`)](fig/op2.png)

Parameters and performances can be found in `./op2/properties.json`.
