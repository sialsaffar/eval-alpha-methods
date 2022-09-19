#!/use/bin/env python

import numpy as np
import pandas as pd
from scipy.stats import spearmanr
import sys

in_file = pd.read_csv(sys.argv[1])

rho, p = spearmanr(in_file['2Nes_by_p'], in_file['TrueAlpha'])

print('rho = %.6f' % rho)
print('p = %.6f' % p)
