// Parameters common to all airfoils.
XX = 12; // As in NACA00XX.
AirfoilLc = 0.005; // Grid cell size on surface of airfoil.
PointCount = 100; // Number of points to use on BSpline.

// Airfoil-specific parameters.
airfoil_count = 3; // total number of airfoils.
all_aoa[] = {-20, 15, 4}; // Angle of attack, in degrees.
all_chord[] = {0.2, 0.3, 1}; // chords of each airfoil, m.
all_le_x[] = {-0.25, 1.05, 0}; // Leading edge x-coordinate, m.
all_le_y[] = {-0.0, -0.15, 0}; // Leading edge y-coordinate, m.

