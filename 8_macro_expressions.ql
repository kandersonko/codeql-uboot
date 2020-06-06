import cpp

predicate isNtoh(string s) {
    s = "ntohs" or
    s = "ntohl" or
    s = "ntohll"
}

from MacroInvocation call
where isNtoh(call.getMacroName())
select call.getExpr(), "a macro expansion"