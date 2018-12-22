use v6;
use Test;
use PDF::Style::Body;
use PDF::API6;
use PDF::Page;
use XML;
use HTML::Parser::XML;
use CSS::Properties;
use CSS::Layout::HTML::TagSet;

my CSS::Layout::HTML::TagSet $tag-style .= new;

plan 13;

my $page-width;
my $page-height;

diag "loading html";
my $html = 't/html/basic-p-tag.html'.IO.slurp;
my HTML::Parser::XML $parser .= new;
my PDF::Style::Body $body-style .= new;
my PDF::API6 $pdf .= new;
my PDF::Page $page = $pdf.add-page;
todo "wire up PDF::API6 and PDF::Style...";
flunk "do more stuff...";
diag "loaded html";
diag :$html.perl;
diag "parsing...";
$parser.parse($html);
warn "parsed...";
my $xmldoc = $parser.xmldoc; # XML::Document
warn "progressing...";

my $root = $xmldoc.root;
my $body;

if $root.name eq 'html' {
    my @bodies = $root.nodes.grep({.can('name') && .name eq 'body' });
    die "unable to find html body"
        unless @bodies;
    die "html has multiple body elements"
        if @bodies > 1;
    $body = @bodies[0];
}
else {
    die "bad root element: $root";
}

for $body.nodes.list {

    when XML::Text {
        todo "XML::Text elems";
        flunk "plain text tests";
    }

    when XML::Element {
        my CSS::Properties $css = $tag-style.elem-style(.name).clone;

        with .<style> -> $style {
            diag "style: $style";
            lives-ok { $css.inherit($style) }, 'style processing';
            note ~$css;
            todo "style attribute processing";
            flunk "style tests";
        }

        given .name {
            when 'div' { todo "div tests"; flunk "div tests" }
            when 'p' { todo "paragraph tests"; flunk "paragraph tests" }
            when 'span' { todo "span tests"; flunk "span tests" }
            default { diag "unhandled {.name} tag"; }
        }
    }

    when XML::Comment {}

    default { diag "unandled node: {.gist}" }
}

$pdf.save-as: "tmp/html-basic.pdf";

ok 'skeleton';
