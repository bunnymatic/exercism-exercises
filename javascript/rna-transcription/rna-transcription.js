DnaTranscriber = (function() {
  function DnaTranscriber() {
  }

  var LUT = {
    C: "G",
    G: "C",
    A: "U",
    T: "A"
  }

  DnaTranscriber.prototype.toRna = function toRna(aminoAcids) {
    return aminoAcids.split("").map( function( aminoAcid ) {
      return LUT[aminoAcid];
    }).join("")
  }

  return DnaTranscriber;
})();
module.exports = DnaTranscriber;
