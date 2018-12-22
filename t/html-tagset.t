use v6;
use Test;
use CSS::Layout::HTML::TagSet;
my CSS::Layout::HTML::TagSet $tag-set .= new;
is ~$tag-set.elem-style('body'), "display:block; margin:8px; unicode-bidi:embed;",'<body> default style';
is ~$tag-set.elem-style('h5'), 'display:block; font-size:0.83em; font-weight:bolder; margin-bottom:1.5em; margin-top:1.5em; unicode-bidi:embed;', '<h5> default style';
done-testing;
