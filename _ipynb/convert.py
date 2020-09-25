import os
import sys

os_ver = sys.platform
notebooks = os.listdir('notebooks')

for n in notebooks:
    os.system(f'jupyter-nbconvert.exe notebooks\{n} --to markdown')




