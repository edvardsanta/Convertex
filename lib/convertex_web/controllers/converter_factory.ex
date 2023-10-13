defmodule ConvertexWeb.ConverterFactory do
  def convert(%{"from" => from, "to" => to}, value) do
    base_list = ["hex", "oct", "bin", "dec"]

    supported_conversions = %{
      %{"from" => "hex", "to" => "dec"} => &convert_hex_to_dec/1,
      %{"from" => "oct", "to" => "dec"} => &convert_oct_to_dec/1,
      %{"from" => "dec", "to" => "hex"} => &convert_dec_to_hex/1,
      %{"from" => "dec", "to" => "oct"} => &convert_dec_to_oct/1,
      %{"from" => "dec", "to" => "bin"} => &convert_dec_to_bin/1
    }

    if valid_bases?(from, base_list) and valid_bases?(to, base_list) do
      conversion_function = Map.get(supported_conversions, %{"from" => from, "to" => to}, nil)

      case conversion_function do
        nil ->
          {:error, "Unsupported conversion"}

        fun ->
          num = String.to_integer(value)
          result = fun.(num)
          {:ok, result}
      end
    else
      {:error, "Invalid 'from' or 'to' value"}
    end
  end

  defp valid_bases?(base, supported_bases) do
    Enum.member?(supported_bases, base)
  end

  defp convert_hex_to_dec(value) do
  end

  defp convert_oct_to_dec(value) do
  end

  defp convert_dec_to_hex(value) do
    Integer.to_string(value, 16)
  end

  defp convert_dec_to_oct(value) do
    Integer.to_string(value, 8)
  end

  defp convert_dec_to_bin(value) do
    Integer.to_string(value, 2)
  end
end
