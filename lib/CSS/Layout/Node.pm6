use v6;
use CSS::Layout;

class CSS::Layout::Node does CSS::Layout {
    use PDF::Style::Element;
    has PDF::Style::Element $.element handles <box css>;
    has CSS::Layout::Node @.kids;
    has Str $.tag;
    has Any $.payload;

    subset Leaf  of CSS::Layout::Node where { ! .kids }

    method display {$!element.css.display}
}

