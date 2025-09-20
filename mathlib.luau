--[[
    ███╗   ███╗ █████╗ ████████╗██╗  ██╗     ██╗     ██╗██████╗ 
    ████╗ ████║██╔══██╗╚══██╔══╝██║  ██║     ██║     ██║██╔══██╗
    ██╔████╔██║███████║   ██║   ███████║     ██║     ██║██████╔╝
    ██║╚██╔╝██║██╔══██║   ██║   ██╔══██║     ██║     ██║██╔══██╗
    ██║ ╚═╝ ██║██║  ██║   ██║   ██║  ██║     ███████╗██║██████╔╝
    ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝     ╚══════╝╚═╝╚═════╝ 
    
    Advanced Mathematics Library for Roblox
    Created by .schlonny
    Version: 2.1.1
    License: MIT
    Github: https://github.com/zeropointerexception/roblox-mathlib
    
    Features:
    • Advanced noise generation (Perlin, Simplex, Value)
    • Vector & matrix operations
    • Interpolation & easing functions
    • Geometric calculations
    • Statistical functions
    • Custom random generators
    • Mersenne Twister 
    • Shuffles using Fisher-Yates algorithm
]]--

local mathlib = {}

--[[
    ========================================
    CONSTANTS & CONFIGURATION
    ========================================
]]--
mathlib.PHI = (1 + math.sqrt(5)) / 2  -- Golden ratio
mathlib.TAU = math.pi * 2             -- Circle constant
mathlib.E = 2.718281828459045         -- Euler's number
mathlib.EPSILON = 1e-10               -- Floating point precision threshold

-- Conversion constants
mathlib.DEG_TO_RAD = math.pi / 180
mathlib.RAD_TO_DEG = 180 / math.pi

--[[
    ========================================
    CORE MATH OPERATIONS
    ========================================
]]--

--- Clamps a value between minimum and maximum bounds
--- @param value number Input value to clamp
--- @param min number Lower bound
--- @param max number Upper bound
--- @return number Clamped value
function mathlib.clamp(value, min, max)
	return value < min and min or (value > max and max or value)
end

--- Performs linear interpolation between two values
--- @param a number Start value
--- @param b number End value
--- @param t number Interpolation factor (0-1)
--- @return number Interpolated value
function mathlib.lerp(a, b, t)
	return a + (b - a) * mathlib.clamp(t, 0, 1)
end

--- Calculates the inverse linear interpolation parameter
--- @param a number Start value
--- @param b number End value
--- @param value number Current value
--- @return number Interpolation factor
function mathlib.inverseLerp(a, b, value)
	return a ~= b and mathlib.clamp((value - a) / (b - a), 0, 1) or 0
end

--- Remaps a value from one range to another
--- @param value number Input value
--- @param inMin number Original range minimum
--- @param inMax number Original range maximum
--- @param outMin number Target range minimum
--- @param outMax number Target range maximum
--- @return number Remapped value
function mathlib.remap(value, inMin, inMax, outMin, outMax)
	local t = mathlib.inverseLerp(inMin, inMax, value)
	return mathlib.lerp(outMin, outMax, t)
end

--- Rounds a number to specified decimal places
--- @param value number Input value
--- @param decimalPlaces number Number of decimal places
--- @return number Rounded value
function mathlib.round(value, decimalPlaces)
	decimalPlaces = decimalPlaces or 0
	local multiplier = 10 ^ decimalPlaces
	return math.floor(value * multiplier + 0.5) / multiplier
end

--- Returns the sign of a number (-1, 0, or 1)
--- @param x number Input value
--- @return number Sign value
function mathlib.sign(x)
	return x > 0 and 1 or (x < 0 and -1 or 0)
end

--- Checks if two numbers are approximately equal
--- @param a number First value
--- @param b number Second value
--- @param epsilon number Tolerance threshold
--- @return boolean True if approximately equal
function mathlib.approximately(a, b, epsilon)
	epsilon = epsilon or mathlib.EPSILON
	return math.abs(a - b) < epsilon
end

--[[
    ========================================
    NOISE GENERATION SYSTEM
    ========================================
]]--

