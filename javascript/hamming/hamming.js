Hamming = (function() {
  function Hamming() {
  };

  function computeHammingDistance(strandA, strandB) {
    var len = strandA.length
    var distance = 0;
    for( var i = 0; i < len; ++i ) {
      if (strandA[i] !== strandB[i]) {
        distance = distance + 1;
      }
    }
    return distance;
  }

  Hamming.prototype.compute = function compute(strandA, strandB) {
    if (strandA.length != strandB.length) {
      throw new Error('DNA strands must be of equal length.')
    }
    return computeHammingDistance(strandA, strandB)
  };
  return Hamming
})();

module.exports = Hamming;
