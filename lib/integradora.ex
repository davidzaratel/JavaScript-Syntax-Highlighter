defmodule Integradora do
  #convierte los elementos del archivo Js en charlist
  def leerJs(file) do
  File.read!(file)
  |> String.to_charlist
  end

  #Funcion compare que permite asignar HTML con su respectiva clase CSS a los elementos del archivo Js dependiendo de su token
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

  #Funcion html que realiza interpolacion en un string esqueleto de HTML
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

  def makecode(file) do
    :lexer.string(file)
    |> elem(1)
    |> Enum.map(fn {token,_,value} ->
     compare(token,value)
    end)
    |>Enum.join()
  end

  def makefile(file,read) do
    # {:ok, finalfile} = File.open(file,[:write])
      code = makecode(read)
      code = html(code)
      # IO.write(finalfile,code)
  end

  #sincronica
  def convertir(path) do
    for file <- File.ls!(path) do
      read = File.read!("#{path}/#{file}") |> String.to_charlist
      file = String.replace_suffix(file,".js",".html")
      makefile(file,read)
    end
  end


  # #paralela
  # def convertir(path) do
  #   for file <- File.ls!(path) do
  #     read = File.read!("#{path}/#{file}") |> String.to_charlist
  #     file = String.replace_suffix(file,".js",".html")
  #     makefile(file,read)
  #   end
  # end

  #paralela con Enum
  # def convertir(path) do
  #   file = "index.html"
  #   for file <- File.ls!(path) do
  #     File.read!("#{path}/#{file}")
  #     |> String.to_charlist
  #   end
  #   |> Enum.map(fn e -> Task.async(fn -> makefile(file,e) end) end)
  #   |> Enum.map(fn task -> Task.await(task) end)
  #   # file = String.replace_suffix(file,".js",".html")
  #   # makefile(file,read)
  # end



end
