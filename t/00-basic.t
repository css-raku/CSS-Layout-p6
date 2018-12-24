use Test;
use CSS::Layout::HTML::TagSet;
use CSS::Layout::PageNode;

my $style = "size: a5; margin-left:3pt; background-image: url(t/images/semitransparent.gif); background-color: blue; opacity: .3; border: 1pt solid red";

my CSS::Layout::HTML::TagSet $tagset .= new;
my $declarations = $tagset.declarations<body>;
my CSS::Properties $css .= new: :$declarations, :$style;
my CSS::Layout::PageNode $root .= new: :$css;

is $root.css.display, 'block', "css.display";
is $root.css.unicode-bidi, 'embed', "css.unicode-bidi";
is $root.css.margin, [8, 8, 8, 3], "css.margin";
is $root.content, [203, 141, 7, 4], "content box";
is $root.margin, [210, 148, 0, 0], "margin box";

done-testing;

