InterviewFormGenerator
======================

A simple script to generate interview forms based on role profiles connected to a number of KSAs/characteristics.

You need the setup files roles.csv and questions.csv in addition to the script.

questions.csv has columns=KSA's or characteristics, rows=question texts

roles.csv has columns=rolenames and rows correspond to the KSA's in questions.csv, and marking with a 1 if it
is a core KSA for the profile of a role, 0 if it is not core.
