class BeerSong

  VERSE_TEMPLATE = "%<current>s bottles of beer on the wall, %<current>s bottles of beer.\n" \
                   "Take one down and pass it around, %<next>s bottles of beer on the wall.\n"
  def lyrics
    verses(99,0)
  end

  def verse(num)
    case num
    when 2
      "2 bottles of beer on the wall, 2 bottles of beer.\n" \
      "Take one down and pass it around, 1 bottle of beer on the wall.\n"
    when 1
      "1 bottle of beer on the wall, 1 bottle of beer.\n" \
      "Take it down and pass it around, no more bottles of beer on the wall.\n"
    when 0
      "No more bottles of beer on the wall, no more bottles of beer.\n" \
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    else
      VERSE_TEMPLATE % { current: num, next: num-1 }
    end
  end

  def verses(start, finish)
    (finish..start).reverse_each.map { |beer| verse(beer) }.join("\n")
  end

end

module BookKeeping
  VERSION = 2
end
