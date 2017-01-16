import multiprocessing

pool = multiprocessing.Pool(processes=4) # use 4 cores
pool.map(func, range(10)) # parallel processing func using 0:9 as input
pool.close()
pool.join()
print('done')