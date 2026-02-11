import java.util.{Random => JRandom}

def main(): Unit \ {IO, NonDet + Chan + Logger + OtherSimpleEffect} = 
    main1()

def myPrint(s: String): Unit \ {IO, Console} = 
    let s_prime = checked_ecast(s);
    println(s_prime)

eff SimpleEff {
    def do(): Int32
}

eff OtherSimpleEffect {
    def dont(): Bool
}

mod OtherSimpleEffect {
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - OtherSimpleEffect) + IO =
        run {
            f()
        } with handler OtherSimpleEffect {
            def dont(k) = k(false)
        }
}

def main1(): Unit \ {IO + NonDet + Chan + Logger + OtherSimpleEffect} = 
    let _ = run {
        () // SimpleEff.do()
    } with handler SimpleEff {
        def do(k) = k(10)
    };
    ()

pub def handle(f: a -> b \ ef): a -> b \ (ef - Random) + {IO} =
    let k = x -> {
        let rnd = new JRandom(); // Reuse Random instance.
        run {
            f(x)
        } with handler Random {
            def randomBool(k)       = k(rnd.nextBoolean())
            def randomFloat32(k)    = k(rnd.nextFloat())
            def randomFloat64(k)    = k(rnd.nextDouble())
            def randomInt32(k)      = k(rnd.nextInt())
            def randomInt64(k)      = k(rnd.nextLong())
            def randomGaussian(k)   = k(rnd.nextGaussian())
        }
    };
    k