(ns phrase)
(use '[clojure.string :only (split trim lower-case blank?)])

(defn remove-non-word-chars
  "replace non word characters and collapse whitespace to 1 space"
  [s]
  (clojure.string/replace (clojure.string/replace s #"\W" " ") #"\s+" " "))

(defn clean-string
  "clean up a string of words to be lowercased with no punctuation and collapsed whitespace"
  [s]
  (lower-case (remove-non-word-chars s)))

(defn add-word
  "add a word to the histogram or increment it's count"
  [histogram word]
  (update-in histogram [word] (fnil inc 0)))

(defn words
  "split string into words"
  [invalue]
  (split invalue #"\s+"))

(defn word-count
  "return a histogram of the words in the input list"
  [all_words]
  (reduce add-word {} (words (clean-string all_words))))