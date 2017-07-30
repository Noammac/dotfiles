#! /usr/bin/env python3
"""Outputs what day of the year it is and its hexadecimal form"""
from time import localtime

yday = localtime().tm_yday
year = localtime().tm_year

def ordinal(n):
	"""Takes a number (int) and returns both the number and its ordinal suffix"""
	return str(n) + ("th" if 4 <= n % 100 <= 20 else {1: "st", 2: "nd", 3: "rd"}.get(n % 10, "th"))

print(f"\rToday's the {ordinal(yday)} day of the year {year}, or {hex(yday)} in hex")

if yday == 256:
	print("Happy Day of the Programmer!")
if localtime().tm_mon == 11 and localtime.tm_mday == 20:
	print("Happy birthday!")
