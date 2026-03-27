@Test
def test01(): Unit \ Assert =
    let rs = RichString.bold("Hello") + RichString.bgCyan("World");
    let res = toHTMLParagraph(rs);
    Assert.assertEq(expected = "<p><span style=\"font-weight: bold;\">Hello</span><span style=\"background-color: rgb(17,168,205);\">World</span></p>", res)

@Test 
def test02(): Unit \ Assert = 
    let rs = RichString.text("& ' < > ");
    let res = toHTMLParagraph(rs);
    Assert.assertEq(expected = "<p><span>&amp; &#39; &lt; &gt; </span></p>", res)

@Test
def test03(): Unit \ Assert = 
    let rs = RichString.text("Hello, world");
    let res = toHTMLParagraph(rs);
    Assert.assertEq(expected = "<p><span>Hello, world</span></p>", res)