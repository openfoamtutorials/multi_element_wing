Include "naca.geo";
Include "WindTunnel.geo";
Include "parameters.geo";

// Units are multiples of chord.

ce = 0;

airfoil_loops[] = {};
For k In {0 : airfoil_count - 1}
    le_x = all_le_x[k];
    le_y = all_le_y[k];
    aoa = all_aoa[k];
    chord = all_chord[k];
    Call SymmetricAirfoil;
    airfoil_loops[] += AirfoilLoop;
EndFor

WindTunnelHeight = 20;
WindTunnelLength = 40;
WindTunnelLc = 1;
Call WindTunnel;

Surface(ce++) = {WindTunnelLoop, airfoil_loops[]};
TwoDimSurf = ce - 1;
Recombine Surface{TwoDimSurf};

ids[] = Extrude {0, 0, 0.1}
{
	Surface{TwoDimSurf};
	Layers{1};
	Recombine;
};

Physical Surface("outlet") = {ids[2]};
Physical Surface("walls") = {ids[{3, 5}]};
Physical Surface("inlet") = {ids[4]};
surfaces_per_airfoil = 3;
airfoil_surface_count = surfaces_per_airfoil * airfoil_count;
Physical Surface("airfoil") = {ids[{6 : 6 + airfoil_surface_count - 1}]};
Physical Surface("frontAndBack") = {ids[0], TwoDimSurf};
Physical Volume("volume") = {ids[1]};

