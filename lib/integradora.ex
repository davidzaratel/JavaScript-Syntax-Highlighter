defmodule Integradora do
  def leerJs do  #vuelve lista de listas todos los elementos del Js
  File.read!("test.js")
  |> String.to_charlist
  end

  def compare(:num,value), do: "<span class=\"num\">" <> (value |> to_string) <> "</span>"
  def compare(:float,value), do: "<span class=\"num\">" <> (value |> to_string) <> "</span>"
  def compare(:identifier,value), do: "<span class=\"identifier\">" <> (value |> to_string) <> "</span>"
  def compare(:reserved,value), do: "<span class=\"reserved\">" <> (value |> to_string) <> "</span>"
  def compare(:enter,_), do: "<br>"
  def compare(:commentline,value), do: "<span class=\"comment\">" <> (value |> to_string) <> "</span>"
  def compare(:commentblock,value), do: "<span class=\"comment\">" <> (value |> to_string) <> "</span>"
  def compare(:signs,value), do: "<span class=\"signs\">" <> (value |> to_string) <> "</span>"
  def compare(:logical,value), do: "<span class=\"signs\">" <> (value |> to_string) <> "</span>"
  def compare(:space,value), do: "<span>" <> (value |> to_string) <> "</span>"
  def compare(:string,value), do: "<span class=\"string\">" <> (value |> to_string) <> "</span>"
  def compare(:charlist,value), do: "<span class=\"string\">" <> (value |> to_string) <> "</span>"
  def compare(:bool,value), do: "<span class=\"bool\">" <> (value |> to_string) <> "</span>"

  def html(codigo) do
    "<!DOCTYPE html>
    <html>
    <head>
      <title> Javascript Script Highlighterr</title>
      <link rel='stylesheet' href='styles.css'>
    </head>
    <body>
    <h1>Javascript script highlighter</h1>
    <h3> By: David Zarate Lopez A01329795</h3>
    <br>
    <pre><code>#{codigo}</code></pre>
    </body>
    </html>"
  end

  #hacer una funcion a llamar dentro del enum.map, la cual compare cual palabra es
  def convertir do
    {:ok, file} = File.open("index.html",[:write])
    code = :lexer.string(leerJs())
    |> elem(1)
    |> Enum.map(fn {token,_,value} ->
     compare(token,value)
    end)
    |>Enum.join()
    code = html(code)
    IO.write(file,code)
  end

end
