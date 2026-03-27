@Test
def testFixedStubReturnsSameNumber(): Unit \ Assert =
    let result = RandomPhoneStub.runWithFixed("12345678", () -> {
        RandomPhone.randomPhone()
    });
    Assert.assertEq(expected = "12345678", result)

@Test
def testFixedStubReturnsSameNumberTwice(): Unit \ Assert =
    let (a, b) = RandomPhoneStub.runWithFixed("99887766", () -> {
        let x = RandomPhone.randomPhone();
        let y = RandomPhone.randomPhone();
        (x, y)
    });
    Assert.assertEq(expected = "99887766", a);
    Assert.assertEq(expected = "99887766", b)

@Test
def testListStubCycles(): Unit \ Assert =
    let (a, b, c) = RandomPhoneStub.runWithList(
        List#{"first", "second", "third"},
        () -> {
            let x = RandomPhone.randomPhone();
            let y = RandomPhone.randomPhone();
            let z = RandomPhone.randomPhone();
            (x, y, z)
        }
    );
    Assert.assertEq(expected = "first", a);
    Assert.assertEq(expected = "second", b);
    Assert.assertEq(expected = "third", c)

@Test
def testListStubWrapsAround(): Unit \ Assert =
    let (a, b, c) = RandomPhoneStub.runWithList(
        List#{"one", "two"},
        () -> {
            let x = RandomPhone.randomPhone();
            let y = RandomPhone.randomPhone();
            let z = RandomPhone.randomPhone();
            (x, y, z)
        }
    );
    Assert.assertEq(expected = "one", a);
    Assert.assertEq(expected = "two", b);
    Assert.assertEq(expected = "one", c)

@Test
def testUsHandlerProduces14Chars(): Unit \ Assert + Math.Random =
    let phone = run {
        RandomPhone.randomPhone()
    } with RandomPhone.runWithUs;
    // Formatted: (XXX) XXX-XXXX = 14 chars
    Assert.assertEq(expected = 14, String.length(phone))

@Test
def testDkHandlerProduces11Chars(): Unit \ Assert + Math.Random =
    let phone = run {
        RandomPhone.randomPhone()
    } with RandomPhone.runWithDk;
    // Formatted: XX XX XX XX = 11 chars (8 digits + 3 spaces)
    Assert.assertEq(expected = 11, String.length(phone))