-- Permutation table for gradient noise
local permutation = {
	151,160,137,91,90,15,131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,
	8,99,37,240,21,10,23,190,6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,
	35,11,32,57,177,33,88,237,149,56,87,174,20,125,136,171,168,68,175,74,165,71,
	134,139,48,27,166,77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,
	55,46,245,40,244,102,143,54,65,25,63,161,1,216,80,73,209,76,132,187,208,89,
	18,169,200,196,135,130,116,188,159,86,164,100,109,198,173,186,3,64,52,217,226,
	250,124,123,5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,
	189,28,42,223,183,170,213,119,248,152,2,44,154,163,70,221,153,101,155,167,43,
	172,9,129,22,39,253,19,98,108,110,79,113,224,232,178,185,112,104,218,246,97,
	228,251,34,242,193,238,210,144,12,191,179,162,241,81,51,145,235,249,14,239,
	107,49,192,214,31,181,199,106,157,184,84,204,176,115,121,50,45,127,4,150,254,
	138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180
}

-- Double permutation for wrapping
local p = {}
for i = 0, 511 do
	p[i] = permutation[(i % 256) + 1]
end

-- for smooth interpolation
local function fade(t)
	return t * t * t * (t * (t * 6 - 15) + 10)
end

-- Gradient func for Perlin noise
local function grad(hash, x, y, z)
	local h = hash % 16
	local u = h < 8 and x or y
	local v = h < 4 and y or (h == 12 or h == 14) and x or z
	return ((h % 2) == 0 and u or -u) + ((h % 3) == 0 and v or -v)
end

--- Generates 3D Perlin noise
--- @param x number X coordinate
--- @param y number Y coordinate
--- @param z number Z coordinate
--- @return number Noise value (-1 to 1)
function mathlib.perlinNoise3D(x, y, z)
	local X = math.floor(x) % 256
	local Y = math.floor(y) % 256
	local Z = math.floor(z) % 256

	x = x - math.floor(x)
	y = y - math.floor(y)
	z = z - math.floor(z)

	local u = fade(x)
	local v = fade(y)
	local w = fade(z)

	local A = p[X] + Y
	local AA = p[A] + Z
	local AB = p[A + 1] + Z
	local B = p[X + 1] + Y
	local BA = p[B] + Z
	local BB = p[B + 1] + Z
	return mathlib.lerp(w, mathlib.lerp(v, mathlib.lerp(u, grad(p[AA], x, y, z),
		grad(p[BA], x - 1, y, z)),
		mathlib.lerp(u, grad(p[AB], x, y - 1, z),
			grad(p[BB], x - 1, y - 1, z))),
		mathlib.lerp(v, mathlib.lerp(u, grad(p[AA + 1], x, y, z - 1),
			grad(p[BA + 1], x - 1, y, z - 1)),
			mathlib.lerp(u, grad(p[AB + 1], x, y - 1, z - 1),
				grad(p[BB + 1], x - 1, y - 1, z - 1))))
end

--- Generates 2D Perlin noise
--- @param x number X coordinate
--- @param y number Y coordinate
--- @return number Noise value (-1 to 1)
function mathlib.perlinNoise2D(x, y)
	return mathlib.perlinNoise3D(x, y, 0)
end

--- Generates 1D Perlin noise 
--- @param x number Coordinate
--- @return number Noise value (-1 to 1)
function mathlib.perlinNoise1D(x)
	return mathlib.perlinNoise3D(x, 0, 0)
end

--- Fractional Brownian Motion for natural-looking noise
--- @param x number X coordinate
--- @param y number Y coordinate
--- @param z number Z coordinate
--- @param octaves number Number of noise layers
--- @param persistence number Amplitude reduction per octave
--- @param lacunarity number Frequency increase per octave
--- @return number fBm noise value
function mathlib.fbm(x, y, z, octaves, persistence, lacunarity)
	octaves = octaves or 4
	persistence = persistence or 0.5
	lacunarity = lacunarity or 2.0

	local total = 0
	local frequency = 1.0
	local amplitude = 1.0
	local maxValue = 0

	for i = 1, octaves do
		total = total + mathlib.perlinNoise3D(x * frequency, y * frequency, z * frequency) * amplitude
		maxValue = maxValue + amplitude
		amplitude = amplitude * persistence
		frequency = frequency * lacunarity
	end

	return total / maxValue
end

