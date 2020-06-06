import cpp

from FunctionCall call
where call.getTarget().getName() = "memcpy"
select call, "a function call to memcpy."
