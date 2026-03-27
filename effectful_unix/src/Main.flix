eff Status {
    def exit(i: Int32): Void
}

def main_status(): Unit \ IO = 
    let s = status(() -> divide(1, 0));
    let s_ = status(() -> divide(1, 2));
    println(s);
    println(s_)

def divide(x: Int32, y: Int32): Int32 \ Status = 
    if (y == 0) {
        Status.exit(1)
    } else {
        x / y
    }
    
def status(m: Unit -> a \ Status ): (Int32, Option[a]) = 
    run {
        (0, Some(m()))
    } with handler Status {
        def exit(i, _k) = (i, None)
    }

eff Env_ {
    def ask(): String
}

eff SubUser {
    def su(u: User): Unit
}

enum User {
    case Alice
    case Bob
    case Root
}

def main_session(): Unit \ IO = 
    let r = sessionmgr(User.Alice, whoami);
    println(r)

def whoami(): String \ {Env_} = 
    Env_.ask()

def env(user: User, m: Unit -> a \ ef): a \ ef - Env_ = 
    run {
        m()
    } with handler Env_ {
        def ask(k) = match user {
            case User.Alice =>  k("Alice")
            case User.Bob =>    k("Bob")
            case User.Root =>   k("Root")
        }
    }

def sessionmgr(user: User, m: Unit -> a \ ef): a \ ef & ~(SubUser + Env_) = 
    let lhs = () -> run {
        m()
    } with handler SubUser {
        def su(u, k) = env(u, k)
    };
    let r = env(user, lhs);
    r