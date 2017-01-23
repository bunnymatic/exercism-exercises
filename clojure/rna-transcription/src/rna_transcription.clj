(ns rna-transcription
  (:require [clojure.string :refer (join)]))

(def dna->rna
  '{
    \G "C"
    \C "G"
    \T "A"
    \A "U"
    })

(defn validate
  "validate that the nucleotide exists"
  [rna_nucleotide]
  (assert rna_nucleotide)
  rna_nucleotide)

(defn transcribe-and-validate
      "Transcribe a single nucleotide from DNA to RNA and throw an error if it's an invalid DNA character"
      [dna_nucleotide]
      (validate (dna->rna dna_nucleotide)))

(defn to-rna
      "Transcribe DNA nucleotides to RNA nucleotides"
      [dna_sequence]
      (join "" (map transcribe-and-validate dna_sequence)))
