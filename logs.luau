  11:49:07.311  ============================================================  -  Server - Script:43
  11:49:07.312   CONSTANTS  -  Server - Script:44
  11:49:07.312  ============================================================  -  Server - Script:45
  11:49:07.312    Expected: 1.6180339887  -  Server - Script:51
  11:49:07.313    Actual:   1.6180339887  -  Server - Script:52
  11:49:07.313    Difference: 0.0000000000  -  Server - Script:53
  11:49:07.315  ✅ PASS: PHI constant  -  Server - Script:33
  11:49:07.317    Expected: 6.2831853072  -  Server - Script:60
  11:49:07.317    Actual:   6.2831853072  -  Server - Script:61
  11:49:07.318  ✅ PASS: TAU constant  -  Server - Script:33
  11:49:07.318    Expected: 2.718281828459045  -  Server - Script:69
  11:49:07.319    Actual:   2.718281828459045  -  Server - Script:70
  11:49:07.319    Difference: 0.000000000000000  -  Server - Script:71
  11:49:07.320  ✅ PASS: E constant  -  Server - Script:33
  11:49:07.320  ============================================================  -  Server - Script:76
  11:49:07.320   CORE MATH OPERATIONS  -  Server - Script:77
  11:49:07.320  ============================================================  -  Server - Script:78
  11:49:07.321    Test 1 (within range): clamp(5, 1, 10) = 5 (expected 5)  -  Server - Script:89
  11:49:07.321    Test 2 (below range): clamp(0, 1, 10) = 1 (expected 1)  -  Server - Script:89
  11:49:07.321    Test 3 (above range): clamp(15, 1, 10) = 10 (expected 10)  -  Server - Script:89
  11:49:07.321  ✅ PASS: clamp function  -  Server - Script:33
  11:49:07.321    Test 1 (midpoint): lerp(0, 10, 0.5) = 5 (expected 5)  -  Server - Script:104
  11:49:07.321    Test 2 (start): lerp(0, 10, 0) = 0 (expected 0)  -  Server - Script:104
  11:49:07.322    Test 3 (end): lerp(0, 10, 1) = 10 (expected 10)  -  Server - Script:104
  11:49:07.322  ✅ PASS: lerp function  -  Server - Script:33
  11:49:07.322    Test 1 (midpoint): inverseLerp(0, 10, 5) = 0.50 (expected 0.50)  -  Server - Script:119
  11:49:07.322    Test 2 (start): inverseLerp(0, 10, 0) = 0.00 (expected 0.00)  -  Server - Script:119
  11:49:07.322    Test 3 (end): inverseLerp(0, 10, 10) = 1.00 (expected 1.00)  -  Server - Script:119
  11:49:07.323  ✅ PASS: inverseLerp function  -  Server - Script:33
  11:49:07.323    Test 1 (basic remap): remap(5, 0, 10, 0, 100) = 50 (expected 50)  -  Server - Script:133
  11:49:07.323    Test 2 (fractional remap): remap(2.5, 0, 5, 0, 10) = 5 (expected 5)  -  Server - Script:133
  11:49:07.323  ✅ PASS: remap function  -  Server - Script:33
  11:49:07.324    Test 1 (2 decimals): round(3.14159, 2) = 3.14 (expected 3.14)  -  Server - Script:147
  11:49:07.325    Test 2 (integer): round(3.14159, 0) = 3 (expected 3)  -  Server - Script:147
  11:49:07.325  ✅ PASS: round function  -  Server - Script:33
  11:49:07.326    Test 1 (positive): sign(5) = 1 (expected 1)  -  Server - Script:162
  11:49:07.326    Test 2 (negative): sign(-5) = -1 (expected -1)  -  Server - Script:162
  11:49:07.326    Test 3 (zero): sign(0) = 0 (expected 0)  -  Server - Script:162
  11:49:07.326  ✅ PASS: sign function  -  Server - Script:33
  11:49:07.327    Test 1 (approximately equal): approximately(1.0000001, 1, 0.001) = true (expected true)  -  Server - Script:176
  11:49:07.327    Test 2 (not approximately equal): approximately(1.1, 1, 0.001) = false (expected false)  -  Server - Script:176
  11:49:07.327  ✅ PASS: approximately function  -  Server - Script:33
  11:49:07.327  ============================================================  -  Server - Script:183
  11:49:07.327   NOISE GENERATION  -  Server - Script:184
  11:49:07.328  ============================================================  -  Server - Script:185
  11:49:07.328    Test 1: perlinNoise1D(0.50) = 0.062500 (range check: true)  -  Server - Script:192
  11:49:07.328    Test 2: perlinNoise1D(1.20) = 0.000000 (range check: true)  -  Server - Script:192
  11:49:07.328    Test 3: perlinNoise1D(3.70) = 0.466530 (range check: true)  -  Server - Script:192
  11:49:07.328  ✅ PASS: Perlin Noise 1D  -  Server - Script:33
  11:49:07.329    Test 1: perlinNoise2D(0.50, 0.50) = 0.250000 (range check: true)  -  Server - Script:203
  11:49:07.329    Test 2: perlinNoise2D(1.20, 3.40) = 0.105963 (range check: true)  -  Server - Script:203
  11:49:07.329    Test 3: perlinNoise2D(7.80, 2.10) = 0.836577 (range check: true)  -  Server - Script:203
  11:49:07.329  ✅ PASS: Perlin Noise 2D  -  Server - Script:33
  11:49:07.330    Test 1: perlinNoise3D(0.50, 0.50, 0.50) = 0.500000 (range check: true)  -  Server - Script:214
  11:49:07.330    Test 2: perlinNoise3D(1.20, 3.40, 5.60) = 0.582382 (range check: true)  -  Server - Script:214
  11:49:07.330    Test 3: perlinNoise3D(7.80, 2.10, 9.30) = 0.163080 (range check: true)  -  Server - Script:214
  11:49:07.330  ✅ PASS: Perlin Noise 3D  -  Server - Script:33
  11:49:07.330    Test 1: simplexNoise2D(0.50, 0.50) = -0.307157 (range check: true)  -  Server - Script:225
  11:49:07.331    Test 2: simplexNoise2D(1.20, 3.40) = 0.405937 (range check: true)  -  Server - Script:225
  11:49:07.331    Test 3: simplexNoise2D(7.80, 2.10) = -0.383068 (range check: true)  -  Server - Script:225
  11:49:07.331  ✅ PASS: Simplex Noise 2D  -  Server - Script:33
  11:49:07.331    Test 1: simplexNoise3D(0.50, 0.50, 0.50) = 0.000000 (range check: true)  -  Server - Script:236
  11:49:07.331    Test 2: simplexNoise3D(1.20, 3.40, 5.60) = 0.418929 (range check: true)  -  Server - Script:236
  11:49:07.332    Test 3: simplexNoise3D(7.80, 2.10, 9.30) = 0.019702 (range check: true)  -  Server - Script:236
  11:49:07.332  ✅ PASS: Simplex Noise 3D  -  Server - Script:33
  11:49:07.332    fbm(0.50, 0.50, 0.50) with octaves=4, persistence=0.50, lacunarity=2.00 = 0.291667  -  Server - Script:247
  11:49:07.332    Range check: true  -  Server - Script:249
  11:49:07.332  ✅ PASS: FBM function  -  Server - Script:33
  11:49:07.332  ============================================================  -  Server - Script:254
  11:49:07.333   VECTOR & MATRIX OPERATIONS  -  Server - Script:255
  11:49:07.333  ============================================================  -  Server - Script:256
  11:49:07.333    Test 1 (2D distance): distance(0, 0, 3, 4) = 5.000000 (expected 5.000000)  -  Server - Script:266
  11:49:07.333    Test 2 (3D distance): distance(0, 0, 0, 2, 3, 6) = 7.000000 (expected 7.000000)  -  Server - Script:266
  11:49:07.333  ✅ PASS: distance function  -  Server - Script:33
  11:49:07.334    Test 1 (2D magnitude): magnitude(3, 4) = 5.000000 (expected 5.000000)  -  Server - Script:280
  11:49:07.335    Test 2 (3D magnitude): magnitude(2, 3, 6) = 7.000000 (expected 7.000000)  -  Server - Script:280
  11:49:07.335  ✅ PASS: magnitude function  -  Server - Script:33
  11:49:07.336    Test 1 (2D normalize): normalize(3, 4) = 0.600000, 0.800000,   -  Server - Script:296
  11:49:07.336    Magnitude check: 1.000000 (should be close to 1.0)  -  Server - Script:300
  11:49:07.337    Test 2 (3D normalize): normalize(2, 3, 6) = 0.285714, 0.428571, 0.857143  -  Server - Script:296
  11:49:07.337    Magnitude check: 1.000000 (should be close to 1.0)  -  Server - Script:300
  11:49:07.337  ✅ PASS: normalize function  -  Server - Script:33
  11:49:07.337    Test 1 (3D dot product): dot(1, 2, 3, 4, 5, 6) = 32.000000 (expected 32.000000)  -  Server - Script:319
  11:49:07.338    Test 2 (2D dot product): dot(1, 2, 3, 4) = 11.000000 (expected 11.000000)  -  Server - Script:319
  11:49:07.338  ✅ PASS: dot product function  -  Server - Script:33
  11:49:07.338    cross(1, 0, 0, 0, 1, 0) = 0.000000, 0.000000, 1.000000  -  Server - Script:330
  11:49:07.338    Expected: 0, 0, 1  -  Server - Script:333
  11:49:07.338  ✅ PASS: cross product function  -  Server - Script:33
  11:49:07.338    angleBetween(1, 0, 0, 0, 1, 0) = 1.570796 radians (expected 1.570796)  -  Server - Script:345
  11:49:07.339    Difference: 0.000000 radians  -  Server - Script:347
  11:49:07.339  ✅ PASS: angleBetween function  -  Server - Script:33
  11:49:07.340  ============================================================  -  Server - Script:353
  11:49:07.340   INTERPOLATION & EASING FUNCTIONS  -  Server - Script:354
  11:49:07.340  ============================================================  -  Server - Script:355
  11:49:07.340    Test 1 (midpoint): smoothStep(0, 10, 5) = 0.500000 (expected 0.500000)  -  Server - Script:365
  11:49:07.341    Test 2 (above range): smoothStep(0, 10, 15) = 1.000000 (expected 1.000000)  -  Server - Script:365
  11:49:07.341  ✅ PASS: smoothStep function  -  Server - Script:33
  11:49:07.341    smootherStep(0, 10, 5) = 0.500000  -  Server - Script:374
  11:49:07.341  ✅ PASS: smootherStep function  -  Server - Script:33
  11:49:07.342    cosineInterpolate(0, 10, 0.5) = 5.000000 (expected 5.000000)  -  Server - Script:383
  11:49:07.342  ✅ PASS: cosineInterpolate function  -  Server - Script:33
  11:49:07.342    cubicInterpolate(0, 5, 10, 15, 0.5) = 7.500000  -  Server - Script:392
  11:49:07.342  ✅ PASS: cubicInterpolate function  -  Server - Script:33
  11:49:07.342    easeInQuad(0.50) = 0.250000 (expected 0.250000)  -  Server - Script:405
  11:49:07.343    easeOutQuad(0.50) = 0.750000 (expected 0.750000)  -  Server - Script:405
  11:49:07.343    easeInCubic(0.50) = 0.125000 (expected 0.125000)  -  Server - Script:405
  11:49:07.343  ✅ PASS: easing functions  -  Server - Script:33
  11:49:07.343  ============================================================  -  Server - Script:412
  11:49:07.343   ADVANCED MATH FUNCTIONS  -  Server - Script:413
  11:49:07.344  ============================================================  -  Server - Script:414
  11:49:07.345    Test 1: factorial(5) = 120 (expected 120)  -  Server - Script:424
  11:49:07.345    Test 2: factorial(0) = 1 (expected 1)  -  Server - Script:424
  11:49:07.345  ✅ PASS: factorial function  -  Server - Script:33
  11:49:07.346    Test 1 (gamma(1)): gamma(1.00) = 1.000000 (expected 1.000000)  -  Server - Script:438
  11:49:07.346    Test 2 (gamma(0.5)): gamma(0.50) = 1.772454 (expected 1.772454)  -  Server - Script:438
  11:49:07.346  ✅ PASS: gamma function  -  Server - Script:33
  11:49:07.346    binomial(5, 2) = 10 (expected 10)  -  Server - Script:449
  11:49:07.346  ✅ PASS: binomial function  -  Server - Script:33
  11:49:07.347  ============================================================  -  Server - Script:455
  11:49:07.347   RANDOM NUMBER GENERATION  -  Server - Script:456
  11:49:07.347  ============================================================  -  Server - Script:457
  11:49:07.348    random() = 0.400213 (should be between 0 and 1)  -  Server - Script:462
  11:49:07.348    random(1, 10) = 3.857669 (should be between 1 and 10)  -  Server - Script:467
  11:49:07.349  ✅ PASS: random function  -  Server - Script:33
  11:49:07.349    randomInt(1, 10) = 8 (should be integer between 1 and 10)  -  Server - Script:473
  11:49:07.349  ✅ PASS: randomInt function  -  Server - Script:33
  11:49:07.349    randomBool(1) = true (should be true)  -  Server - Script:479
  11:49:07.350    randomBool(0) = false (should be false)  -  Server - Script:483
  11:49:07.350  ✅ PASS: randomBool function  -  Server - Script:33
  11:49:07.350    randomChoice({1, 2, 3, 4, 5}) = 4 (should be one of these values)  -  Server - Script:490
  11:49:07.350  ✅ PASS: randomChoice function  -  Server - Script:33
  11:49:07.350    shuffle({1, 2, 3, 4, 5}) = {2, 4, 3, 1, 5}  -  Server - Script:498
  11:49:07.350  ✅ PASS: shuffle function  -  Server - Script:33
  11:49:07.351  ============================================================  -  Server - Script:509
  11:49:07.351   GEOMETRIC FUNCTIONS  -  Server - Script:510
  11:49:07.351  ============================================================  -  Server - Script:511
  11:49:07.351    circleArea(5) = 78.539816 (expected 78.539816)  -  Server - Script:518
  11:49:07.351  ✅ PASS: circleArea function  -  Server - Script:33
  11:49:07.352    circleCircumference(5) = 31.415927 (expected 31.415927)  -  Server - Script:528
  11:49:07.352  ✅ PASS: circleCircumference function  -  Server - Script:33
  11:49:07.352    triangleArea(3, 4, 5) = 6.000000 (expected 6.000000)  -  Server - Script:538
  11:49:07.352  ✅ PASS: triangleArea function  -  Server - Script:33
  11:49:07.352    Test 1 (horizontal line distance): pointToLineDistance(0, 0, 0, 5, 5, 5) = 5.000000 (expected 5.000000)  -  Server - Script:553
  11:49:07.352    Test 2 (diagonal line distance): pointToLineDistance(0, 0, 0, 5, 5, 0) = 3.535534 (expected 3.535534)  -  Server - Script:553
  11:49:07.352  ✅ PASS: pointToLineDistance function  -  Server - Script:33
  11:49:07.353    randomOnCircle() = (-0.537020, 0.843569), magnitude = 1.000000  -  Server - Script:562
  11:49:07.353  ✅ PASS: randomOnCircle function  -  Server - Script:33
  11:49:07.353    randomInCircle() = (0.514848, -0.591168), magnitude = 0.783931  -  Server - Script:569
  11:49:07.354  ✅ PASS: randomInCircle function  -  Server - Script:33
  11:49:07.355  ============================================================  -  Server - Script:574
  11:49:07.355   STATISTICAL FUNCTIONS  -  Server - Script:575
  11:49:07.355  ============================================================  -  Server - Script:576
  11:49:07.355    mean(1, 2, 3, 4, 5) = 3.000000 (expected 3.000000)  -  Server - Script:583
  11:49:07.356  ✅ PASS: mean function  -  Server - Script:33
  11:49:07.356    standardDeviation(1, 2, 3, 4, 5) = 1.414214 (expected 1.414214)  -  Server - Script:593
  11:49:07.356  ✅ PASS: standardDeviation function  -  Server - Script:33
  11:49:07.357  ============================================================  -  Server - Script:599
  11:49:07.357  TEST SUMMARY  -  Server - Script:600
  11:49:07.357  ============================================================  -  Server - Script:601
  11:49:07.357  Total Tests: 43  -  Server - Script:602
  11:49:07.357  Passed: 43  -  Server - Script:603
  11:49:07.358  Failed: 0  -  Server - Script:604
  11:49:07.358  Success Rate: 100.0%  -  Server - Script:605
  11:49:07.358  All tests passed!  -  Server - Script:608
  11:49:10.111  Http requests are disabled, please publish your place and enable Http requests. Using saved API dump that may or may not work.  -  Client
  11:49:10.336  RequestAsync failed (status: %i %s)0unknown  -  Client
