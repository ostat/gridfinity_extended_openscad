# Voronoi Pattern Overhang Prevention

## Overview

This feature adds new parameters to prevent 3D printing overhangs when using Voronoi patterns in Gridfinity bins.

## The Problem

Voronoi patterns create beautiful organic-looking cutouts, but they have a fundamental issue for 3D printing: cells that touch the borders of the pattern area create straight horizontal edges. When these patterns are used on vertical walls, these horizontal edges become overhangs that can cause:

- Poor print quality
- Drooping or sagging filament
- Need for support material
- Inconsistent results

## The Solution

Two new parameters have been added to all Voronoi pattern configurations:

### 1. `fillBorderCells` (boolean, default: false)

When enabled, this creates an automatic margin around the pattern to eliminate incomplete Voronoi cells at the borders.

**How it works:**
- Reduces the area where Voronoi points are generated
- Only complete Voronoi cells are created
- Border cells that would create horizontal edges are eliminated
- The margin is automatically calculated as `cellsize/2` by default

**Usage in scripts:**
```openscad
// For wall patterns
wallpattern_pattern_voronoi_fill_border = true;

// For floor patterns
floorpattern_pattern_voronoi_fill_border = true;
```

### 2. `borderMargin` (number, default: -1)

Allows manual control over the border margin size.

**Values:**
- `-1`: Auto-calculate margin (uses cellsize/2 when fillBorderCells is true)
- `0` or positive: Use specific margin size in millimeters

**Usage in scripts:**
```openscad
// Auto margin
wallpattern_pattern_voronoi_border_margin = -1;

// Custom 8mm margin
wallpattern_pattern_voronoi_border_margin = 8;
```

## When to Use

### Use `fillBorderCells = true` when:
- ✅ Printing bins with Voronoi patterns on vertical walls
- ✅ You want the best print quality without supports
- ✅ Using `voronoigrid` or `voronoihexgrid` patterns
- ✅ The slightly reduced pattern area is acceptable

### Use custom `borderMargin` when:
- ✅ You want to fine-tune the margin size
- ✅ Your cell size is non-standard
- ✅ You want more or less border clearance

### Keep defaults when:
- ❌ Using patterns on horizontal surfaces (floor)
- ❌ The cells don't reach the borders anyway
- ❌ You're using a different pattern type (grid, hexgrid, brick)
- ❌ You prefer the visual appearance of border cells

## Examples

### Example 1: Wall Pattern with Overhang Prevention
```openscad
wallpattern_enabled = true;
wallpattern_style = "voronoigrid";
wallpattern_pattern_voronoi_noise = 0.75;
wallpattern_pattern_voronoi_fill_border = true;  // Enable overhang prevention
wallpattern_pattern_voronoi_border_margin = -1;  // Auto margin
```

### Example 2: Custom Margin
```openscad
wallpattern_enabled = true;
wallpattern_style = "voronoi";
wallpattern_pattern_voronoi_noise = 0.75;
wallpattern_pattern_voronoi_fill_border = false; // Don't use auto margin
wallpattern_pattern_voronoi_border_margin = 10;  // 10mm custom margin
```

### Example 3: Floor Pattern (Usually No Need for Border Fill)
```openscad
floorpattern_enabled = true;
floorpattern_style = "voronoigrid";
floorpattern_pattern_voronoi_noise = 0.75;
floorpattern_pattern_voronoi_fill_border = false; // Not needed for horizontal surface
```

## Testing

A test file is provided to visualize the effect: `demos/voronoi_overhang_test.scad`

This demo shows:
- Row 1: Default behavior (with border cells)
- Row 2: With border fill enabled (cleaner edges)
- Row 3: With custom margin (controlled border)

## Technical Details

### Implementation

The feature works by:
1. Calculating an effective border margin based on the `fillBorderCells` and `borderMargin` parameters
2. Reducing the canvas size for point generation by `2 × effectiveBorderMargin`
3. Generating Voronoi points within this reduced area
4. The final pattern is still cut to the original canvas size, but incomplete cells are eliminated

### Affected Files

- `modules/module_voronoi.scad` - Core Voronoi generation
- `modules/module_pattern_voronoi.scad` - Pattern-specific Voronoi
- `modules/module_patterns.scad` - Pattern settings infrastructure
- `modules/module_gridfinity_cup.scad` - Cup pattern application
- All main gridfinity scripts (basic_cup, drawers, etc.)

## Limitations

1. **Border Area**: Using `fillBorderCells` reduces the patterned area slightly. The amount depends on cell size.
2. **Visual Change**: The pattern will look different from the default as border cells are removed.
3. **Only for Voronoi**: This feature only applies to Voronoi patterns (voronoi, voronoigrid, voronoihexgrid).

## Compatibility

- ✅ Backward compatible: Default values maintain existing behavior
- ✅ Works with all Voronoi pattern variants
- ✅ Compatible with all existing pattern parameters
- ✅ Can be used on wall and floor patterns independently

## Credits

Feature implemented in response to issue request for preventing overhangs in Voronoi pattern generation.
