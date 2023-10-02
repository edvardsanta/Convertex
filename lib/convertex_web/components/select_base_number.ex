defmodule ConvertexWeb.SelectBaseNumber do
  use Phoenix.Component

  def render_select(assigns) do
    ~L"""
    <label for="<%= @name %>">Convert from:</label>
    <label for="from">Convert from:</label>
    <select name="<%= @name %>" id="<%= @id %>">
      <option value="decimal">Decimal</option>
      <option value="hexadecimal">Hexadecimal</option>
      <option value="octal">Octal</option>
      <option value="binary">Binary</option>
    </select>
    """
  end
end
