role CSS::Layout {
    has CSS::Layout @.kids;
    has Str $.tag;
    has Any $.payload;
}
