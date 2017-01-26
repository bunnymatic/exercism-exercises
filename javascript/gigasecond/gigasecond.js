Gigasecond = (function() {

  GIGASECOND = 10 ** 9;

  function dateFromSeconds(seconds) {
    return new Date(seconds * 1000);
  }

  function dateToSeconds(date) {
    return date.getTime() / 1000;
  }

  function Gigasecond(date) {
    this._date = dateFromSeconds(dateToSeconds(date) + GIGASECOND);
  };

  Gigasecond.prototype.date = function() {
    return this._date;
  };

  return Gigasecond;

})();

module.exports = Gigasecond;