--***-- Simplex Noise --***--

local simplex_gradients = {
	{1, 1, 0}, {-1, 1, 0}, {1, -1, 0}, {-1, -1, 0},
	{1, 0, 1}, {-1, 0, 1}, {1, 0, -1}, {-1, 0, -1},
	{0, 1, 1}, {0, -1, 1}, {0, 1, -1}, {0, -1, -1}
}

-- Simplex permutation table
local simplex_perm = {}
for i = 0, 511 do
	simplex_perm[i] = p[i % 256]
end

local F3 = 1.0 / 3.0
local G3 = 1.0 / 6.0

--- 3D Simplex Noise
--- @param x number X coordinate
--- @param y number Y coordinate
--- @param z number Z coordinate
--- @return number Noise value (-1 to 1)
function mathlib.simplexNoise3D(x, y, z)

	local s = (x + y + z) * F3
	local i = math.floor(x + s)
	local j = math.floor(y + s)
	local k = math.floor(z + s)

	local t = (i + j + k) * G3
	local X0 = i - t
	local Y0 = j - t
	local Z0 = k - t
	local x0 = x - X0
	local y0 = y - Y0
	local z0 = z - Z0

	--current simplex
	local i1, j1, k1, i2, j2, k2
	if x0 >= y0 then
		if y0 >= z0 then
			i1, j1, k1, i2, j2, k2 = 1, 0, 0, 1, 1, 0
		elseif x0 >= z0 then
			i1, j1, k1, i2, j2, k2 = 1, 0, 0, 1, 0, 1
		else
			i1, j1, k1, i2, j2, k2 = 0, 0, 1, 1, 0, 1
		end
	else
		if y0 < z0 then
			i1, j1, k1, i2, j2, k2 = 0, 0, 1, 0, 1, 1
		elseif x0 < z0 then
			i1, j1, k1, i2, j2, k2 = 0, 1, 0, 0, 1, 1
		else
			i1, j1, k1, i2, j2, k2 = 0, 1, 0, 1, 1, 0
		end
	end

	local x1 = x0 - i1 + G3
	local y1 = y0 - j1 + G3
	local z1 = z0 - k1 + G3

	local x2 = x0 - i2 + 2.0 * G3
	local y2 = y0 - j2 + 2.0 * G3
	local z2 = z0 - k2 + 2.0 * G3

	local x3 = x0 - 1.0 + 3.0 * G3
	local y3 = y0 - 1.0 + 3.0 * G3
	local z3 = z0 - 1.0 + 3.0 * G3

	local ii = i % 255
	local jj = j % 255
	local kk = k % 255

	local gi0 = simplex_perm[ii + simplex_perm[jj + simplex_perm[kk]]] % 12
	local gi1 = simplex_perm[ii + i1 + simplex_perm[jj + j1 + simplex_perm[kk + k1]]] % 12
	local gi2 = simplex_perm[ii + i2 + simplex_perm[jj + j2 + simplex_perm[kk + k2]]] % 12
	local gi3 = simplex_perm[ii + 1 + simplex_perm[jj + 1 + simplex_perm[kk + 1]]] % 12

	local t0 = 0.6 - x0*x0 - y0*y0 - z0*z0
	local n0 = t0 < 0 and 0 or t0*t0*t0*t0 * mathlib.dot(
		simplex_gradients[gi0+1][1], simplex_gradients[gi0+1][2], simplex_gradients[gi0+1][3],
		x0, y0, z0
	)

	local t1 = 0.6 - x1*x1 - y1*y1 - z1*z1
	local n1 = t1 < 0 and 0 or t1*t1*t1*t1 * mathlib.dot(
		simplex_gradients[gi1+1][1], simplex_gradients[gi1+1][2], simplex_gradients[gi1+1][3],
		x1, y1, z1
	)

	local t2 = 0.6 - x2*x2 - y2*y2 - z2*z2
	local n2 = t2 < 0 and 0 or t2*t2*t2*t2 * mathlib.dot(
		simplex_gradients[gi2+1][1], simplex_gradients[gi2+1][2], simplex_gradients[gi2+1][3],
		x2, y2, z2
	)

	local t3 = 0.6 - x3*x3 - y3*y3 - z3*z3
	local n3 = t3 < 0 and 0 or t3*t3*t3*t3 * mathlib.dot(
		simplex_gradients[gi3+1][1], simplex_gradients[gi3+1][2], simplex_gradients[gi3+1][3],
		x3, y3, z3
	)

	return 32.0 * (n0 + n1 + n2 + n3)
