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

for $root.first('html/body').nonBlankChildNodes     {

    when LibXML::Text {
        todo "XML::Text elems";
        flunk "plain text tests";
    }

    when LibXML::Element {
        my CSS::Properties $css = $tag-style.elem-style(.name).clone;

        with .<@style> -> $style {
            diag "style: $style";
            lives-ok { $css.inherit($style.Str) }, 'style processing';
            note ~$css;
            todo "style attribute processing";
            flunk "style tests";
        }

        given .tag {
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
