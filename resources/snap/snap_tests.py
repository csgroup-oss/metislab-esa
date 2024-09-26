from esa_snappy import ProductIO
p = ProductIO.readProduct('/usr/local/lib/python3.10/dist-packages/esa_snappy/testdata/MER_FRS_L1B_SUBSET.dim')
list(p.getBandNames())
