use v6.c;

use Cairo;


role Cairo::Simple::Context {

  multi method lines (
    *@points,
    :$x              = 0,
    :$y              = 0,
    :$stroke-color   = (0, 0, 0, 1),
    :$line-thickness = 1
  ) {
    samewith(
      $x,
      $y,
      $stroke-color,
      $line-thickness,
      |@points
    );
  }
  multi method lines (
    $x,
    $y,
    $stroke-color,
    $line-thickness,
    *@points
  ) {
    die "<points> must be XY pairs!" unless @points.elems %% 2;

    self.save;
    self.rgba( |$stroke-color );
    self.line_width($line-thickness);
    self.move_to($x, $y);
    self.line_to( |$_ ) for @points.rotor(2);
    self.restore;
  }


  multi method circle (
    :$x               = 0,
    :$y               = 0,
    :r(:$radius)      = 100,
    :$fill-color      = (1, 1, 1, 1);
    :$stroke-color    = (0, 0, 0, 1),
    :$line-thickness  = 1,
    :$from            = 0,
    :$to              = 2 * π,
    :$preserve        = False,
  ) {
    samewith(
      $x,
      $y,
      $radius,
      $fill-color,
      $stroke-color,
      $line-thickness,
      $from,
      $to,
      $preserve
    );
  }
  multi method circle (
    $x,
    $y,
    $radius,
    $fill-color      = (1, 1, 1, 1),
    $stroke-color    = (0, 0, 0, 1),
    $line-thickness  = 1,
    $from            = 0,
    $to              = 2 * π,
    $preserve        = False
  ) {
    self.save;
    self.arc($x, $y,  $radius, 0, 2 * π);
    self.rgba( |$fill-color ) if $fill-color;
    self.fill( :preserve );
    self.rgba( |$stroke-color ) if $stroke-color;
    self.line_width = $line-thickness;
    self.stroke( :$preserve );
    self.restore;
  }

  multi method oval (
    :$x                                = 0,
    :$y                                = 0,
    :width(:$w)                        = 200,
    :height(:$h)                       = 100,
    :fill(:$fill-color)                = (1, 1, 1, 1);
    :line(:line-color(:$stroke-color)) = (0, 0, 0, 1),
    :stroke(:$line-thickness)          = 1,
    :$from                             = 0,
    :$to                               = 2 * π,
    :ox(:$offset-x)                    = 0,
    :oy(:$offset-y)                    = 0,
    :$preserve                         = False
  ) {
    samewith(
      $x,
      $y,
      $w,
      $h,
      $fill-color,
      $stroke-color,
      $line-thickness,
      $from,
      $to,
      $offset-x,
      $offset-y,
      $preserve
    );
  }
  multi method oval (
    $x,
    $y,
    $w,
    $h,
    $fill-color      = (1, 1, 1, 1);
    $stroke-color    = (0, 0, 0, 1),
    $line-thickness  = 1,
    $from            = 0,
    $to              = 2 * π,
    $offset-x        = 0,
    $offset-y        = 0,
    $preserve        = False
  ) {
    self.save;
    self.translate($x, $y);
    self.scale($w, $h);
    self.arc($offset-x, $offset-y, 1, $from, $to);
    self.rgba( |$fill-color ) if $fill-color;
    self.fill( :preserve );
    self.rgba( |$stroke-color ) if $stroke-color;
    self.line_width = $line-thickness;
    self.stroke( :$preserve );
    self.restore;
  }

  multi method arc (|c) {
    self.oval(|c);
  }

}
