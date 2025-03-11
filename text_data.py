# -*- coding = utf-8 -*-
# @Time : 2023/5/6 23:54
# @Author : Liu
# @File : text_data.py
# @Software : PyCharm
import numpy as np
from gensim import corpora
import jieba
import os
from collections import Counter

# Set the directory containing the corpus of Chinese news articles

# Tokenize the text using Jieba and count the words
vocab = set()
word_counts = []

f = open('results.txt', mode='r')
for line in f.readlines():
    words = line.split()
    word_count = Counter(words)
    word_counts.append(word_count)
    vocab.update(words)
vocab = sorted(vocab)

# Convert the word counts to bag-of-words vectors
data = np.zeros((len(word_counts), len(vocab)), dtype=int)
for i, word_count in enumerate(word_counts):
    for j, word in enumerate(vocab):
        data[i, j] = word_count[word]