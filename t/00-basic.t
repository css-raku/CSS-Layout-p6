use Test;
use CSS::Layout::HTML::TagSet;
use CSS::Layout::PageNode;
use CSS::Properties::Units :pt, :mm, :ops;
sub pt(*@vals) { [@vals.map: { .scale('pt').round}] }
sub mm(*@vals) { [@vals.map: { .scale('mm').round}] }

my $style = "size: a5; margin-left:3pt; background-image: url(t/images/semitransparent.gif); background-color: blue; opacity: .3; border: 1pt solid red";

my CSS::Layout::HTML::TagSet $tagset .= new;
my $declarations = $tagset.declarations<body>;
my CSS::Properties $css .= new: :$declarations, :$style;
my CSS::Layout::PageNode $root .= new: :$css;

is $root.css.display, 'block', "css.display";
is $root.css.unicode-bidi, 'embed', "css.unicode-bidi";
is pt(|$root.css.margin), [6, 6, 6, 3], "css.margin";
is pt(|$root.content), [588, 413, 7, 4], "content box";
is pt(|$root.margin), [595, 420, 0, 0], "margin box (pt)";
is mm(|$root.margin), [210, 148, 0, 0], "margin box (mm)";

done-testing;

