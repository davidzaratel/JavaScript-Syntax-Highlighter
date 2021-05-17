defmodule Integradora do
  def leerTxt do  #vuelve lista de listas todos los elementos del txt
  File.read!("test.js")
  |> String.to_charlist
  # |> Enum.map(fn line -> String.split(line, ",") end)
  end


  def compare(token) do
    if token == :int do
      "int"
    else
      if token == :identifier do
        "identifier"
      else
        if token == :reserved do
          "reserved"
        else
          if token == :enter do
            "enter"
          else
            if token == :commentline do
              "commentline"
            else
              if token == :signs do
                "signs"
              else
                if token == :space do
                  "space"
                end
              end
            end
          end
        end
      end
    end
  end

  #hacer una funcion a llamar dentro del enum.map, la cual compare cual palabra es
  def convertir do
    :lexer.string(leerTxt())
    |> elem(1)
    |> Enum.map(fn {token,_,_} ->
      compare(token)
    end)
  end
end
