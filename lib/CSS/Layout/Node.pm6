use v6;
use CSS::Layout;
use CSS::Properties::Box;

class CSS::Layout::Node
    is CSS::Properties::Box
    does CSS::Layout {
    subset Leaf  of CSS::Layout::Node where { ! .kids }

}

