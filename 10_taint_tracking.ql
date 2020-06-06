/**
 * @kind path-problem
 */

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

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

class Config extends TaintTracking::Configuration {
    Config() { this = "NetworkToMemFuncLength" }
    
    override predicate isSource(DataFlow::Node source) {
        source.asExpr() instanceof NetworkByteSwap
    }

    override predicate isSink(DataFlow::Node sink) {
        exists(FunctionCall call | 
            call.getTarget().getName() = "memcpy" and
            call.getArgument(2) = sink.asExpr()
        )
    }
}

from Config config, DataFlow::PathNode source, DataFlow::PathNode sink
where config.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"
