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

  var Isogram = function(word) {
    this.word = word;
  }

  Isogram.prototype.isIsogram() {
    var hist = histogram(word);
    hist.forEach( function(k,v) {
      if (v != 1) {
        return false;
      }
    });
    return true;
  };

  return Isogram;
})();

module.exports = Isogram;
