// This returns normalized y for a symmetric airfoil.
Macro NACA00
    // x is the normalized chord position in [0, c].
    // XX is the last 2 digits, which dictates maximum thickness.
    // NACA0012 for XX = 12, and maximum thickness is 0.12 of chord.
    y = 0.2969 * x^0.5;
    y += -0.1260 * x;
    y += -0.3516 * x^2;
    y += 0.2843 * x^3;
    y += -0.1015 * x^4;
    y *= 5.0 * XX / 100.0;
Return

Macro RotateAboutLe
    // Assumed inputs:
    //  Rotates pointId.
    //  aoa is the angle of attack in degrees.
    //  le_x, le_y is leading edge location.
    Rotate {{0, 0, 1}, {le_x, le_y, 0}, -aoa * Pi / 180.0}
    {
        Point{pointId};
    }
Return

Macro SymmetricAirfoil
    // draws a symmetric airfoil, given XX as in NACA00XX.
    // Assumed inputs:
    //  chord.
    //  PointCount specifies number of points.
    //  Draws le at {le_x, le_y} and te at aoa rotation of {le_x + 1, le_y}.
    //  ce is the current point id.
    //  AirfoilLc is the length characteristic on airfoil surface.
    //  aoa is the angle of attack in degrees.
    // Results: le, te, upper[], lower[], AirfoilSurface
    x = 0;
    increment = chord / PointCount;
    le = ce;
    Point(ce++) = {le_x, le_y, 0, AirfoilLc};
    te = ce;
    Point(ce++) = {le_x + chord, le_y, 0, AirfoilLc};
    pointId = te;
    Call RotateAboutLe;
    upper[] = {};
    lower[] = {};
    For x In {increment: 1 - increment: increment}
        // Printf("%f", x);
        Call NACA00;
        upper = {ce, upper[]};
        Point(ce++) = {le_x + x * chord, le_y + y * chord, 0, AirfoilLc};
        pointId = upper[0];
        Call RotateAboutLe;
        new_lower = ce;
        lower += new_lower;
        Point(ce++) = {le_x + x * chord, le_y - y * chord, 0, AirfoilLc};
        pointId = new_lower;
        Call RotateAboutLe;
    EndFor
    Line(ce++) = {te, upper[0]};
    upperTe = ce - 1;
    Line(ce++) = {lower[#lower[] - 1], te};
    lowerTe = ce - 1;
    BSpline(ce++) = {upper[], le, lower[]};
    AirfoilSurface = ce - 1;
    Line Loop(ce++) = {upperTe, AirfoilSurface, lowerTe};
    AirfoilLoop = ce - 1;
Return

