#!/bin/bash

# source code inspired in: https://kenbenoit.net/how-to-batch-convert-pdf-files-to-text/

# set working directory to folder in Desktop
cd Desktop/convert_pdfs_txts_shell

# finds files
FILES=pdf_files/*.pdf

# convert pdfs in the folder to txt UTF-8 encoding
for f in $FILES
do
 echo "Processing $f file..."
 xpdf-tools-win-4.01.01/bin64/pdftotext -enc UTF-8 $f
done

# creates directory to store the results (text files)
mkdir txt_files
# moves files from the pdfs folder to the new directory (text_file folder)
mv ./pdf_files/*.txt ./txt_files