end

--- 2D Simplex Noise
--- @param x number X coordinate
--- @param y number Y coordinate
--- @return number Noise value (-1 to 1)
function mathlib.simplexNoise2D(x, y)
	local s = (x + y) * 0.366025403784439  -- F2 = (sqrt(3)-1)/2
	local i = math.floor(x + s)
	local j = math.floor(y + s)

	local t = (i + j) * 0.211324865405187  -- G2 = (3-sqrt(3))/6
	local X0 = i - t
	local Y0 = j - t
	local x0 = x - X0
	local y0 = y - Y0

	local i1, j1 --current simplex
	if x0 > y0 then
		i1, j1 = 1, 0  -- Lower triangl, XY order
	else
		i1, j1 = 0, 1  -- Upper triangle YX order
	end

	local x1 = x0 - i1 + 0.211324865405187
	local y1 = y0 - j1 + 0.211324865405187

	local x2 = x0 - 0.577350269189626  -- 1.0 - 2.0 * G2
	local y2 = y0 - 0.577350269189626

	local ii = i % 255
	local jj = j % 255

	local gi0 = simplex_perm[ii + simplex_perm[jj]] % 12
	local gi1 = simplex_perm[ii + i1 + simplex_perm[jj + j1]] % 12
	local gi2 = simplex_perm[ii + 1 + simplex_perm[jj + 1]] % 12

	local t0 = 0.5 - x0*x0 - y0*y0
	local n0 = t0 < 0 and 0 or t0*t0 * t0*t0 * mathlib.dot(
		simplex_gradients[gi0+1][1], simplex_gradients[gi0+1][2], 0,
		x0, y0, 0
	)

	local t1 = 0.5 - x1*x1 - y1*y1
	local n1 = t1 < 0 and 0 or t1*t1 * t1*t1 * mathlib.dot(
		simplex_gradients[gi1+1][1], simplex_gradients[gi1+1][2], 0,
		x1, y1, 0
	)

	local t2 = 0.5 - x2*x2 - y2*y2
	local n2 = t2 < 0 and 0 or t2*t2 * t2*t2 * mathlib.dot(
		simplex_gradients[gi2+1][1], simplex_gradients[gi2+1][2], 0,
		x2, y2, 0
	)

	return 70.0 * (n0 + n1 + n2)
end


--[[
    ========================================
    VECTOR & MATRIX OPERATIONS
    ========================================
]]--

--- Calculates 2D/3D distance between points
--- @param x1 number First point X
--- @param y1 number First point Y
--- @param x2 number Second point X
--- @param y2 number Second point Y
--- @param z1 number Optional first point Z
--- @param z2 number Optional second point Z
--- @return number Distance between points
function mathlib.distance(...)
	local args = {...}

	if #args == 4 then
		-- 2D case: x1, y1, x2, y2
		return math.sqrt((args[3] - args[1])^2 + (args[4] - args[2])^2)
	elseif #args == 6 then
		-- 3D case: x1, y1, z1, x2, y2, z2
		return math.sqrt((args[4] - args[1])^2 + (args[5] - args[2])^2 + (args[6] - args[3])^2)
	else
		error("Invalid number of arguments for distance. Expected 4 (2D) or 6 (3D) parameters.")
	end
end

--- Calculates magnitude of a 2D/3D vector
--- @param x number X component
--- @param y number Y component
--- @param z number Optional Z component
--- @return number Vector magnitude
function mathlib.magnitude(x, y, z)
	if z then
		return math.sqrt(x*x + y*y + z*z)
	else
		return math.sqrt(x*x + y*y)
	end
end

--- Normalizes a 2D/3D vector
--- @param x number X component
--- @param y number Y component
--- @param z number Optional Z component
--- @return number Normalized X
--- @return number Normalized Y
--- @return number Normalized Z (if provided)
function mathlib.normalize(x, y, z)
	local mag = mathlib.magnitude(x, y, z)
	if mag > mathlib.EPSILON then  
		if z then
			return x/mag, y/mag, z/mag
		else
			return x/mag, y/mag
		end
	end
	-- If magnitude is zero, return zero vector
	if z then
		return 0, 0, 0
	else
		return 0, 0
	end
