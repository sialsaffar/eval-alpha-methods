#!/usr/bin/env python3

""" From Stoletzki and Eyre-Walker, 2010.
"""

import sys
import numpy as np
import pandas as pd


in_file = sys.argv[1]


def NI_simple(Pn, Ps, Dn, Ds):
    NI = (Pn*Ds) / (Ps*Dn)
    return NI


def NI_TG(Pn, Ps, Dn, Ds):
    """ Equation 3
    """
    nom = Ds*Pn / (Ps+Ds)
    denom = Ps*Dn / (Ps+Ds)
    return nom, denom


def NI_Jewell(Pn, Ps, Dn, Ds):
    """ Equation 4
    """
    NI = Ds*Pn / ((Dn + 1)*(Ps + 1))
    return NI

    
def NI_Haldane(Pn, Ps, Dn, Ds):
    """ Equation 5
    """
    nom = (2*Ds + 1) * (2*Pn + 1)
    denom = (2*Dn + 1) * (2*Ps + 1)
    NI = np.log10(nom/denom)
    return NI


def NI_Laplace(Pn, Ps, Dn, Ds):
    """ Equation 6
    """
    nom = (Ds + 1) * (Pn + 1)
    denom = (Dn + 1) * (Ps + 1)
    NI = np.log10(nom/denom)
    return NI


def DoS(Pn, Ps, Dn, Ds):
    """ Equation 7
    """
    dos = (Dn / (Dn + Ds)) - (Pn / (Pn + Ps))
    return dos


df = pd.read_csv(in_file)

Pn_sum = df['Pn'].sum()
Ps_sum = df['Ps'].sum()
Dn_sum = df['Dn'].sum()
Ds_sum = df['Ds'].sum()

print(Pn_sum, Ps_sum, Dn_sum, Ds_sum)

simple_val = NI_simple(Pn_sum, Ps_sum, Dn_sum, Ds_sum)
Jewell_val = NI_Jewell(Pn_sum, Ps_sum, Dn_sum, Ds_sum)
Haldane_val = np.exp(NI_Haldane(Pn_sum, Ps_sum, Dn_sum, Ds_sum))
Laplace_val = np.exp(NI_Laplace(Pn_sum, Ps_sum, Dn_sum, Ds_sum))
DoS_val = DoS(Pn_sum, Ps_sum, Dn_sum, Ds_sum)


TG_nom_ls, TG_denom_ls = [], []

for i, row in df.iterrows():
    nom, denom = NI_TG(row[1], row[2], row[5], row[6])
    TG_nom_ls.append(nom), TG_denom_ls.append(denom)

TG_val = np.nansum(TG_nom_ls) / np.nansum(TG_denom_ls)
#print(np.nansum(TG_denom_ls))

print(f'NI_simple = {simple_val}')
print(f'NI_TG = {TG_val}')
print(f'NI_Jewell = {Jewell_val}')
print(f'NI_Haldane = {Haldane_val}')
print(f'NI_Laplace = {Laplace_val}')
print(f'DoS = {DoS_val}')








