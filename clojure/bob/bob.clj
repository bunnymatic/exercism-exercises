(ns bob)
(defn strip-punctuation
  "remove punctuation from the string"
  [s]
  (clojure.string/replace s #"\W" ""))

(defn is-shouting
  "return true if the message is shouting"
  [message]
  (and (= (clojure.string/upper-case message) message)
       (re-find #"\D" (strip-punctuation message))))

(defn is-silence
  "return true if the message is silence"
  [message]
  (= (clojure.string/trim message) ""))

(defn is-a-question
  "return true if the message is a question"
  [message]
  (.endsWith message "?"))

(defn response-for
  "return response based on input message"
  [message]
  (cond
    (bob/is-silence message) "Fine. Be that way!"
    (bob/is-shouting message) "Woah, chill out!"
    (bob/is-a-question message) "Sure."
    :else "Whatever."))