end

--- Calculates dot product of two vectors
--- @param x1 number First vector X
--- @param y1 number First vector Y
--- @param z1 number First vector Z
--- @param x2 number Second vector X
--- @param y2 number Second vector Y
--- @param z2 number Second vector Z
--- @return number Dot product
function mathlib.dot(...)
	local args = {...}

	if #args == 4 then
		-- 2D case: x1, y1, x2, y2
		return args[1] * args[3] + args[2] * args[4]
	elseif #args == 6 then
		-- 3D case: x1, y1, z1, x2, y2, z2
		return args[1] * args[4] + args[2] * args[5] + args[3] * args[6]
	else
		return("Invalid number of arguments for dot product. Expected 4 (2D) or 6 (3D) parameters.")
	end
end
--- Calculates cross product of two 3D vectors
--- @param x1 number First vector X
--- @param y1 number First vector Y
--- @param z1 number First vector Z
--- @param x2 number Second vector X
--- @param y2 number Second vector Y
--- @param z2 number Second vector Z
--- @return number Cross product X
--- @return number Cross product Y
--- @return number Cross product Z
function mathlib.cross(x1, y1, z1, x2, y2, z2)
	return y1*z2 - z1*y2, z1*x2 - x1*z2, x1*y2 - y1*x2
end

--- Calculates angle between two vectors in radians
--- @param x1 number First vector X
--- @param y1 number First vector Y
--- @param z1 number First vector Z
--- @param x2 number Second vector X
--- @param y2 number Second vector Y
--- @param z2 number Second vector Z
--- @return number Angle in radians
function mathlib.angleBetween(x1, y1, z1, x2, y2, z2)
	local mag1 = mathlib.magnitude(x1, y1, z1)
	local mag2 = mathlib.magnitude(x2, y2, z2)

	if mag1 < mathlib.EPSILON or mag2 < mathlib.EPSILON then
		return 0  -- Avoid division by zero
	end

	local dot = mathlib.dot(x1, y1, z1, x2, y2, z2)
	return math.acos(mathlib.clamp(dot / (mag1 * mag2), -1, 1))
end

--[[
    ========================================
    INTERPOLATION & EASING FUNCTIONS
    ========================================
]]--

--- Smooth step interpolation
--- @param edge0 number Lower edge
--- @param edge1 number Upper edge
--- @param x number Input value
--- @return number Interpolated value
function mathlib.smoothStep(edge0, edge1, x)
	x = mathlib.clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0)
	return x * x * (3 - 2 * x)
end

--- Smoother step interpolation
--- @param edge0 number Lower edge
--- @param edge1 number Upper edge
--- @param x number Input value
--- @return number Interpolated value
function mathlib.smootherStep(edge0, edge1, x)
	x = mathlib.clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0)
	return x * x * x * (x * (x * 6 - 15) + 10)
end

--- Cosine interpolation
--- @param y1 number Start value
--- @param y2 number End value
--- @param mu number Interpolation factor
--- @return number Interpolated value
function mathlib.cosineInterpolate(y1, y2, mu)
	local mu2 = (1 - math.cos(mu * math.pi)) / 2
	return y1 * (1 - mu2) + y2 * mu2
end

--- Cubic interpolation
--- @param y0 number Point before start
--- @param y1 number Start value
--- @param y2 number End value
--- @param y3 number Point after end
--- @param mu number Interpolation factor
--- @return number Interpolated value
function mathlib.cubicInterpolate(y0, y1, y2, y3, mu)
	local a0 = y3 - y2 - y0 + y1
	local a1 = y0 - y1 - a0
	local a2 = y2 - y0
	local a3 = y1
	return a0 * mu^3 + a1 * mu^2 + a2 * mu + a3
end

--[[
    ========================================
    EASING FUNCTIONS
    ========================================
]]--

