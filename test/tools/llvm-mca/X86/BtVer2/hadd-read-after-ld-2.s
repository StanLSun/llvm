# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=btver2 -iterations=1 -timeline -resource-pressure=false < %s | FileCheck %s

vshufps $0, %xmm0, %xmm1, %xmm1
vhaddps (%rdi), %ymm1, %ymm2

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]	Instructions:
# CHECK-NEXT:  1      1     0.50                    	vshufps	$0, %xmm0, %xmm1, %xmm1
# CHECK-NEXT:  2      8     2.00    *               	vhaddps	(%rdi), %ymm1, %ymm2


# CHECK:      Timeline view:
# CHECK-NEXT:      	          01
# CHECK-NEXT: Index	0123456789 
# CHECK:      [0,0]	DeER .    ..	vshufps	$0, %xmm0, %xmm1, %xmm1
# CHECK-NEXT: [0,1]	.DeeeeeeeeER	vhaddps	(%rdi), %ymm1, %ymm2
