; 
(ns words)
(use '[clojure.string :only (split trim lower-case blank?)])

(defn add-letter
  "add a letter to the histogram or increment it's count"
  [histogram letter]
  (update-in histogram [letter] (fnil inc 0)))

(defn letter-count
  "return a histogram of the letters the input string"
  [word]
  (reduce add-letter {} (seq (trim (lower-case word)))))

(ns anagram)
(use '[words :only (letter-count)])
; (use '[clojure.string :only (split trim lower-case blank?)])

(defn is-an-anagram
  "return true if word1 is an anagram of word2"
  [word1, word2]
  (and (not (= word1 word2))
       (= (letter-count word1) (letter-count word2))))

(defn anagrams-for
  "return find all valid anagrams given a word and a list to check from"
  [word, possibilities]
  (doall (filter (fn [w] (is-an-anagram word w)) possibilities)))