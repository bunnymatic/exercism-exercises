Words = (function() {

  INTL_PUNCT_REGEX = /[\~\?\.\^\[\/\"_\(\)&*\$￥\^\+=`~<>\{\}\[\]\|\-!#%\,\:;@¡§«¶·»¿;·]+/g

  function Words() {
  }

  function histogram(items) {
    var result = {};
    var PROPS_DESCRIPTOR = { value: 0, writable: true, enumerable: true};
    items.forEach(function(item) {
      if (!result.hasOwnProperty(item)) {
        Object.defineProperty(result, item, PROPS_DESCRIPTOR);
      }
      result[item] = result[item] + 1;
    });
    return result;
  }

  function extractWords(phrase) {
    var words = []
    cleanPhrase(phrase).split(/\s+/).forEach(function(word) {
      var cleaned = cleanWord(word);
      if (cleaned) {
        words.push(cleaned);
      }
    });
    return words;
  }

  function cleanPhrase(phrase) {
    return phrase.replace(INTL_PUNCT_REGEX, ' ').toLowerCase()
  }

  function cleanWord(word) {
    return word.replace(/^["'](.*)["']$/, "$1").trim()
  }

  Words.prototype.count = function( phrase ) {
    words = extractWords(phrase);
    return histogram(words);
  };
  return Words;

})();

module.exports = Words;
