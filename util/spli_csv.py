#!/usr/bin/env python

import os
import pandas as pd
import argparse

# code to fix path location and split audio based on size (Final - Productoion)

def _preprocess_data(location , replace , wav_location = ''): 
    
    directory = os.path.join(location,"csv")
    target_directory = os.path.join(location)
    print("csv File location : -" , directory)
    print("parser csv File location : - " , target_directory)
    print("replace value :- " , replace)
    print("wav location :- " , wav_location)
    
    amount_thr={
        '100p': 9999999,
        '70p':   799000,
        '50p':   560000,
        '30p':   260000,
        '5sec':  160000
    }

    for root,dirs,files in os.walk(directory):
        for file in files:
            if file.endswith(".csv"):
                filename = os.path.join(directory,file)
                print(filename)
                df = pd.read_csv(filename)
                print("finishRead" , filename)
                item = df.wav_filename.str.replace(replace , wav_location)
                df.wav_filename = item
                for k, v in amount_thr.items():
                    target_filename = os.path.join(target_directory,file.replace('.csv', f"_{k}.csv"))
                    print("csv parser to : " , target_filename)
                    split_df = df.loc[df['wav_filesize'] <= v ]
                    split_df.to_csv(target_filename, index = False, encoding="utf-8")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--location", help="Directory to import to, usually 'quran_data/quran_tusers/'" , default='quran_data/quran_tusers/')
    parser.add_argument('--replace_value', default='data/quran_tusers/', help="fix path location  data/quran_tusers or data/quran/ . (default: %(default)s)")
    parser.add_argument('--wav_location', default='', help="fix path location   (default: %(default)s)")
    args = parser.parse_args()
    _preprocess_data(args.location , args.replace_value , args.wav_location)
    print("Completed")
