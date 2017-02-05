Isogram = (function() {

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

  function Isogram(word) {
    var cleanWord = word.toLowerCase().replace(/[\s\d!#@|$%|^|&|*|(|)-_\[\{\]\}]+/g, '');
    this.letters = cleanWord.split("")
  };


  Isogram.prototype.isIsogram = function() {
    var hist = histogram(this.letters);
    for(var k in hist) {
      v = hist[k]
      if (v != 1) {
        return false;
      }
    }
    return true;
  };

  return Isogram;
})();

module.exports = Isogram;
