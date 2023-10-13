defmodule ConvertexWeb.SelectBaseNumber do
  use Phoenix.Component

  def render_select(assigns) do
    ~L"""
    <select name="<%= @name %>" id="<%= @id %>">
      <option value="dec">Decimal</option>
      <option value="hex">Hexadecimal</option>
      <option value="oct">Octal</option>
      <option value="bin">Binary</option>
    </select>
    """
  end
end
