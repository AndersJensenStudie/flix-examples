use RichString.Color.Default
use RichString.Color.Rgb
use RichString.Span.Span
use RichString.Color
use RichString.Style
use RichString.Style.{Bold, Underline}

def main(): Unit \ IO = 
    let r = RichString.bold("Hello") + RichString.bgCyan("World");
    let res = toHTMLParagraph(r);
    println(res)

    ///
    /// Returns a string representing a HTML `p` element that corresponds to the given `RichString`
    ///
    def toHTMLParagraph(r: RichString): String = 
        let RichString.RichString(c) = r;
        let cs = Chain.map(spanToHTMLString, c);
        let res = Chain.foldLeft(acc -> str -> "${acc}${str}", "", cs);
        "<p>${res}</p>"

    ///
    /// Replaces characters that should be replaced in String `s`
    /// with escaped HTML-equivalent. 
    ///
    def escapeHTML(s: String): String \ {} = 
        region r {
            let sb = String.foldLeft(acc -> c -> 
                let es = match c {
                    case '&' => "&amp;"
                    case '<' => "&lt;"
                    case '"' => "&quot;"
                    case '>' => "&gt;"
                    case '\'' => "&#39;"
                    case _ => Char.toString(c)
                };
                StringBuilder.append(es, acc);
                acc
            , StringBuilder.empty(r), s);
            StringBuilder.toString(sb)
        }
        

    /// 
    /// Returns a string representing a HTML `span` element with styling
    /// that corresponds to the styling of the given `RichString`
    ///
    def spanToHTMLString(s: RichString.Span): String = 
        let RichString.Span.Span({text = t, fgColor = fc, bgColor = bg, styles = st}) = s;
        let defaultColor = fc == Color.Default;
        let defaultBgColor = bg == Color.Default;
        let tColor = if (defaultColor) {""} else {"color: ${fc};"};
        let bgColor = if (defaultBgColor) {""} else {"background-color: ${bg};"};
        let tEscaped = escapeHTML(t);
        if (Set.nonEmpty(st) or not defaultColor or not defaultBgColor) {
            let bold = if (Set.memberOf(Style.Bold, st)) {"font-weight: bold;"} else {""};
            let underline = if (Set.memberOf(Style.Underline, st)) {"text-decoration: underline;"} else {""};
            "<span style=\"${tColor}${bgColor}${bold}${underline}\">${tEscaped}</span>"
        } else {
            "<span>${tEscaped}</span>"
        }

instance ToString[Color] {
    pub def toString(x: Color): String = match x {
            case Rgb(r, g, b) => "rgb(${r},${g},${b})"
            case Default => "default"
        }
}