function mathlib.easeInQuad(t) return t * t end
function mathlib.easeOutQuad(t) return t * (2 - t) end
function mathlib.easeInOutQuad(t) return t < 0.5 and 2 * t * t or -1 + (4 - 2 * t) * t end
function mathlib.easeInCubic(t) return t * t * t end
function mathlib.easeOutCubic(t) t = t - 1; return t * t * t + 1 end
function mathlib.easeInOutCubic(t) return t < 0.5 and 4 * t * t * t or (t - 1) * (2 * t - 2) * (2 * t - 2) + 1 end

--[[
    ========================================
    ADVANCED MATH FUNCTIONS
    ========================================
]]--

--- Calculates factorial of a number
--- @param n integer Input number
--- @return integer Factorial result
function mathlib.factorial(n)
	if n < 0 then return 0 end
	if n == 0 then return 1 end
	local result = 1
	for i = 1, n do
		result = result * i
	end
	return result
end

--- Approximates the Gamma function
--- @param z number Input value
--- @return number Gamma result
function mathlib.gamma(z)
	if z <= 0 then return math.huge end
	if z == 1 then return 1 end
	if z == 0.5 then return math.sqrt(math.pi) end

	local result = 1.0
	while z > 2 do
		z = z - 1
		result = result * z
	end

	while z < 1 do
		result = result / z
		z = z + 1
	end

	result = result * (1 - 0.5748646 * (z - 1) + 0.9512363 * (z - 1)^2 - 
		0.6998588 * (z - 1)^3 + 0.4245549 * (z - 1)^4 - 0.1010678 * (z - 1)^5)

	return result
end

--- Calculates binomial coefficient
--- @param n integer Total items
--- @param k integer Items to choose
--- @return integer Binomial coefficient
function mathlib.binomial(n, k)
	if k < 0 or k > n then return 0 end
	if k == 0 or k == n then return 1 end
	k = math.min(k, n - k)
	local result = 1
	for i = 1, k do
		result = result * (n - i + 1) / i
	end
	return result
end

--[[
    ========================================
    MERSENNE TWISTER RANDOM GENERATOR 
    ========================================
]]--

-- Mersenne Twister state
local mtState = {
	index = 625,
	mt = {},
	initialized = false
}

local function initializeMT(seed)
	seed = seed or (tick() * 1000) % 2147483647

	mtState.mt[1] = seed
	for i = 2, 624 do
		local prev = mtState.mt[i-1]
		local xor = bit32.bxor(prev, bit32.rshift(prev, 30))
		mtState.mt[i] = (1812433253 * xor + i) % 4294967296
	end

	mtState.index = 625
	mtState.initialized = true
end


local function generateMTNumbers()
	for i = 1, 624 do
		local y = bit32.bor(
			bit32.band(mtState.mt[i], 0x80000000),
			bit32.band(mtState.mt[(i % 624) + 1], 0x7FFFFFFF)
		)

		mtState.mt[i] = bit32.bxor(
			mtState.mt[(i + 397) % 624 + 1],
			bit32.rshift(y, 1)
		)

		if y % 2 ~= 0 then
			mtState.mt[i] = bit32.bxor(mtState.mt[i], 0x9908B0DF)
		end
	end
end

local function extractMTNumber()
	if not mtState.initialized then
		initializeMT() 
	end

	if mtState.index >= 625 then
		generateMTNumbers()
		mtState.index = 1
	end

	local y = mtState.mt[mtState.index]
	mtState.index = mtState.index + 1

	-- Tempering
	y = bit32.bxor(y, bit32.rshift(y, 11))
	y = bit32.bxor(y, bit32.band(bit32.lshift(y, 7), 0x9D2C5680))
	y = bit32.bxor(y, bit32.band(bit32.lshift(y, 15), 0xEFC60000))
	y = bit32.bxor(y, bit32.rshift(y, 18))

	return y % 4294967296
end

--- Mersenne Twister random number generator
--- @param min number|nil Minimum value (optional)
--- @param max number|nil Maximum value (optional)
--- @return number Random value
function mathlib.random(min, max)
	local randomValue = extractMTNumber() / 4294967295.0

	if min and max then
		return min + randomValue * (max - min)
	elseif min then
		return randomValue * min
	else
		return randomValue
	end
end

--- Sets seed for the Mersenne Twister generator
--- @param seed number Seed value
function mathlib.randomSeed(seed)
	initializeMT(seed)
end

