defmodule Integradora do
  def leerJs do  #vuelve lista de listas todos los elementos del Js
  File.read!("test.js")
  |> String.to_charlist
  end

  def compare(:num,value), do: "<span class=numint>" <> (value |> to_string) <> "</span>"
  def compare(:float,value), do: "<span class=numint>" <> (value |> to_string) <> "</span>"
  def compare(:identifier,value), do: "<span class=identifier>" <> (value |> to_string) <> "</span>"
  def compare(:reserved,value), do: "<span class=reserved>" <> (value |> to_string) <> "</span>"
  def compare(:enter,_), do: "<br>"
  def compare(:commentline,value), do: "<span class=commentline>" <> (value |> to_string) <> "</span><br>"
  def compare(:signs,value), do: "<span class=signs>" <> (value |> to_string) <> "</span>"
  def compare(:space,value), do: "<span class=space>" <> (value |> to_string) <> "</span>"
  def compare(:string,value), do: "<span class=string>" <> (value |> to_string) <> "</span>"


  #hacer una funcion a llamar dentro del enum.map, la cual compare cual palabra es
  def convertir do
    {:ok, file} = File.open("index.html",[:write])
    IO.write(file," <link rel='stylesheet' href='styles.css'>")
    IO.write(file,"<pre>")
    IO.write(file,"<code>")
    html = :lexer.string(leerJs())
    |> elem(1)
    |> Enum.map(fn {token,_,value} ->
     compare(token,value)
    end)
    |>Enum.join()
    IO.write(file,html)
    IO.write(file,"</code>")
    IO.write(file,"</pre>")
  end

end
