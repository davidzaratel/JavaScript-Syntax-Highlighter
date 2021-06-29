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
      <title> Javascript Syntax Highlighter</title>
      <link rel='stylesheet' href='../css/styles.css'>
    </head>
    <body>
    <h1>Javascript Syntax Highlighter</h1>
    <h3> By: David Zarate Lopez A01329795</h3>
    <br>
    <pre><code>#{codigo}</code></pre>
    </body>
    </html>"
  end

  #funcion makecode, la cual identifica los tokens de cada palabra de los archivos para mandarlos a la funcion compare
  def makecode(file) do
    :lexer.string(file)
    |> elem(1)
    |> Enum.map(fn {token,_,value} ->
     compare(token,value)
    end)
    |>Enum.join()
  end

  #funcion make file, la cual crea los archivos .html y escribe en ellos el html generado por la funcion makecode
  def makefile(file,read) do
    {:ok, finalfile} = File.open(file,[:write])
      code = makecode(read)
      code = html(code)
      IO.write(finalfile,code)
  end

  #funcion que lee todos los archivos .js y los manda como charlist a la funcion makefile
  #esta funcion se realiza de manera sincronica
  #Para ejecutarse: Integradora.convertirseq("javascript"), se utiliza javascript como parametro ya que es la carpeta donde se encuentran los .js
  def convertirseq(path) do
    for file <- Path.wildcard("./#{path}/*")  do
      if String.ends_with?(file, ".js") do
        read = File.read!(file) |> String.to_charlist
        file = String.replace_suffix(file,".js",".html")
        file = String.replace_prefix(file, "#{path}/", "")
        makefile("html/#{file}",read)
      else
        convertirseq(file)
      end
    end
  end

  #funcion que lee todos los archivos .js y los manda como charlist a la funcion makefile
  #esta funcion se realiza de manera paralela
  #Para ejecutarse: Integradora.convertirseq("javascript"), se utiliza javascript como parametro ya que es la carpeta donde se encuentran los .js
  def convertirpar(path) do
    for file <- Path.wildcard("./#{path}/*")  do
      if String.ends_with?(file, ".js") do
        read = File.read!(file) |> String.to_charlist
        file = String.replace_suffix(file,".js",".html")
        file = String.replace_prefix(file, "#{path}/", "")
        Task.async(fn -> makefile("html/#{file}",read) end)
      else
        convertirseq(file)
      end
    end
  end


end
