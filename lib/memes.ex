defmodule Memes do
  @moduledoc """
  Memes is a module for fetching random memes using the 9gag/random page.
  """

  @doc """
  Gets a random meme

  returns meme
  """
  def getRandomMeme do
    response = HTTPotion.get "https://9gag.com/random", follow_redirects: true

    if HTTPotion.Response.success?(response) do
      %{status: :success, 
      data: %{
        id: parse_id(response.body),
        title: parse_title(response.body),
        pageUrl: parse_pageUrl(response.body),
        imgUrl: parse_imgUrl(response.body)
      }}  
    else
      %{status: :failed, data: response}
    end

  end

  defp parse_id(html) do
    pageUrl = parse_pageUrl(html)
    String.replace(pageUrl, "http://9gag.com/gag/", "")
  end

  defp parse_title(html) do
    html 
    |> Floki.find("meta") 
    |> Floki.find("[property='og:title']") 
    |> hd 
    |> Floki.attribute("content") 
    |> hd
  end

  defp parse_pageUrl(html) do
    html
    |> Floki.find("meta")
    |> Floki.find("[property='og:url']")
    |> hd
    |> Floki.attribute("content")
    |> hd
  end

  defp parse_imgUrl(html) do
    html
    |> Floki.find("meta")
    |> Floki.find("[property='og:image']")
    |> hd
    |> Floki.attribute("content")
    |> hd
  end
  
end
