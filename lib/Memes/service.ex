defmodule Memes.Service do
  @moduledoc """
  Memes is a module for fetching random memes using the 9gag/random page.
  """

  @doc """
  Fetches memes recursively by the count

  returns list of memes
  """
  def fetchRandomMemes(count, list \\ []) do
    if length(list) <= count do
      IO.puts("#{inspect(length(list))}")
      result = fetchRandomMeme()

      list =
        if result.status == :success do
          list ++ [result.data]
        end

      fetchRandomMemes(count, list)
    else
      list
    end
  end

  @doc """
  Fetches a random meme

  returns meme
  """
  def fetchRandomMeme do
    response = HTTPotion.get("https://9gag.com/random", follow_redirects: true)

    if HTTPotion.Response.success?(response) do
      %{
        status: :success,
        data: %{
          id: parse_id(response.body),
          title: parse_title(response.body),
          pageUrl: parse_pageUrl(response.body),
          imgUrl: parse_imgUrl(response.body)
        }
      }
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
