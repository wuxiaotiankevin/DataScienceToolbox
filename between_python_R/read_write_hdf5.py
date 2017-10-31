import h5py
import numpy as np

# initialize file
f = h5py.File(output_folder + "mytestfile.hdf5", "w") # 'w' is write mode
# store data in the file
f.create_dataset("data_name", data=data_np_array)
f.close()

# read file
f = h5py.File(output_folder + "mytestfile.hdf5", 'r')   # 'r' means that hdf5 file is open in read-only mode
dat = f["data_name"][:] # reads data as np ndarray
f.close()