from esa_snappy import ProductIO
p = ProductIO.readProduct('/srv/conda/envs/notebook/lib/python3.12/site-packages/esa_snappy/testdata/MER_FRS_L1B_SUBSET.dim')
list(p.getBandNames())
