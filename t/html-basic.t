use v6;
use Test;
use LibXML::Document;
use LibXML::Element;
use LibXML::Text;
use CSS::Properties;
use CSS::Layout::HTML::TagSet;

my CSS::Layout::HTML::TagSet $tag-style .= new;

plan 11;

my $page-width;
my $page-height;

diag "loading html";
my LibXML::Document $root .= parse: :html, :file<t/html/basic-p-tag.html>;
todo "more stuff";
flunk "do more stuff...";

sub clone($css is rw, Bool $copied is rw) {
    $copied++ ?? $css !! $css .= clone;
}

for $root.first('html/body').nonBlankChildNodes     {
    my Bool $f = False;
    when LibXML::Text {
        todo "XML::Text elems";
        flunk "plain text tests";
    }

    when LibXML::Element {
        my CSS::Properties $css = $tag-style.elem-style(.name);

        with .<@style> -> $style {
            diag "style: $style";
            lives-ok { clone($css, $f).inherit($style.Str) }, 'style processing';
            note ~$css;
            todo "style attribute processing";
            flunk "style tests";
        }
        with .<@dir> {
            given .Str.lc {
                when 'rtl'|'ltr' {
                    clone($css, $f).direction = $_;
                }
            }
        }

        given .tag {
            when 'bdo' { clone($css, $f).unicode-bidi //= 'bdi-override' }
            when 'div' { todo "div tests"; flunk "div tests" }
            when 'p' { todo "paragraph tests"; flunk "paragraph tests" }
            when 'span' { todo "span tests"; flunk "span tests" }
            default { diag "unhandled {.name} tag"; }
        }
    }

    when LibXML::Comment {}

    default { diag "unandled node: {.gist}" }
}

ok 'skeleton';
