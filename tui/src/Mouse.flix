// Entire module is untested. Should work on systems not based on Wayland. 
eff Mouse {
    def getPos(): (Float64, Float64)
}

mod Mouse {
    import java.awt.MouseInfo

    pub def handle(f: a -> b \ ef): a -> b \ (ef - Mouse) + IO = 
        z -> {
            run {
                f(z)
            } with handler Mouse {
                def getPos(k) = 
                    let ptrInfo = MouseInfo.getPointerInfo();
                    let loc = ptrInfo.getLocation();
                    let x = loc.getX();
                    let y = loc.getY();
                    k((x, y))
            }
        }

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Mouse) + IO = handle(f)()
}