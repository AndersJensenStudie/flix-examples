use Math.Random

@Test
def testListHandler01(): Unit \ Assert = 
    let l = run {
        List#{Random.randomInt64(), Random.randomInt64(), Random.randomInt64()}
    } with RandomStubs.runWithFixedList(List.empty(), List#{2i64, 3i64});
    Assert.assertEq(expected = Some(List#{2i64, 3i64}), l)

@Test
def testListHandler02(): Unit \ Assert = 
    let tpl = run {
        (Random.randomInt64(), Random.randomFloat64(), Random.randomInt64())
    } with RandomStubs.runWithFixedList(List#{2.2}, List#{2i64, 3i64});
    Assert.assertEq(expected = Some((2i64, 2.2, 3i64)), tpl)