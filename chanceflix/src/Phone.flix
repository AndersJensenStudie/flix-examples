/// Effect for generating a random phone number.
eff RandomPhone {
    def randomPhone(): String
}

mod RandomPhone {
    /// Handler that generates US phone numbers.
    pub def runWithUs(f: Unit -> a \ ef): a \ (ef - RandomPhone) + Math.Random =
        run {
            f()
        } with handler RandomPhone {
            def randomPhone(k) = k(Phone.phoneUs())
        }

    /// Handler that generates Danish phone numbers.
    pub def runWithDk(f: Unit -> a \ ef): a \ (ef - RandomPhone) + Math.Random =
        run {
            f()
        } with handler RandomPhone {
            def randomPhone(k) = k(Phone.phoneDk())
        }
}

mod Phone {

    /// Generates a random Int64 in [min, max] (inclusive).
    def natural(min: Int64, max: Int64): Int64 \ Math.Random =
        let range = Int64.toFloat64(max - min + 1i64);
        let r = Math.Random.randomFloat64();
        min + Float64.tryToInt64(r * range) |> Option.getWithDefault(min)

    /// US area code: first digit 2-9, second digit 0-8, third digit 0-9.
    pub def areacode(): String \ Math.Random =
        let d1 = Int64.toString(natural(2i64, 9i64));
        let d2 = Int64.toString(natural(0i64, 8i64));
        let d3 = Int64.toString(natural(0i64, 9i64));
        d1 + d2 + d3

    /// US exchange: first digit 2-9, then two digits 0-9.
    def exchange(): String \ Math.Random =
        let d1 = Int64.toString(natural(2i64, 9i64));
        let d2 = Int64.toString(natural(0i64, 9i64));
        let d3 = Int64.toString(natural(0i64, 9i64));
        d1 + d2 + d3

    /// US subscriber: 4-digit number from 1000-9999.
    def subscriber(): String \ Math.Random =
        Int64.toString(natural(1000i64, 9999i64))

    /// Generates a US phone number: (XXX) XXX-XXXX
    pub def phoneUs(): String \ Math.Random =
        "(" + areacode() + ") " + exchange() + "-" + subscriber()

    /// Generates an unformatted US phone number: XXXXXXXXXX
    pub def phoneUsRaw(): String \ Math.Random =
        areacode() + exchange() + subscriber()

    /// Generates a random string of digits of the given length.
    def digitString(len: Int32): String \ Math.Random =
        digitStringHelper(len, "")

    def digitStringHelper(n: Int32, acc: String): String \ Math.Random =
        if (n <= 0) acc
        else {
            let d = natural(0i64, 9i64);
            digitStringHelper(n - 1, acc + Int64.toString(d))
        }

    /// Generates a valid Danish 2-digit prefix (20-99, excluding 80 and 90).
    def dkPrefix(): String \ Math.Random =
        let d1 = natural(2i64, 9i64);
        let d2 = natural(0i64, 9i64);
        // Avoid 80 (freephone) and 90 (premium rate): reroll second digit to 1-9
        let d2safe = if ((d1 == 8i64 or d1 == 9i64) and d2 == 0i64)
                         natural(1i64, 9i64)
                     else d2;
        Int64.toString(d1) + Int64.toString(d2safe)

    /// Generates a Danish phone number: XX XX XX XX
    /// Danish numbers are 8 digits, non-geographical, starting with 2-9.
    /// Avoids 80 (freephone) and 90 (premium rate) prefixes.
    pub def phoneDk(): String \ Math.Random =
        let raw = dkPrefix() + digitString(6);
        String.slice(start = 0, end = 2, raw) + " " +
        String.slice(start = 2, end = 4, raw) + " " +
        String.slice(start = 4, end = 6, raw) + " " +
        String.slice(start = 6, end = 8, raw)

    /// Generates an unformatted Danish phone number: XXXXXXXX
    pub def phoneDkRaw(): String \ Math.Random =
        dkPrefix() + digitString(6)
}
