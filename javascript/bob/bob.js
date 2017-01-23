var Message = function(message) {
  this.message = message.replace(/[\r\n]/, ' ');
};
  
Message.prototype.is_silence = function() {
  var msg = this.message;
  return (!msg || /^\s*$/.test(msg));
};

Message.prototype.is_a_question = function() {
  return /\?$/.test(this.message)
};

Message.prototype.is_shouting = function() {
  var msg = this.message;
  var upperMsg = msg.toUpperCase();
  var cleanMsg = msg.replace(/[\s.\,\*!@#\$%\^&\(\)\[\]\|\\\/]+/g, '');
  return (msg === upperMsg) && (!/^\d+\??$/.test(cleanMsg));
};

var Bob = function() {
};

Bob.prototype.hey = function(msg) {
  
  var m = new Message(msg);
  if(m.is_silence()) { return "Fine. Be that way!" }
  else if(m.is_shouting()) { return "Woah, chill out!" }
  else if(m.is_a_question()) { return "Sure." }
  else { return "Whatever." }

};

module.exports = Bob;