--- Generates a random integer between min and max (inclusive)
--- @param min number Minimum value
--- @param max number Maximum value
--- @return integer Random integer
function mathlib.randomInt(min, max)
	return math.floor(mathlib.random(min, max + 1 - 1e-10))
end

--- Generates a random boolean value
--- @param probability number Probability of true (default: 0.5)
--- @return boolean Random boolean
function mathlib.randomBool(probability)
	probability = probability or 0.5
	return mathlib.random() < probability
end

--- Selects a random element from an array
--- @param array table Array to select from
--- @return any Random element
function mathlib.randomChoice(array)
	if #array == 0 then return nil end
	return array[mathlib.randomInt(1, #array)]
end

--- Shuffles an array using Fisher-Yates algorithm
--- @param array table Array to shuffle
--- @return table Shuffled array
function mathlib.shuffle(array)
	local result = {}
	for i = 1, #array do result[i] = array[i] end

	for i = #result, 2, -1 do
		local j = mathlib.randomInt(1, i)
		result[i], result[j] = result[j], result[i]
	end

	return result
end

--[[
    ========================================
    GEOMETRIC FUNCTIONS
    ========================================
]]--

--- Calculates area of a circle
--- @param radius number Circle radius
--- @return number Area
function mathlib.circleArea(radius)
	return math.pi * radius * radius
end

--- Calculates circumference of a circle
--- @param radius number Circle radius
--- @return number Circumference
function mathlib.circleCircumference(radius)
	return 2 * math.pi * radius
end

--- Calculates area of a triangle using Heron's formula
--- @param a number Side A length
--- @param b number Side B length
--- @param c number Side C length
--- @return number Area
function mathlib.triangleArea(a, b, c)
	local s = (a + b + c) / 2
	return math.sqrt(s * (s - a) * (s - b) * (s - c))
end

--- Calculates distance from point to line segment
--- @param px number Point X
--- @param py number Point Y
--- @param x1 number Line start X
--- @param y1 number Line start Y
--- @param x2 number Line end X
--- @param y2 number Line end Y
--- @return number Distance
function mathlib.pointToLineDistance(px, py, x1, y1, x2, y2)
	local l2 = (x2 - x1)^2 + (y2 - y1)^2
	if l2 < 1e-10 then
		return math.sqrt((px - x1)^2 + (py - y1)^2)
	end
	-- Calculate the projection parameter t
	local t = ((px - x1) * (x2 - x1) + (py - y1) * (y2 - y1)) / l2
	t = math.max(0, math.min(1, t))

	-- Calculate the closest point on the line segment
	local closestX = x1 + t * (x2 - x1)
	local closestY = y1 + t * (y2 - y1)

	return math.sqrt((px - closestX)^2 + (py - closestY)^2)
end

--- Generates random point on unit circle
--- @return number X coordinate
--- @return number Y coordinate
function mathlib.randomOnCircle()
	local angle = mathlib.random(0, math.pi * 2)
	return math.cos(angle), math.sin(angle)
end

--- Generates random point in unit circle
--- @return number X coordinate
--- @return number Y coordinate
function mathlib.randomInCircle()
	local angle = mathlib.random(0, math.pi * 2)
	local radius = math.sqrt(mathlib.random())
	return math.cos(angle) * radius, math.sin(angle) * radius
end

--[[
    ========================================
    STATISTICAL FUNCTIONS
    ========================================
]]--

--- Calculates mean of values
--- @param ... number Values to average
--- @return number Mean value
function mathlib.mean(...)
	local values = {...}
	local sum = 0
	for i = 1, #values do
		sum = sum + values[i]
	end
	return sum / #values
end

--- Calculates standard deviation of values
--- @param ... number Values to process
--- @return number Standard deviation
function mathlib.standardDeviation(...)
	local values = {...}
	local avg = mathlib.mean(table.unpack(values))
	local sum = 0
	for i = 1, #values do
		sum = sum + (values[i] - avg)^2
	end
	return math.sqrt(sum / #values)
end

--[[
    ========================================
    EXPORT OF THE LIBRARY 
    ========================================
]]--

mathlib._VERSION = "2.1.1"
mathlib._AUTHOR = ".schlonny"
mathlib._DESCRIPTION = "Advanced mathematics library for Roblox"

return mathlib
