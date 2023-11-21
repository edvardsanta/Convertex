defmodule ConvertexWeb.ConverterFactory do
  def convert(%{"from" => from, "to" => to}, value) do
    base_list = ["hex", "oct", "bin", "dec"]

    supported_conversions = %{
      %{"from" => "hex", "to" => "dec"} => &convert_hex_to_dec/1,
      %{"from" => "hex", "to" => "bin"} => &convert_hex_to_bin/1,
      %{"from" => "hex", "to" => "oct"} => &convert_hex_to_oct/1,
      %{"from" => "oct", "to" => "dec"} => &convert_oct_to_dec/1,
      %{"from" => "oct", "to" => "bin"} => &convert_oct_to_bin/1,
      %{"from" => "oct", "to" => "hex"} => &convert_oct_to_hex/1,
      %{"from" => "dec", "to" => "hex"} => &convert_dec_to_hex/1,
      %{"from" => "dec", "to" => "oct"} => &convert_dec_to_oct/1,
      %{"from" => "dec", "to" => "bin"} => &convert_dec_to_bin/1,
      %{"from" => "bin", "to" => "dec"} => &convert_bin_to_dec/1,
      %{"from" => "bin", "to" => "hex"} => &convert_bin_to_hex/1,
      %{"from" => "bin", "to" => "oct"} => &convert_bin_to_oct/1
    }

    if valid_bases?(from, base_list) and valid_bases?(to, base_list) do
      conversion_function = Map.get(supported_conversions, %{"from" => from, "to" => to}, nil)

      case conversion_function do
        nil ->
          {:error, "Unsupported conversion"}

        fun ->
          result = fun.(value)
          {:ok, result}
      end
    else
      {:error, "Invalid 'from' or 'to' value"}
    end
  end

  defp valid_bases?(base, supported_bases) do
    Enum.member?(supported_bases, base)
  end

  ## hex
  defp convert_hex_to_dec(value) do
    String.to_integer(value, 16)
  end

  defp convert_hex_to_bin(value) do
    case String.to_integer(value, 16) do
      num -> Integer.to_string(num, 2)
    end
  end

  defp convert_hex_to_oct(value) do
    case String.to_integer(value, 16) do
      num -> Integer.to_string(num, 8)
    end
  end

  ## oct
  defp convert_oct_to_dec(value) do
    String.to_integer(value, 8)
  end

  defp convert_oct_to_hex(value) do
    case String.to_integer(value, 8) do
      num -> Integer.to_string(num, 16)
    end
  end

  defp convert_oct_to_bin(value) do
    case String.to_integer(value, 8) do
      num -> Integer.to_string(num, 2)
    end
  end

  ## dec
  defp convert_dec_to_hex(value) do
    case Integer.parse(value) do
      {num, ""} -> Integer.to_string(num, 16)
      _ -> :error
    end
  end

  defp convert_dec_to_oct(value) do
    case Integer.parse(value) do
      {num, ""} -> Integer.to_string(num, 8)
      _ -> :error
    end
  end

  defp convert_dec_to_bin(value) do
    case Integer.parse(value) do
      {num, ""} -> Integer.to_string(num, 2)
      _ -> :error
    end
  end

  ## bin
  defp convert_bin_to_hex(value) do
    case String.to_integer(value, 2) do
      num -> Integer.to_string(num, 16)
    end
  end

  defp convert_bin_to_dec(value) do
    case String.to_integer(value, 2) do
      num -> Integer.to_string(num, 10)
    end
  end

  defp convert_bin_to_oct(value) do
    case String.to_integer(value, 2) do
      num -> Integer.to_string(num, 8)
    end
  end
end
