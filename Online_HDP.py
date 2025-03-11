# -*- coding = utf-8 -*-
# @Time : 2023/5/7 22:29
# @Author : Liu
# @File : Online_HDP.py
# @Software : PyCharm

import gensim
from gensim.models import HdpModel
from gensim.corpora import Dictionary
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from gensim import corpora
import nltk

# nltk.download('stopwords')

# # Load and preprocess the data
# reviews = ['This restaurant has great food and service',
#            'The prices are reasonable and the atmosphere is cozy',
#            'The portions are small but the quality is excellent',
#            'The waitstaff is friendly and attentive',
#            'The decor is outdated and needs improvement']
#
# stop_words = set(stopwords.words('english'))

f = open('D:\jupyter\paper4\cut_results.txt', mode='r', encoding='utf-8')
tokenized_reviews = [[word for word in line.split()] for line in f.readlines()]
stop_words = set(stopwords.words('chinese'))

# Tokenize the reviews and remove stop words
filtered_reviews = [[word for word in review if word not in stop_words] for review in tokenized_reviews]

# Create a dictionary and corpus for the reviews
dictionary = Dictionary(filtered_reviews)
corpus = [dictionary.doc2bow(review) for review in filtered_reviews]

# Train the HDP model
hdp = HdpModel(corpus, id2word=dictionary)

# Print the top 3 topics and their associated words
for i, topic in enumerate(hdp.show_topics(num_topics=20, formatted=False, num_words=20)):
    print(f"Topic {i}: {', '.join([word[0] for word in topic[1]])}")

