import numpy as np
import cupy as cp

squared_diff = cp.ElementwiseKernel(
   'float32 x, float32 y',
   'float32 z',
   'z = (x - y) * (x - y)',
   'squared_diff')

start_gpu = cp.cuda.Event()
end_gpu = cp.cuda.Event()
start_gpu.record()

x = cp.arange(10, dtype=np.float32).reshape(2, 5)
y = cp.arange(5, dtype=np.float32)
print(squared_diff(x, y))
print(squared_diff(x, 5))

end_gpu.record()
end_gpu.synchronize()
t_gpu = cp.cuda.get_elapsed_time(start_gpu, end_gpu)

print(f"GPU Time: {t_gpu}")
