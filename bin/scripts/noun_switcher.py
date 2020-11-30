#!/usr/bin/env python3
import sys
import nltk
 
is_noun = lambda pos: pos[:2] == 'NN'

for line in sys.stdin:
    tokenized = nltk.word_tokenize(line)
    nouns = [word for (word, pos) in nltk.pos_tag(tokenized) if is_noun(pos)] 
    if(len(nouns) > 0):
        for noun in nouns:
            line = line.replace(noun, "button")
        print(line)
