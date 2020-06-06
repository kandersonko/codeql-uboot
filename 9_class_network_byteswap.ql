
import cpp

predicate isNtoh(string s) {
    s = "ntohs" or
    s = "ntohl" or
    s = "ntohll"
}

class NetworkByteSwap extends Expr {
    NetworkByteSwap() {
        exists(MacroInvocation call | 
            isNtoh(call.getMacroName()) and 
            call.getExpr() = this
        )
    }
}

from NetworkByteSwap n
select n, "Network byte swap"