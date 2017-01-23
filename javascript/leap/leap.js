Year = (function() {


  function Year(year) {
    this.year = year;
  }

  function isDivisibleBy(val, divisor) {
    return (val % divisor) == 0;
  }

  Year.prototype.isLeap = function() {
    if (isDivisibleBy(this.year, 400)) {
      return true;
    }
    if (isDivisibleBy(this.year, 100)) {
      return false;
    }
    if (isDivisibleBy(this.year, 4)) {
      return true;
    }
    return false;
  };

  return Year;

})();


module.exports = Year;
