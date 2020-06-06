import cpp

from Macro macro
where 
    macro.getName() = "ntohs" or 
    macro.getName() = "ntohl" or 
    macro.getName() = "ntohll"
select macro, "a network macro."