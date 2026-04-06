eff RouteResolver {
    def getRoute(s: String): String
} 

mod RouteResolver {
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RouteResolver) + IO =
        run {
            f()
        } with handler RouteResolver {
            def getRoute(s, k) = 
                k(s)
        }

    pub def runWithMap(routes: Map[String, String], f: Unit -> a \ ef): a \ (ef - RouteResolver) = 
        run {
            f()
        } with handler RouteResolver {
            def getRoute(s, k) = 
                let route = Option.getWithDefault(s, Map.get(s, routes));
                k(route)
        }

    pub def runWithStandard(f: Unit -> a \ ef): a \ (ef - RouteResolver) =
        run {
            f()
        } with runWithMap(Map#{"/" => "/index.html"})
}