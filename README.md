# ace-PTM

[PTM](http://ptm.asu.edu/) ported to 
[Cadence® Spectre®](https://www.cadence.com/ko_KR/home/tools/custom-ic-analog-rf-design/circuit-simulation/spectre-simulation-platform.html),
mainly intended as backend for [AC²E](https://github.com/matthschw/ace).

## Technology

Includes the following device models:

+ 130nm: `./130/pdk/ptm.scs`
+ 90nm: `./090/pdk/ptm.scs`
+ 65nm: `./065/pdk/ptm.scs`
+ 45nm: `./045/pdk/ptm.scs`
+ 32nm: `./032/pdk/ptm.scs`

## Statistical Model

The `nfet` and `pfet` sub-circuits add a statistical variation to the `nmos`
and `pmos` models respectively.

## Device Characterization

The primitive devices may be characterized by adjusting the `include` statement
in `chr/ptm-<n|p>mos.scs` or passing the include directory to spectre via the
`-I` flag and running:

```bash
$ spectre -I./XXX/pdk ./chr/nmos.scs
$ spectre -I./XXX/pdk ./chr/pmos.scs
```

Alternatively, the script in `./src/char.pl` can be used.

```bash
perl ./src/char.pl [--tech NODE] [--nmos] [--pmos]
```

If no `NODE` is specified, all node swill be used. If neither device type is
specified, both will be used.

**Example:**

```bash
# Characterize everything.
$ perl ./src/char.pl 

# Characterize 90nm, 32nm and 130nm NMOS devices.
$ perl ./src/char.pl --tech 90 --tech 32 --tech 130 --nmos
```

## Testing

Running the test script in `./src/test.pl` should run through all technologies
once and produce no errors.

## Circuits

### op1

... under construction

### op2

Symmetrical Operational Amplifier with NMOS Differential-Pair.
Utilize the `SingleEndedOpampEnvironment` in ACE for characterization.

Or run from the command line via

```bash
$ spectre -I./XXX/pdk ./XXX/op2/input.scs
```

#### Schematic

![Symmetrical Operational Amplifier (`op2`)](https://github.com/matthschw/ace/blob/main/figures/op2.png?raw=true)

Parameters and performances can be found in `./op2/properties.json`.
