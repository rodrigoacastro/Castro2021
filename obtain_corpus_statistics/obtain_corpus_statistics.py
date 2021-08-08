# function to obtain types, tokens for each text
import pandas as pd

def obtain_texts_statistics (textfile):
	# encoding: utf-8

    # Contagem de types e tokens python

    # import obo

    # LE ARQUIVO DE TEXTO EM TXT

    #Abrindo o arquivo para leitura

    with open(textfile, 'r', encoding='utf8') as file:
        text = file.read()

    #Mostra conteudo do texto
    # separador = espacos
    #print(text, "\n\n\n\n")


    # SEGMENTA PALAVRAS em lista
    string_list = text.split()

    #print(string_list)


    # Gera lista de frequencia
    wordfreq = []
    for w in string_list:
        wordfreq.append(string_list.count(w))

    # transforma lista em dicionario
    dic_freq = dict(zip(string_list,wordfreq))

    # dic_freq = obo.sortFreqDict(dic_freq)

    #print(dic_freq)


    #print('\n\n')

    #tokens
    tokens = len(string_list)
    #print "O numero de tokens do texto = ",tokens

    #types
    types = len(dic_freq)
    #print "O numero de types do texto = ",types

    #types/tokens

    dens = float(len(dic_freq))/len(string_list)
    #print "A densidade lexical do texto = ",dens
    
    stats = [types, tokens, dens]
    names = ['types','tokens','lexical density']
    result = pd.DataFrame(stats, names, columns=['values']).reset_index()
    result.columns = ['measure','value']
    #result
    
    return (result)