<!--
meta property="og:title" content="Schlonny's Luau Math Library"
meta property="og:description" content="a Mathematics Library for Roblox that extends the built-in math functions, featuring vectors, matrices, curves, and other essential utilities."
meta property="og:image" content="https://raw.githubusercontent.com/zeropointerexception/roblox-mathlib/refs/heads/main/repoimage.jpg"
meta property="og:url" content="https://github.com/zeropointerexception/roblox-mathlib"
meta name="twitter:card" content="summary_large_image"
-->
Roblox Math Lib

A mathematics library for Roblox that extends the built-in math functions.

<p align="center"> <img src="https://img.shields.io/badge/Lua-2C2D72?style=flat&logo=lua&logoColor=white" alt="Lua"> <img src="https://img.shields.io/badge/Roblox-00A2FF?style=flat&logo=roblox&logoColor=white" alt="Roblox"> <img src="https://img.shields.io/badge/License-MIT-green?style=flat" alt="License"> <img src="https://img.shields.io/badge/Version-2.1.0-blue?style=flat" alt="Version"> </p>
Features

    Noise Generation: Perlin noise (1D, 2D, 3D) with Fractional Brownian Motion (fBm)

    Vector Operations: Magnitude, normalization, dot/cross products, angles

    Interpolation Methods: Linear, cosine, cubic, smoothstep, and smootherstep

    Easing Functions: Quadratic and cubic easing functions for animations

    Geometric Calculations: Area, distance, and point-line calculations

    Statistical Functions: Mean and standard deviation

    Custom Random Generation: Seedable random number generator

    Mathematical Constants: PHI, TAU, E, and conversion constants

Installation

    Download the mathlib.luau file

    Place it in your Roblox game

    Require it in your scripts:

```luau
local mathlib = require(path.to.mathlib)
```
Basic Operations
```luau

-- Clamping values
local clamped = mathlib.clamp(15, 0, 10)  -- Returns 10

-- Linear interpolation
local value = mathlib.lerp(0, 100, 0.5)  -- Returns 50

-- Rounding
local rounded = mathlib.round(3.14159, 2)  -- Returns 3.14
```

Noise Generation
```luau

-- 2D Perlin noise
local noise = mathlib.perlinNoise2D(x, y)

-- Fractional Brownian Motion for natural patterns
local fbmNoise = mathlib.fbm(x, y, z, 4, 0.5, 2.0)
```
Vector Operations
```luau

-- Calculate magnitude
local mag = mathlib.magnitude(3, 4)  -- Returns 5

-- Normalize a vector
local nx, ny = mathlib.normalize(10, 0)  -- Returns 1, 0

-- Dot product
local dot = mathlib.dot(1, 2, 3, 4, 5, 6)
```
Easing Functions
```luau

-- For smooth animations
local eased = mathlib.easeInOutQuad(progress)

API Reference
Core Functions

    clamp(value, min, max) - Constrains a value between bounds

    lerp(a, b, t) - Linear interpolation

    inverseLerp(a, b, value) - Inverse linear interpolation

    remap(value, inMin, inMax, outMin, outMax) - Remaps between ranges

    round(value, decimalPlaces) - Rounds to specified decimals

    sign(x) - Returns sign of number (-1, 0, or 1)

    approximately(a, b, epsilon) - Checks if values are nearly equal

Noise Functions

    perlinNoise1D(x) - 1D Perlin noise

    perlinNoise2D(x, y) - 2D Perlin noise

    perlinNoise3D(x, y, z) - 3D Perlin noise

    fbm(x, y, z, octaves, persistence, lacunarity) - Fractional Brownian Motion

Vector Operations

    distance(x1, y1, x2, y2, z1, z2) - Distance between points

    magnitude(x, y, z) - Vector magnitude

    normalize(x, y, z) - Normalizes a vector

    dot(x1, y1, z1, x2, y2, z2) - Dot product

    cross(x1, y1, z1, x2, y2, z2) - Cross product

    angleBetween(x1, y1, z1, x2, y2, z2) - Angle between vectors

Interpolation

    smoothStep(edge0, edge1, x) - Smooth step interpolation

    smootherStep(edge0, edge1, x) - Smoother step interpolation

    cosineInterpolate(y1, y2, mu) - Cosine interpolation

    cubicInterpolate(y0, y1, y2, y3, mu) - Cubic interpolation

Easing Functions

    easeInQuad(t), easeOutQuad(t), easeInOutQuad(t)

    easeInCubic(t), easeOutCubic(t), easeInOutCubic(t)

Advanced Math

    factorial(n) - Calculates factorial

    gamma(z) - Gamma function approximation

    binomial(n, k) - Binomial coefficient

Geometry

    circleArea(radius) - Area of a circle

    circleCircumference(radius) - Circumference of a circle

    triangleArea(a, b, c) - Area of a triangle (Heron's formula)

    pointToLineDistance(px, py, x1, y1, x2, y2) - Distance from point to line

Random Generation

    random(min, max) - Custom random number generator

    randomSeed(seed) - Sets random seed

    randomOnCircle() - Random point on unit circle

    randomInCircle() - Random point in unit circle

Statistical Functions

    mean(...) - Mean of values

    standardDeviation(...) - Standard deviation of values
```
Examples
Terrain Generation with Perlin Noise
```luau

local mathlib = require(script.Parent.mathlib)

for x = 1, 100 do
    for z = 1, 100 do
        local height = mathlib.fbm(x * 0.1, z * 0.1, 0, 4, 0.5, 2.0)
        height = mathlib.remap(height, -1, 1, 0, 50)
        -- Create terrain at this height
    end
end

Smooth Camera Movement
lua

local mathlib = require(script.Parent.mathlib)

function smoothFollow(camera, target, deltaTime)
    local currentPos = camera.Position
    local targetPos = target.Position
    
    local t = mathlib.easeOutQuad(deltaTime * 2)
    local newPos = mathlib.lerp(currentPos, targetPos, t)
    
    camera.Position = newPos
end
```
```luau
Constants

    PHI - Golden ratio (1.618...)

    TAU - Circle constant (6.283...)

    E - Euler's number (2.718...)

    EPSILON - Floating point precision threshold

    DEG_TO_RAD - Degrees to radians conversion

    RAD_TO_DEG - Radians to degrees conversion
```
License

This project is licensed under the MIT License - see the LICENSE file for details.
Contributing

    Fork the project

    Create your feature branch (git checkout -b feature/somenewfeature)

    Commit your changes (git commit -m 'Add some somenewfeature')

    Push to the branch (git push origin feature/somenewfeature)

    Open a Pull Request

Acknowledgments

    Created by .schlonny

    Inspired by various mathematical libraries and Roblox community needs

    Perlin noise implementation based on classic algorithm by Ken Perlin

Support

If you have any questions or issues, please open an issue on GitHub or contact me directly.
Discord: .schlonny
