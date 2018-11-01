defmodule MemesTest do
  use ExUnit.Case
  doctest Memes

  setup _memeResult do
    Memes.getRandomMeme()
  end

  test "gets random meme", memeResult do
    assert memeResult.status == :success
  end
end
