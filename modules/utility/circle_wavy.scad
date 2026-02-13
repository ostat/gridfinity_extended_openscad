wavy_circle_demo = false;

if(wavy_circle_demo && $preview){
  #circle_wavy(r=20);
  
  circle(r=20);
  
  translate([50,0,0])
  cylinder_wavy();
}

module circle_wavy(
    r = 20,
    amplitude = 1,
    frequency = 12,
    steps = 360)
{
    assert(is_num(steps) && steps > 0, "Steps must be positive");
    assert(is_num(frequency) && frequency > 0, "Frequency must be positive");
    assert(is_num(amplitude) && amplitude >= 0, "Amplitude must be positive");
    assert(is_num(r) && r > 0, "Radius must be positive");

    if(amplitude == 0){
        circle(r=r);
    }
    else {
        outer = [
            for (i = [0:steps])
                let(
                    angle = i * 360 / steps,
                    rad = r + sin(angle * frequency) * amplitude
                )
                [ rad * cos(angle), rad * sin(angle) ]
        ];

        polygon(outer);
    }
}

module cylinder_wavy(
    r = 20,
    h = 20,
    amplitude = 1,
    frequency = 12,
    steps = 360) {

    assert(is_num(steps) && steps > 0, "Steps must be positive");
    assert(is_num(frequency) && frequency > 0, "Frequency must be positive");
    assert(is_num(amplitude) && amplitude >= 0, "Amplitude must be positive");
    assert(is_num(r) && r > 0, "r must be positive");
    assert(is_num(h) && h > 0, "h must be positive");

    linear_extrude(height=h)
      circle_wavy(
      r = r,
      amplitude = amplitude,
      frequency = frequency,
      steps = steps);
}