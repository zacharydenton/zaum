import os
import sys
import json

def main():
    data = {}
    for wordlist in sys.argv[1:]:
        lang = os.path.basename(wordlist).split('_')[0]
        data[lang] = []
        with open(wordlist) as f:
            for line in f:
                word, count = line.strip().split()
                data[lang].append((word, count))

    print json.dumps(data)

if __name__ == "__main__": main()

