#! /usr/bin/env python3
"""Outputs what day of the year it is and its hexadecimal form"""
from time import localtime

yday = localtime().tm_yday
year = localtime().tm_year

def ordinal(n):
	"""Takes a number (int) and returns both the number and its ordinal suffix"""
	return str(n) + ("th" if 4 <= n % 100 <= 20 else {1: "st", 2: "nd", 3: "rd"}.get(n % 10, "th"))

print("\rToday's the %s day of the year %s, or %s in hex" % (ordinal(yday), year, hex(yday)))

if yday == 256:
	print("Happy Day of the Programmer!")
