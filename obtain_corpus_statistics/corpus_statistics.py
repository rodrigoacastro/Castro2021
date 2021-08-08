# obtain texts and get types, tokens and type/token measures

# list files


import glob

texts_path = 'C:\Users\Rodrigo\Desktop\Castro2021\texts\'

for f in glob.glob(texts_path):
    print(f)