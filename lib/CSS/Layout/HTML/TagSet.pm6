use v6;

class CSS::Layout::HTML::TagSet {
    use CSS::Module;
    use CSS::Module::CSS3;
    use CSS::Properties;
    our %css;

    constant %Tags is export(:Properties) = do {
        my %asts;
        my CSS::Module $module = CSS::Module::CSS3.module;
        my $default-css = %?RESOURCES<xhtml.css>.absolute;
        my $actions = $module.actions.new;
        my $p = $module.grammar.parsefile($default-css, :$actions);
        my %ast = $p.ast;
        for %ast<stylesheet>.list {
            with .<ruleset> {
                my $declarations = .<declarations>;
                for .<selectors>.list {
                    for .<selector>.list {
                        for .<simple-selector>.list {
                            with .<qname><element-name> -> $elem-name {
                                %asts{$elem-name}.append: $declarations.list;
                            }
                        }
                    }
                }
            }
        }
        %asts;
    }

    method declarations { %Tags }

    method elem-style(Str $_) {
        %css{.lc} //= CSS::Properties.new(declarations => %Tags{.lc});
    }

}
