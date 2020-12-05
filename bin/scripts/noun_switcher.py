#!/usr/bin/env python3
import sys
import re
import nltk
 
is_noun = lambda pos: pos[:2] == 'NN'

for line in sys.stdin:
    button_line = line
    result = re.compile(r'“(.*)”').match(button_line)
    if result:
        quote = result.group(1)
        tokenized = nltk.word_tokenize(quote)
        nouns = [word for (word, pos) in nltk.pos_tag(tokenized) if is_noun(pos)] 
        # nouns = set(nouns) # unique
        if(len(nouns) > 0):
            # print(nouns)
            for noun in nouns[1::2]:
                button_line = button_line.replace(noun, "button", 1)
            # print(quote)
            # print(line)
            print("  - text: ")
            print(button_line)
