
# Script to obtain stats (types, tokens, type/tokens)
# inspiration: https://www.geeksforgeeks.org/python-os-chdir-method/

from obtain_corpus_statistics import *

import pandas as pd
import os

os.chdir('/Users/Rodrigo/Desktop/Thesis_review/Castro2021/obtain_corpus_statistics/')
os.mkdir('stats')

# change the current working directory 
# to specified path
os.chdir('/Users/Rodrigo/Desktop/Thesis_review/Castro2021/obtain_corpus_statistics/texts')
  
# varify the path using getcwd()
cwd = os.getcwd()


  
# print the current directory
print("Current working directory is:", cwd)

all_files = os.listdir()

stats_list =[]
count=0
for file in all_files:
    count+=1
    print(f'Loop {count} beginning')
    stats = obtain_texts_statistics(file)
    stats_list.append(stats)

    os.chdir('/Users/Rodrigo/Desktop/Thesis_review/Castro2021/obtain_corpus_statistics/')
    
    print('Saving file')    
    stats.to_csv(f'stats/{file}_stats.csv',index=False)
    print('File saved')

    os.chdir('/Users/Rodrigo/Desktop/Thesis_review/Castro2021/obtain_corpus_statistics/texts')


    print(f'Loop {count} OK')


print(len(stats_list))




# stats1 = obtain_texts_statistics(all_files[0])
# print(stats1)
